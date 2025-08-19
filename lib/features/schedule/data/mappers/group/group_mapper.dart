import '../../../domain/entities/group/group.dart';
import '../../models/group/faculty_model.dart';
import '../../models/group/group_model.dart';
import '../../models/group/speciality_model.dart';
import 'faculty_mapper.dart';
import 'speciality_mapper.dart';

class GroupMapper {
  static Group toEntity({
    required GroupModel group,
    required FacultyModel faculty,
    required SpecialityModel speciality,
  }) {
    return Group(
      name: group.name,
      faculty: FacultyMapper.toEntity(faculty: faculty),
      speciality: SpecialityMapper.toEntity(speciality: speciality),
      course: group.course!,
      numberOfStudents: null,
    );
  }

  static GroupModel toModel({required Group group}) {
    return GroupModel(
      name: group.name,
      facultyId: group.faculty.id,
      specialityDepartmentEducationFormId: group.speciality.id,
      course: group.course,
    );
  }
}
