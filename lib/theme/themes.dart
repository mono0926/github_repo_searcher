import 'package:flutter/material.dart';

import 'extensions/app_colors.dart';

export 'theme_mode/theme_mode_provider.dart';
export 'theme_mode/theme_mode_selector.dart';

extension ThemeDataX on ThemeData {
  AppColors get appColors => extension<AppColors>()!;
}

class Themes {
  Themes._();

  static final light = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    useMaterial3: true,
  ).copyWith(
    extensions: [
      AppColors.light,
    ],
    bottomNavigationBarTheme: _bottomNavigationBarTheme,
    dividerTheme: _dividerTheme,
  );

  static final dark = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  ).copyWith(
    extensions: [
      AppColors.dark,
    ],
    bottomNavigationBarTheme: _bottomNavigationBarTheme,
    dividerTheme: _dividerTheme,
  );

  static const _bottomNavigationBarTheme = BottomNavigationBarThemeData(
    selectedLabelStyle: TextStyle(
      fontSize: 12,
    ),
  );

  static const _dividerTheme = DividerThemeData(
    space: 0,
  );
}
