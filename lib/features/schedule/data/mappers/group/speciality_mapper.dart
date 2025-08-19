import '../../../domain/entities/group/speciality.dart';
import '../../models/group/education_form_model.dart';
import '../../models/group/speciality_model.dart';

class SpecialityMapper {
  static Speciality toEntity({required SpecialityModel speciality}) {
    return Speciality(
      id: speciality.id,
      name: speciality.name,
      abbrev: speciality.abbrev,
      educationFormName: speciality.educationForm.name,
      code: speciality.code,
    );
  }

  static SpecialityModel toModel({required Speciality speciality}) {
    return SpecialityModel(
      id: speciality.id,
      name: speciality.name,
      abbrev: speciality.abbrev,
      educationForm: EducationFormModel(name: speciality.educationFormName),
      code: speciality.code,
    );
  }
}
