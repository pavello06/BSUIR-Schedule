import '../../domain/entities/speciality.dart';
import '../models/speciality_model.dart';

class SpecialityMapper {
  static Speciality toEntity({required SpecialityModel speciality}) {
    return Speciality(
      name: speciality.name,
      abbrev: speciality.abbrev,
      educationFormName: speciality.educationForm.name,
      code: speciality.code,
    );
  }
}
