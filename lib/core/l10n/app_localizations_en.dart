// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String courseNumber(Object number) {
    return '$number course';
  }

  @override
  String schedule_weekNumber(Object number) {
    return '$number week';
  }

  @override
  String get schedule_info => 'Information';

  @override
  String schedule_faculty(Object faculty) {
    return 'Faculty: $faculty';
  }

  @override
  String schedule_speciality(Object speciality) {
    return 'Speciality: $speciality';
  }

  @override
  String schedule_course(Object course) {
    return 'Course: $course';
  }

  @override
  String schedule_educationForm(Object educationForm) {
    return 'Education form: $educationForm';
  }

  @override
  String schedule_specialityCode(Object specialityCode) {
    return 'Speciality code: $specialityCode';
  }

  @override
  String schedule_termExist(Object endDate, Object startDate) {
    return 'Semester: from $startDate to $endDate';
  }

  @override
  String schedule_sessionExist(Object endDate, Object startDate) {
    return 'Session: from $startDate to $endDate';
  }

  @override
  String get schedule_examsExist => 'Exams: added';

  @override
  String get schedule_examsNotExist => 'Exams: not added';

  @override
  String schedule_degree(Object degree) {
    return 'Degree: $degree';
  }

  @override
  String schedule_rank(Object rank) {
    return 'Rank: $rank';
  }

  @override
  String schedule_email(Object email) {
    return 'Email: $email';
  }

  @override
  String schedules_numSubGroup(Object number) {
    return 'subgr. $number';
  }

  @override
  String get mySchedules => 'My schedules';

  @override
  String get savedSchedulesEmpty => 'You haven\'t added any schedules yet';

  @override
  String get addingSchedule => 'Adding a schedule';

  @override
  String get groups => 'Groups';

  @override
  String get teachers => 'Teachers';

  @override
  String get search => 'Search';

  @override
  String get course => 'course';

  @override
  String foundedGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count groups found',
      one: '$count group found',
      zero: '$count groups found',
    );
    return '$_temp0';
  }

  @override
  String foundedTeachers(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count teachers found',
      one: '$count teacher found',
      zero: '$count teachers found',
    );
    return '$_temp0';
  }

  @override
  String get searchEmpty => 'Couldn\'t load schedule\nPull down to update';

  @override
  String get searchSuccess => 'The data has been uploaded';

  @override
  String get searchError => 'The data has not been uploaded';
}
