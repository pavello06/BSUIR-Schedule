// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String courseNumber(Object number) {
    return '$number курс';
  }

  @override
  String schedule_weekNumber(Object number) {
    return '$number неделя';
  }

  @override
  String get schedule_info => 'Информация';

  @override
  String schedule_faculty(Object faculty) {
    return 'Факультет: $faculty';
  }

  @override
  String schedule_speciality(Object speciality) {
    return 'Специальность: $speciality';
  }

  @override
  String schedule_course(Object course) {
    return 'Курс: $course';
  }

  @override
  String schedule_educationForm(Object educationForm) {
    return 'Форма обучения: $educationForm';
  }

  @override
  String schedule_specialityCode(Object specialityCode) {
    return 'Код специальности: $specialityCode';
  }

  @override
  String schedule_termExist(Object endDate, Object startDate) {
    return 'Семестр: с $startDate по $endDate';
  }

  @override
  String schedule_sessionExist(Object endDate, Object startDate) {
    return 'Сессия: с $startDate по $endDate';
  }

  @override
  String get schedule_examsExist => 'Экзамены: добавлено';

  @override
  String get schedule_examsNotExist => 'Экзамены: не добавлено';

  @override
  String schedule_degree(Object degree) {
    return 'Степень: $degree';
  }

  @override
  String schedule_rank(Object rank) {
    return 'Ранг: $rank';
  }

  @override
  String schedule_email(Object email) {
    return 'Email: $email';
  }

  @override
  String get mySchedules => 'Мои расписания';

  @override
  String get savedSchedulesEmpty => 'Вы не добавили ещё ни одного расписания';

  @override
  String get addingSchedule => 'Добавление расписания';

  @override
  String get groups => 'Группы';

  @override
  String get teachers => 'Преподаватели';

  @override
  String get search => 'Поиск';

  @override
  String get course => 'курс';

  @override
  String foundedGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Найдено $count групп',
      many: 'Найдено $count групп',
      few: 'Найдено $count группы',
      one: 'Найдена $count группа',
      zero: 'Найдено $count групп',
    );
    return '$_temp0';
  }

  @override
  String foundedTeachers(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Найдено $count преподавателей',
      many: 'Найдено $count преподавателей',
      few: 'Найдено $count преподавателя',
      one: 'Найден $count преподаватель',
      zero: 'Найдено $count преподавателей',
    );
    return '$_temp0';
  }

  @override
  String get searchEmpty =>
      'Не удалось загрузить расписание\nПотяните вниз, чтобы обновить';

  @override
  String get searchSuccess => 'Данные загружены';

  @override
  String get searchError => 'Данные не загружены';
}
