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
