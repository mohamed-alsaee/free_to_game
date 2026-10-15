import 'package:flutter/material.dart';
import 'package:free_to_game/providers/games_provider.dart';
import 'package:free_to_game/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => GamesProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Free To Game',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepOrange)),
        home: HomeScreen(),
      ),
    );
  }
}
