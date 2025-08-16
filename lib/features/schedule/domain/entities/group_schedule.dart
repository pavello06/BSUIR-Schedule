import 'group.dart';
import 'schedule.dart';

class GroupSchedule extends Schedule {
  const GroupSchedule({
    required super.lessons,
    required super.exams,
    required super.lessonsStartDate,
    required super.lessonsEndDate,
    required this.examsStartDate,
    required this.examsEndDate,
    required this.group,
  });

  final DateTime examsStartDate;
  final DateTime examsEndDate;
  final Group group;

  @override
  List<Object?> get props => [...super.props, examsStartDate, examsEndDate, group];
}
