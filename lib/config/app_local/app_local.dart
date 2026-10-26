import 'package:flutter/material.dart';
import 'package:troond/l10n/app_localizations.dart';

class MyLocalizations {
 static AppLocalizations getLocal(BuildContext context) {
    AppLocalizations appLocal = AppLocalizations.of(context)!;
    return appLocal;
  }
}