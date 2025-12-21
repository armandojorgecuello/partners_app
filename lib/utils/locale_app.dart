import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honey_iou_updated/src/models/user_model.dart';
import 'package:yaml/yaml.dart';

class AppLocalizations {
  final String? localeName;
  YamlMap? translation;

  AppLocalizations(this.localeName, this.translation);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Future load() async {
    String yamlString = await rootBundle.loadString('lang/$localeName.yml');
    translation = loadYaml(yamlString);
  }

  dynamic t(String key) {
    try {
      var keys = key.split(".");
      dynamic translated = translation;
      for (var k in keys) {
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

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    String lang = locale.languageCode;
    // print(locale.languageCode);
    // UsuarioProvider(lang: locale.languageCode);
    Lang.lang = lang;
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    var t = AppLocalizations(locale.languageCode, null);
    await t.load();
    return t;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
