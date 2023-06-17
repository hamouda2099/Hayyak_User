import 'package:hayyak/Models/settings_model.dart';
import 'package:hayyak/Models/translation_model.dart';

class UserData {
  static String token = '';
  static num id = 0;
  static String userName = '';
  static String phone = '';
  static String imageUrl = '';
  static String role = '';
  static String email = '';
  static String language = 'en';
  static TranslationModel translation = TranslationModel();
  static SettingsModel settings = SettingsModel();
  static num reservationTimer = 0;
}
