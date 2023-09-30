import 'package:hayyak/Models/settings_model.dart';
import 'package:hayyak/Models/translation_model.dart';

class UserData {
  static String? token = '';
  static num? id;
  static String? userName = '';
  static String? phone = '';
  static String? imageUrl = '';
  static String? role = '';
  static String? email = '';
  static String? language = '';
  static TranslationModel translation = TranslationModel();
  static SettingsModel settings = SettingsModel();
  static num reservationTimer = 0;
  static String? moyasarPublishableKey;
  static String? moyasarSecretKey;
  static String? hayyakPhone;
  static String? site;
  static String? facebook;
  static String? insta;
  static String? twitter;
  static String? gmail;
  static String? linkedIn;
  static String? hayyakAddress;
}
