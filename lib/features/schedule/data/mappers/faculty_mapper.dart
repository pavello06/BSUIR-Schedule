import '../../domain/entities/faculty.dart';
import '../models/faculty_model.dart';

class FacultyMapper {
  static Faculty toEntity({required FacultyModel faculty}) {
    return Faculty(name: faculty.name, abbrev: faculty.abbrev);
  }
}
