import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this)!;

  ThemeData get theme => Theme.of(this);
}