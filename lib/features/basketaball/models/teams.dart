import 'package:flutter/material.dart';

class Team {
  String name = "", country = "";
  int timeouts = 0, falls = 0;
}

class TeamsModel extends ChangeNotifier {
  final int maxTimeouts = 3;
  final int maxFalls = 5;

  var leftTeam = Team();
  var rightTeam = Team();

  void setName(int team, String name) {
    if (team == 1) {
      leftTeam.name = name;
    } else if (team == 2) {
      rightTeam.name = name;
    }
    notifyListeners();
  }

  void setCountry(int team, String country) {
    if (team == 1) {
      leftTeam.country = country;
    } else if (team == 2) {
      rightTeam.country = country;
    }
    notifyListeners();
  }

  void addTimeout(int team) {
    if (team == 1) {
      ++leftTeam.timeouts;
      if (leftTeam.timeouts > maxTimeouts) {
        leftTeam.timeouts = 0;
      }
    } else if (team == 2) {
      ++rightTeam.timeouts;
      if (rightTeam.timeouts > maxTimeouts) {
        rightTeam.timeouts = 0;
      }
    }
    notifyListeners();
  }

  void subTimeout(int team) {
    if (team == 1) {
      --leftTeam.timeouts;
      if (leftTeam.timeouts < 0) {
        leftTeam.timeouts = maxTimeouts;
      }
    } else if (team == 2) {
      --rightTeam.timeouts;
      if (rightTeam.timeouts < 0) {
        rightTeam.timeouts = maxTimeouts;
      }
    }
    notifyListeners();
  }

  void addFall(int team) {
    if (team == 1) {
      ++leftTeam.falls;
      if (leftTeam.falls > maxFalls) {
        leftTeam.falls = 0;
      }
    } else if (team == 2) {
      ++rightTeam.falls;
      if (rightTeam.falls > maxFalls) {
        rightTeam.falls = 0;
      }
    }
    notifyListeners();
  }

  void subFall(int team) {
    if (team == 1) {
      --leftTeam.falls;
      if (leftTeam.falls < 0) {
        leftTeam.falls = maxFalls;
      }
    } else if (team == 2) {
      --rightTeam.falls;
      if (rightTeam.falls < 0) {
        rightTeam.falls = maxFalls;
      }
    }
    notifyListeners();
  }
}
