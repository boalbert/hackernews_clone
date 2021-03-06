import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/screens/home_page.dart';
import 'package:hackernews/theme/lib_color_schemes.g.dart';
import 'package:hackernews/theme/theme_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: CustomTheme.lightColorScheme,
      ),
      darkTheme: ThemeData.from(
        colorScheme: CustomTheme.darkColorScheme,
      ),
      themeMode: themeMode,
      home: const HomePage(),
    );
  }
}
