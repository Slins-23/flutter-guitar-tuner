import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:tuner/blocs/theme_bloc.dart';
import 'package:tuner/colors/dark_colors.dart';
import 'package:tuner/colors/light_colors.dart';
import "package:tuner/extensions/globals.dart" as globals;
import "package:shared_preferences/shared_preferences.dart";
import "package:tuner/blocs/custom_tuning_bloc.dart";

class TuningPicker extends StatefulWidget {
  @override
  TuningPickerState createState() => TuningPickerState();
}

class TuningPickerState extends State<TuningPicker> {
  static List<String> dropdownValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CustomTuningBloc customTuningBloc =
        Provider.of<CustomTuningBloc>(context);

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Text(
                "Tuning target",
                style: Theme.of(context).textTheme.display4,
              ),
            ),
            Expanded(
              flex: 10,
              child: Align(
                alignment: FractionalOffset.center,
                child: Padding(
                  padding: EdgeInsets.only(left: 125),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).inputDecorationTheme.fillColor,
                    ),
                    height: 35,
                    padding: EdgeInsets.only(left: 8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<List<String>>(
                        value: dropdownValue,
                        hint: Text(
                          parseDisplay(dropdownValue),
                          style: Theme.of(context).textTheme.display3.copyWith(
                                color: DarkTunerColors.gray,
                              ),
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black.withAlpha(100),
                        ),
                        iconSize: 25,
                        elevation: 16,
                        onChanged: (List<String> newValue) async {
                          setState(() => {
                                globals.flutterFft.setTuning = newValue,
                                dropdownValue = newValue,
                              });
                          await _updateData();
                        },
                        iconEnabledColor: Colors.black,
                        items: customTuningBloc.getTuning
                            .map((List<String> tuning) {
                          return DropdownMenuItem<List<String>>(
                            value: tuning,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .inputDecorationTheme
                                    .fillColor,
                              ),
                              child: Text(
                                parseDisplay(tuning),
                                style: Theme.of(context)
                                    .textTheme
                                    .display3
                                    .copyWith(
                                      color: Theme.of(context).primaryColor ==
                                              Themes.dark.primaryColor
                                          ? DarkTunerColors.gray
                                          : LightTunerColors.gray,
                                      fontSize: 19,
                                    ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 0.2,
            ),
          ),
          color: Colors.transparent),
      height: 50,
    );
  }

  _updateData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = "Tuning";
    await prefs.setStringList(key, dropdownValue);
  }

  String parseDisplay(List<String> value) {
    String newStr = "";

    if (value.length > 1) {
      for (String note in value) {
        String newNote = note[0] + octaveToSuperscript(note[1]);
        if (note == value[value.length - 1]) {
          newStr += newNote;
        } else {
          newStr += "$newNote ";
        }
      }
    } else {
      newStr = value[0];
    }

    return newStr;
  }

  static String octaveToSuperscript(String octave) {
    //SUPERSCRIPT: ¹²³⁴⁵⁶⁷⁸⁹
    //SUBSCRIPT: ₁₂₃₄₅₆₇₈₉

    switch (octave) {
      case "1":
        return "¹";
      case "2":
        return "²";
      case "3":
        return "³";
      case "4":
        return "⁴";
      case "5":
        return "⁵";
      case "6":
        return "⁶";
      case "7":
        return "⁷";
      case "8":
        return "⁸";
      case "9":
        return "⁹";
      default:
        break;
    }

    return "";
  }
}
