import 'package:get/get.dart';
import 'package:cookbook/styles/thems.dart';
import 'package:cookbook/local/cashhelper.dart';


var isDarkMode = false.obs;

void onchangeThem() {
  //! using Get
  if (Get.isDarkMode) {
    Get.changeTheme(Themes.lightTheme);
    print("light");
    CashHelper.setTheme(key: "isdark", value: false);
  } else {
    Get.changeTheme(Themes.darkThem);
    print("dark");
    CashHelper.setTheme(key: "isdark", value: true);
  }
}
// class ThemeService {
//   final _box = GetStorage();
//   final _key = "isDarkMode";
//
//   _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);
//
//   bool _loadThemeFormBox() => _box.read(_key) ?? true;
//   ThemeMode get theme => _loadThemeFormBox() ? ThemeMode.light : ThemeMode.dark;
//
//   void switchTheme() {
//     bool isDarkMode = !_loadThemeFormBox();
//     Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
//     _saveThemeToBox(isDarkMode);
//   }
// }