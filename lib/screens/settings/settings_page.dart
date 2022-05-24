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

    void toggleThemeMode(bool value, WidgetRef ref) {
      if (value) {
        ref.read(themeModeProvider.state).state = ThemeMode.dark;
      } else {
        ref.read(themeModeProvider.state).state = ThemeMode.light;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
        toolbarHeight: 64,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: Theme.of(context).textTheme.headline6,
            ),
            Divider(),
            Row(
              children: [
                Text('Dark Mode'),
                Spacer(),
                Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    toggleThemeMode(value, ref);
                  },
                )
              ],
            ),
            Divider(),
            Text(
              'About',
              style: Theme.of(context).textTheme.headline6,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
