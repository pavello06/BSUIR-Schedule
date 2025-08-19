import 'package:flutter/material.dart';

import '../widgets/schedule_widgets/schedule_app_bar_widget.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScheduleAppBarWidget(week: 1,),
      body: Column(
        children: [
          // SearchFilterWidget(pageController: _pageController),
          //
          // const SizedBox(height: 5),
          //
          // Expanded(
          //   child: Padding(
          //     padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          //     child: BlocBuilder<SearchBloc, SearchState>(
          //       builder: (context, state) {
          //         return processState(context, state);
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // Widget processState(BuildContext context, SearchState state) {
  //   Widget widgetForGroup = Container(), widgetForEmployee = Container();
  //
  //   if (state is InitialState) {
  //     context.read<SearchBloc>().add(GetListsEvent());
  //   } else if (state is LoadingState) {
  //     widgetForGroup = getLoadingListWidget(context, state as WithListsState, true);
  //     widgetForEmployee = getLoadingListWidget(context, state, false);
  //   } else if (state is LoadedState) {
  //     widgetForGroup = getListWidget(context, state as WithListsState, true);
  //     widgetForEmployee = getListWidget(context, state, false);
  //   } else if (state is EmptyState) {
  //     final widget = getEmptyWidget(context);
  //
  //     widgetForGroup = widget;
  //     widgetForEmployee = widget;
  //   }
  //
  //   if (state is LoadedState && state.hasError != null && !state.hasError!) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       DialogUtil.showSnackBar(
  //         context,
  //         Icon(Icons.check_circle, color: AppColors.green),
  //         context.locale.searchSuccess,
  //       );
  //     });
  //   } else if (state is LoadedState && state.hasError != null && state.hasError! ||
  //       state is EmptyState) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       DialogUtil.showSnackBar(
  //         context,
  //         Icon(Icons.error, color: AppColors.red),
  //         context.locale.searchError,
  //       );
  //     });
  //   }
  //
  //   return PageView(
  //     controller: _pageController,
  //     children: [
  //       getRefreshIndicatorWidget(context, widgetForGroup),
  //       getRefreshIndicatorWidget(context, widgetForEmployee),
  //     ],
  //   );
  // }
}
