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
