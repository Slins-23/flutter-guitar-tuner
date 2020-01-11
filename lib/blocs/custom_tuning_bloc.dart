import 'package:flutter/material.dart';
import "package:tuner/extensions/globals.dart" as globals;

class CustomTuningBloc extends ChangeNotifier {
  static List<List<String>> tuning = [
    globals.flutterFft.getTuning,
    ["E3", "B2", "G2", "D2", "A1", "E1"],
  ];

  addTuning(List<String> newTuning) {
    tuning.add(newTuning);
    notifyListeners();
  }

  List<List<String>> get getTuning => tuning;
}
