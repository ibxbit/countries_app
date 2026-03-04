import 'package:flutter/material.dart';

final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier<ThemeMode>(
  ThemeMode.system,
);

void toggleThemeMode() {
  final current = themeModeNotifier.value;
  if (current == ThemeMode.dark) {
    themeModeNotifier.value = ThemeMode.light;
  } else {
    themeModeNotifier.value = ThemeMode.dark;
  }
}
