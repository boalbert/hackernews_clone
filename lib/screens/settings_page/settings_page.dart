import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/theme/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Dark Mode",
              style: TextStyle(fontSize: 28),
            ),
            CupertinoSwitch(
                value: isDarkMode,
                onChanged: (value) {
                  if (value) {
                    ref.read(themeModeProvider.state).state = ThemeMode.dark;
                  } else {
                    ref.read(themeModeProvider.state).state = ThemeMode.light;
                  }
                })
          ],
        ),
      ),
    );
  }
}
