import 'package:flutter/material.dart';

class Player {
  String number = "", name = "";
  int falls = 0, score = 0;
}

class PlayersModel extends ChangeNotifier {
  final int maxScore = 999;
  final int maxFalls = 5;

  int leftScore = 0;
  int rightScore = 0;
  var leftPlayers = List.generate(12, (_) => Player());
  var rightPlayers = List.generate(12, (_) => Player());

  void update() {
    notifyListeners();
  }

  void setNumber(int team, int index, String number) {
    if (team == 1) {
      leftPlayers[index].number = number;
    } else if (team == 2) {
      rightPlayers[index].number = number;
    }
    notifyListeners();
  }

  void setName(int team, int index, String name) {
    if (team == 1) {
      leftPlayers[index].name = name;
    } else if (team == 2) {
      rightPlayers[index].name = name;
    }
    notifyListeners();
  }

  void addScore(int team, int index) {
    if (team == 1) {
      ++leftPlayers[index].score;
      ++leftScore;
      if (leftPlayers[index].score > maxScore) {
        leftScore -= leftPlayers[index].score;
        leftPlayers[index].score = 0;
      }
    } else if (team == 2) {
      ++rightPlayers[index].score;
      ++rightScore;
      if (rightPlayers[index].score > maxScore) {
        rightScore -= rightPlayers[index].score;
        rightPlayers[index].score = 0;
      }
    }
    notifyListeners();
  }

  void subScore(int team, int index) {
    if (team == 1) {
      --leftPlayers[index].score;
      --leftScore;
      if (leftPlayers[index].score < 0) {
        leftScore += maxScore + 1;
        leftPlayers[index].score = maxScore;
      }
    } else if (team == 2) {
      --rightPlayers[index].score;
      --rightScore;
      if (rightPlayers[index].score < 0) {
        rightScore += maxScore + 1;
        rightPlayers[index].score = maxScore;
      }
    }
    notifyListeners();
  }

  void resetScore(int team, int index) {
    if (team == 1) {
      leftScore -= leftPlayers[index].score;
      leftPlayers[index].score = 0;
    } else if (team == 2) {
      rightScore -= rightPlayers[index].score;
      rightPlayers[index].score = 0;
    }
    notifyListeners();
  }

  void addFall(int team, int index) {
    if (team == 1) {
      ++leftPlayers[index].falls;
      if (leftPlayers[index].falls > maxFalls) {
        leftPlayers[index].falls = 0;
      }
    } else if (team == 2) {
      ++rightPlayers[index].falls;
      if (rightPlayers[index].falls > maxFalls) {
        rightPlayers[index].falls = 0;
      }
    }
    notifyListeners();
  }

  void subFall(int team, int index) {
    if (team == 1) {
      --leftPlayers[index].falls;
      if (leftPlayers[index].falls < 0) {
        leftPlayers[index].falls = maxFalls;
      }
    } else if (team == 2) {
      --rightPlayers[index].falls;
      if (rightPlayers[index].falls < 0) {
        rightPlayers[index].falls = maxFalls;
      }
    }
    notifyListeners();
  }
}
