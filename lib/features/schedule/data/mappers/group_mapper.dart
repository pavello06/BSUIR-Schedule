import '../../domain/entities/group.dart';
import '../models/faculty_model.dart';
import '../models/speciality_model.dart';
import '../models/group_model.dart';
import 'faculty_mapper.dart';
import 'speciality_mapper.dart';

class GroupMapper {
  static Group toEntity({
    required GroupModel group,
    required FacultyModel faculty,
    required SpecialityModel speciality,
  }) {
    return Group(
      name: group.name!,
      faculty: FacultyMapper.toEntity(faculty: faculty),
      speciality: SpecialityMapper.toEntity(speciality: speciality),
      course: group.course!,
      numberOfStudents: null,
    );
  }

  static GroupModel toModel({required Group group}) {
    return GroupModel(
      name: group.name,
      facultyId: null,
      facultyAbbrev: null,
      facultyName: null,
      specialityDepartmentEducationFormId: null,
      specialityName: null,
      specialityAbbrev: null,
      course: group.course,
      id: null,
      calendarId: null,
      educationDegree: null,
    );
  }
}
