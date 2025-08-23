import '../../../domain/entities/employee/employee.dart';
import '../../models/employee/employee_model.dart';

class EmployeeMapper {
  static Employee toEntity({required EmployeeModel employee}) {
    return Employee(
      firstName: employee.firstName,
      lastName: employee.lastName,
      middleName: employee.middleName,
      degreeAbbrev: employee.degree.isEmpty ? null : employee.degree,
      rank: employee.rank,
      photoLink: employee.photoLink,
      academicDepartment: employee.academicDepartment,
      urlId: employee.urlId,
      email: null,
    );
  }

  static EmployeeModel toModel({required Employee employee}) {
    return EmployeeModel(
      firstName: employee.firstName,
      lastName: employee.lastName,
      middleName: employee.middleName,
      degree: employee.degreeAbbrev ?? '',
      rank: employee.rank,
      photoLink: employee.photoLink,
      academicDepartment: employee.academicDepartment!,
      urlId: employee.urlId,
    );
  }
}
