// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `График работы`
  String get workSchedule {
    return Intl.message(
      'График работы',
      name: 'workSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Проблемы с интернетом`
  String get netError {
    return Intl.message(
      'Проблемы с интернетом',
      name: 'netError',
      desc: '',
      args: [],
    );
  }

  /// `Расписание обновлено`
  String get scheduleUpdated {
    return Intl.message(
      'Расписание обновлено',
      name: 'scheduleUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Укажите время, когда вы доступны для звонков и сможете быстро отвечать пациентам`
  String get specifiedTime {
    return Intl.message(
      'Укажите время, когда вы доступны для звонков и сможете быстро отвечать пациентам',
      name: 'specifiedTime',
      desc: '',
      args: [],
    );
  }

  /// `Добавить временной промежуток`
  String get addInterval {
    return Intl.message(
      'Добавить временной промежуток',
      name: 'addInterval',
      desc: '',
      args: [],
    );
  }

  /// `Понедельник`
  String get monday {
    return Intl.message(
      'Понедельник',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Вторник`
  String get tuesday {
    return Intl.message(
      'Вторник',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Среда`
  String get wednesday {
    return Intl.message(
      'Среда',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Четверг`
  String get thursday {
    return Intl.message(
      'Четверг',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `Пятница`
  String get friday {
    return Intl.message(
      'Пятница',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `Суббота`
  String get saturday {
    return Intl.message(
      'Суббота',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `Воскресенье`
  String get sunday {
    return Intl.message(
      'Воскресенье',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `Готово`
  String get done {
    return Intl.message(
      'Готово',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Press`
  String get press {
    return Intl.message(
      'Press',
      name: 'press',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}