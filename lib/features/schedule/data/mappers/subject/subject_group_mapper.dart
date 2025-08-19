import '../../../domain/entities/group/group.dart';
import '../../models/subject/subject_group_model.dart';

class SubjectGroupMapper {
  static Group toEntity({required SubjectGroupModel group, required Map<String, Group> groupMap}) {
    return Group(
      name: group.name,
      faculty: groupMap[group.name]!.faculty,
      speciality: groupMap[group.name]!.speciality,
      course: groupMap[group.name]!.course,
      numberOfStudents: group.numberOfStudents,
    );
  }
}
