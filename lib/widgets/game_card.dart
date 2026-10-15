import 'package:flutter/material.dart';
import 'package:free_to_game/models/game_model.dart';
import 'package:free_to_game/screens/game_details_screen.dart';

class GameCard extends StatefulWidget {
  const new({super.key, required this.gameModel});
  final GameModel gameModel;
  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                GameDetailsScreen(gameId: widget.gameModel.id.toString()),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(12),
        child: Stack(
          children: [
            // game cover
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Image.network(
                widget.gameModel.thumbnail,
                fit: BoxFit.cover,
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black, Colors.black.withValues(alpha: 0.1)],
                  ),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            widget.gameModel.platform == "Web Browser"
                                ? Icons.language
                                : Icons.computer,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.gameModel.title,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            widget.gameModel.genre,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
