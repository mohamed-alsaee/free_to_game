import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:free_to_game/widgets/game_card.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1 / 1.5,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return GameCard();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          if (kDebugMode) {
            print("INDEX $index");
          }
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.language, size: 40),
            label: "Browser",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.laptop, size: 40),
            label: "PC",
          ),
        ],
      ),
    );
  }
}
