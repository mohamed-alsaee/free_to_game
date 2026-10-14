import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:free_to_game/models/game_model.dart';
import 'package:free_to_game/services/api.dart';

class GamesProvider with ChangeNotifier {
  Api api = Api();

  bool busy = false;
  bool busyMore = false;
  bool pagenating = false;
  bool failed = false;

  void setBusy(bool s) {
    busy = s;
    notifyListeners();
  }

  void setMoreBusy(bool mb) {
    busyMore = mb;
    notifyListeners();
  }

  void setPagenating(bool p) {
    pagenating = p;
    notifyListeners();
  }

  void setFailed(bool f) {
    failed = f;
    notifyListeners();
  }

  List<GameModel> gamesList = [];

  void getGames(String query) async {
    setBusy(true);
    final response = await api.get("/games?platform=$query");

    if (response.statusCode == 200) {
      List<dynamic> decodedData = json.decode(response.body);
      gamesList = decodedData.map((jg) => GameModel.fromJson(jg)).toList();

      setFailed(false);
      setBusy(false);
    } else {
      setFailed(true);
      setBusy(false);
    }
  }
}
