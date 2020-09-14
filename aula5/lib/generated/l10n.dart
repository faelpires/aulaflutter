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

  /// `Product`
  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `ok`
  String get ok {
    return Intl.message(
      'ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Saved successfully!`
  String get savedSuccessfully {
    return Intl.message(
      'Saved successfully!',
      name: 'savedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `The data could not be saved.`
  String get failSaveData {
    return Intl.message(
      'The data could not be saved.',
      name: 'failSaveData',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load data`
  String get failLoadData {
    return Intl.message(
      'Failed to load data',
      name: 'failLoadData',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `There is no data to display`
  String get noData {
    return Intl.message(
      'There is no data to display',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `The field is mandatory.`
  String get mandatoryField {
    return Intl.message(
      'The field is mandatory.',
      name: 'mandatoryField',
      desc: '',
      args: [],
    );
  }

  /// `Confirm the deletion? This action cannot be undone.`
  String get confirmDeletion {
    return Intl.message(
      'Confirm the deletion? This action cannot be undone.',
      name: 'confirmDeletion',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get productPageName {
    return Intl.message(
      'Name',
      name: 'productPageName',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get productPageBrand {
    return Intl.message(
      'Brand',
      name: 'productPageBrand',
      desc: '',
      args: [],
    );
  }

  /// `Image Url`
  String get productPageImageUrl {
    return Intl.message(
      'Image Url',
      name: 'productPageImageUrl',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
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