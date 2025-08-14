import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/group.dart';
import '../repositories/schedule_repository.dart';

class SearchGroupList extends UseCase<List<Group>, SearchGroupListParams> {
  SearchGroupList({required this.repository});

  final ScheduleRepository repository;

  @override
  Future<Either<Failure, List<Group>>> call(
    SearchGroupListParams params,
  ) async {
    return Right(
      params.groupList
          .where(
            (group) =>
                '${group.name} ${group.faculty.abbrev} ${group.speciality.abbrev} ${group.speciality.educationFormName} ${group.course} ${params.words['course']} ${group.speciality.code}'
                    .toLowerCase()
                    .contains(params.query.toLowerCase()),
          )
          .toList(),
    );
  }
}

class SearchGroupListParams extends Equatable {
  const SearchGroupListParams({
    required this.groupList,
    required this.query,
    required this.words,
  });

  final List<Group> groupList;
  final String query;
  final Map<String, String> words;

  @override
  List<Object?> get props => [groupList, query, words];
}
