import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/group.dart';
import '../repositories/schedule_repository.dart';

class SearchGroups extends UseCase<List<Group>, SearchGroupsParams> {
  SearchGroups({required this.repository});

  final ScheduleRepository repository;

  @override
  Future<Either<Failure, List<Group>>> call(SearchGroupsParams params) async {
    return Right(
      params.groups
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

class SearchGroupsParams extends Equatable {
  const SearchGroupsParams({required this.groups, required this.query, required this.words});

  final List<Group> groups;
  final String query;
  final Map<String, String> words;

  @override
  List<Object?> get props => [groups, query, words];
}
