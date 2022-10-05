import 'package:get/get.dart';

class LocalStrings extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "Hello_World": "Hello World",
          "Login": "Log In",
          "Set_Profile": "Set Profile",
          "Fullname": "Full Name",
          "Guardian": "Guardian",
        },
        'ur_PK': {
          "Hello_World": "ہیلو دنیا",
          "Login": "لاگ ان",
          "Set_Profile": "پروفائل بنائیں",
          "Fullname": "پورا نام",
          "Guardian": "سربراہ",
        }
      };
}
