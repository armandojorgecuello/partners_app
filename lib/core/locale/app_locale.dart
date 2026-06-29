import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

/// Currently active language code, mirrored from [AppLocalizations] so
/// non-widget code (data layer writes that store a `lang` field) can read it.
class Lang {
  static String? lang;
}

class AppLocalizations {
  final String? localeName;
  YamlMap? translation;

  AppLocalizations(this.localeName, this.translation);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  Future<void> load() async {
    final yamlString = await rootBundle.loadString('lang/$localeName.yml');
    translation = loadYaml(yamlString);
  }

  dynamic t(String key) {
    try {
      final keys = key.split('.');
      dynamic translated = translation;
      for (final k in keys) {
        translated = translated[k];
      }
      if (translated == null) {
        return 'Key not Found: $key ';
      }
      return translated;
    } catch (e) {
      return 'Key not Found: $key ';
    }
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final lang = locale.languageCode;
    Lang.lang = lang;
    return ['en', 'es'].contains(lang);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final t = AppLocalizations(locale.languageCode, null);
    await t.load();
    return t;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
