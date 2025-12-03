import 'package:admin_panel/utils/colors.dart';
import 'package:flutter/material.dart';
abstract final class AppTheme{
  static const textTheme=TextTheme(

  );
  static ThemeData lightTheme=ThemeData(
    brightness: .light,
    colorScheme: AppColors.lightColorSheme
  );
  static ThemeData darkTheme=ThemeData(
    brightness: .dark,
    colorScheme: AppColors.darkColorScheme
  );
}