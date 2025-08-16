import '../../domain/entities/speciality.dart';
import '../models/education_form_model.dart';
import '../models/speciality_model.dart';

class SpecialityMapper {
  static Speciality toEntity({required SpecialityModel speciality}) {
    return Speciality(
      id: speciality.id!,
      name: speciality.name!,
      abbrev: speciality.abbrev!,
      educationFormName: speciality.educationForm!.name!,
      code: speciality.code!,
    );
  }

  static SpecialityModel toModel({required Speciality speciality}) {
    return SpecialityModel(
      id: speciality.id,
      name: speciality.name,
      abbrev: speciality.abbrev,
      educationForm: EducationFormModel(id: null, name: speciality.educationFormName),
      facultyId: null,
      code: speciality.code,
    );
  }
}
