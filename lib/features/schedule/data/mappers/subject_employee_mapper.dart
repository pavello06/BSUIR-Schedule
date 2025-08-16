import '../../domain/entities/employee.dart';
import '../models/subject_employee_model.dart';

class SubjectEmployeeMapper {
  static Employee toEntity({required SubjectEmployeeModel employee}) {
    return Employee(
      firstName: employee.firstName!,
      lastName: employee.lastName!,
      middleName: employee.middleName,
      degreeAbbrev: employee.degreeAbbrev!,
      rank: employee.rank,
      photoLink: employee.photoLink!,
      academicDepartment: null,
      urlId: employee.urlId!,
      email: employee.email,
    );
  }
}
