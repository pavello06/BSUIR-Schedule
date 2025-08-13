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
      name: group.name,
      faculty: FacultyMapper.toEntity(faculty: faculty),
      speciality: SpecialityMapper.toEntity(speciality: speciality),
      course: group.course!,
      numberOfStudents: null,
    );
  }
}
