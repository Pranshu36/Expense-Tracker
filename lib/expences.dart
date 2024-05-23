import 'package:flutter/material.dart';
import 'package:etracker/homescreen.dart';

var colorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 96, 59, 181),
);

var darkcolorscheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 5, 99, 125),
);

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() {
    return _ExpencesState();
  }
}

class _ExpencesState extends State<Expences> {
  @override
  Widget build(context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: darkcolorscheme,
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color.fromARGB(255, 21, 21, 21)),
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: Color.fromARGB(255, 2, 35, 44),
          foregroundColor: darkcolorscheme.onPrimaryContainer,
        ),
        cardTheme: CardTheme().copyWith(
          color: Color.fromARGB(255, 5, 99, 125),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 2, 64, 81),foregroundColor: Color.fromARGB(255, 63, 192, 227),),
        ),
        
        textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Color.fromARGB(255, 63, 192, 227),),)
      ),
      theme: ThemeData().copyWith(
        colorScheme: colorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: colorScheme.onPrimaryContainer,
          foregroundColor: colorScheme.primaryContainer,
        ),
        cardTheme: CardTheme().copyWith(
          color: colorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: colorScheme.onSecondaryContainer,
              ),
            ),
      ),
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Homescreen(),
      ),
    );
  }
}
