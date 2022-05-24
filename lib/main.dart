import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/screens/home_page.dart';
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
      theme: ThemeData(
          primaryColor: Colors.orange,
          appBarTheme: AppBarTheme(toolbarHeight: 15),
          primarySwatch: Colors.orange,
          iconTheme: IconThemeData(
            color: Colors.orange,
          )),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(toolbarHeight: 15),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent))),
        primaryColorDark: Colors.orangeAccent,
      ),
      themeMode: themeMode,
      home: const HomePage(),
    );
  }
}
