import '../employee/employee.dart';
import 'schedule.dart';

class EmployeeSchedule extends Schedule {
  const EmployeeSchedule({
    required super.title,
    required super.lessons,
    required super.lessonFilter,
    required super.exams,
    required super.examFilter,
    required super.lessonsStartDate,
    required super.lessonsEndDate,
    required this.employee,
  });

  final Employee employee;

  @override
  List<Object?> get props => [...super.props, employee];
}
