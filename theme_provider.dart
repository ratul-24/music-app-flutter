import 'package:flutter/material.dart';
import 'package:music/dark_theme.dart';
import 'package:music/light_theme.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData=light;

  ThemeData get themeData => _themeData;

  bool get isDark => _themeData == dark;

  set themeData(ThemeData themeData){
    _themeData=themeData;
    notifyListeners();
  }

  void toggle(){
    if(_themeData==light){
      themeData=dark;
    } else{
      themeData=light;
    }
  }


}