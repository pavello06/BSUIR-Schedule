import 'employee.dart';
import 'schedule.dart';

class EmployeeSchedule extends Schedule {
  const EmployeeSchedule({
    required super.lessons,
    required super.exams,
    required super.lessonsStartDate,
    required super.lessonsEndDate,
    required this.employee,
  });

  final Employee employee;

  @override
  List<Object?> get props => [...super.props, employee];
}
