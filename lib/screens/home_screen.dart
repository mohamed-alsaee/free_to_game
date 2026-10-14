import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:free_to_game/providers/games_provider.dart';
import 'package:free_to_game/widgets/game_card.dart';
import 'package:free_to_game/widgets/shimmers/game_shimmer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    Provider.of<GamesProvider>(context, listen: false).getGames("all");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GamesProvider>(
      builder: (context, gamesConsumer, _) {
        return Scaffold(
          appBar: AppBar(),
          body: AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1 / 1.5,
              ),
              itemCount: gamesConsumer.busy
                  ? 6
                  : gamesConsumer.gamesList.length,
              itemBuilder: (context, index) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: gamesConsumer.busy
                      ? GameShimmer()
                      : GameCard(gameModel: gamesConsumer.gamesList[index]),
                );
                // GameCard(gameModel: gamesConsumer.gamesList[index]);
              },
            ),
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
              if (index == 0) {
                Provider.of<GamesProvider>(
                  context,
                  listen: false,
                ).getGames("all");
              }
              if (index == 1) {
                Provider.of<GamesProvider>(
                  context,
                  listen: false,
                ).getGames("browser");
              }
              if (index == 2) {
                Provider.of<GamesProvider>(
                  context,
                  listen: false,
                ).getGames("windows");
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.games, size: 40),
                label: "All",
              ),
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
      },
    );
  }
}
