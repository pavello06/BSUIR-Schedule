import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/extensions/build_context_extension.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/dialog_util.dart';
import '../bloc/search_bloc/search_bloc.dart';
import '../bloc/search_bloc/search_event.dart';
import '../bloc/search_bloc/search_state.dart';
import '../widgets/employee_card_widget.dart';
import '../widgets/group_card_widget.dart';
import '../widgets/search_widgets/search_app_bar_widget.dart';
import '../widgets/search_widgets/search_filter_widget.dart';
import '../widgets/search_widgets/search_text_field_widget.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final _pageController = PageController();
  final _textEditingControllers = [TextEditingController(), TextEditingController()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBarWidget(),
      body: Column(
        children: [
          SearchFilterWidget(pageController: _pageController),

          const SizedBox(height: 5),

          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return processState(context, state);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget processState(BuildContext context, SearchState state) {
    Widget widgetForGroup = Container(), widgetForEmployee = Container();

    if (state is InitialState) {
      context.read<SearchBloc>().add(GetListsEvent());
    } else if (state is LoadingState) {
      widgetForGroup = getLoadingListWidget(context, state as WithListsState, true);
      widgetForEmployee = getLoadingListWidget(context, state, false);
    } else if (state is LoadedState) {
      widgetForGroup = getListWidget(context, state as WithListsState, true);
      widgetForEmployee = getListWidget(context, state, false);
    } else if (state is EmptyState) {
      final widget = getEmptyWidget(context);

      widgetForGroup = widget;
      widgetForEmployee = widget;
    }

    if (state is LoadedState && state.hasError != null && !state.hasError!) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DialogUtil.showSnackBar(
          context,
          Icon(Icons.check_circle, color: AppColors.green),
          context.locale.searchSuccess,
        );
      });
    } else if (state is LoadedState && state.hasError != null && state.hasError! ||
        state is EmptyState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DialogUtil.showSnackBar(
          context,
          Icon(Icons.error, color: AppColors.red),
          context.locale.searchError,
        );
      });
    }

    return PageView(
      controller: _pageController,
      children: [
        getRefreshIndicatorWidget(context, widgetForGroup),
        getRefreshIndicatorWidget(context, widgetForEmployee),
      ],
    );
  }

  Widget getRefreshIndicatorWidget(BuildContext context, Widget widget) {
    return RefreshIndicator(
      displacement: 40,
      onRefresh: () async {
        context.read<SearchBloc>().add(UpdateListsEvent());
      },
      color: AppColors.foregroundColor,
      backgroundColor: context.theme.primaryColor,
      child: widget,
    );
  }

  Widget getLoadingListWidget(BuildContext context, WithListsState state, bool isGroup) {
    return Stack(
      children: [
        if ((state as LoadingState).hasData) getListWidget(context, state, isGroup),
        Positioned(
          top: 40,
          child: Container(
            width: mq.width - 20,
            alignment: Alignment.center,
            child: RefreshProgressIndicator(
              color: AppColors.foregroundColor,
              backgroundColor: context.theme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget getListWidget(BuildContext context, WithListsState state, bool isGroup) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SearchTextFieldWidget(
          isGroup: isGroup,
          state: state,
          textEditingController: _textEditingControllers[isGroup ? 0 : 1],
        ),

        const SizedBox(height: 5),

        Text(
          isGroup
              ? context.locale.foundedGroups(state.foundedGroups!.length)
              : context.locale.foundedTeachers(state.foundedEmployees!.length),
        ),

        const SizedBox(height: 5),

        Expanded(
          child: ListView.builder(
            itemCount: isGroup ? state.foundedGroups!.length : state.foundedEmployees!.length,
            itemBuilder: (BuildContext context, int index) {
              return isGroup
                  ? GroupCardWidget(
                      group: state.foundedGroups![index],
                      onTap: () {
                        context.read<SearchBloc>().add(
                          SaveScheduleEvent(
                            isGroup: true,
                            group: state.foundedGroups![index],
                            query: state.foundedGroups![index].name,
                          ),
                        );
                      },
                    )
                  : EmployeeCardWidget(
                      employee: state.foundedEmployees![index],
                      onTap: () {
                        context.read<SearchBloc>().add(
                          SaveScheduleEvent(
                            isGroup: false,
                            employee: state.foundedEmployees![index],
                            query: state.foundedEmployees![index].urlId,
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ],
    );
  }

  Widget getEmptyWidget(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.update_disabled, size: 90),

              SizedBox(height: 20),

              Text(
                context.locale.searchEmpty,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        ListView(),
      ],
    );
  }
}
