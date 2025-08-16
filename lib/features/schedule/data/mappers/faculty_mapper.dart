import '../../domain/entities/faculty.dart';
import '../models/faculty_model.dart';

class FacultyMapper {
  static Faculty toEntity({required FacultyModel faculty}) {
    return Faculty(name: faculty.name!, abbrev: faculty.abbrev!, id: faculty.id!);
  }

  static FacultyModel toModel({required Faculty faculty}) {
    return FacultyModel(name: faculty.name, abbrev: faculty.abbrev, id: faculty.id);
  }
}
