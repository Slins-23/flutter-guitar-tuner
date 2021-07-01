import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:tuner/blocs/theme_bloc.dart';
import 'package:tuner/colors/dark_colors.dart';
import 'package:tuner/colors/light_colors.dart';
import "package:tuner/extensions/globals.dart" as globals;
import "package:shared_preferences/shared_preferences.dart";
import "package:tuner/blocs/custom_tuning_bloc.dart";
import "package:tuner/extensions/custom_classes.dart";

class TuningPicker extends StatefulWidget {
  @override
  TuningPickerState createState() => TuningPickerState();
}

class TuningPickerState extends State<TuningPicker> {
  static TuningList? dropdownValue;

  @override
  void initState() {
    super.initState();
  }

  List<DropdownMenuItem<TuningList>> generateItems(
      CustomTuningBloc customTuningBloc) {
    return customTuningBloc.getTuning.map((TuningList tuning) {
      return DropdownMenuItem<TuningList>(
        value: tuning,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).inputDecorationTheme.fillColor,
          ),
          child: Center(
            child: Text(
              parseDisplay(tuning.getList),
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Theme.of(context).primaryColor ==
                            Themes.dark.primaryColor
                        ? DarkTunerColors.gray
                        : LightTunerColors.gray,
                    fontSize: 19,
                  ),
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final CustomTuningBloc customTuningBloc =
        Provider.of<CustomTuningBloc>(context);

    List<DropdownMenuItem<TuningList>> menuItems =
        generateItems(customTuningBloc);

    // TuningList newDrop = dropdownValue!;
    // TuningList newDropMenuItem =
    //     menuItems.map((item) => item.value).toList()[0]!;

    // print("Dropdown value: $dropdownValue");
    // print("Dropdownmenuitem value: ${newDropMenuItem}");
    // print("Menu items: ${menuItems.map((item) => item.value).toList()}");
    // print("Equal: ${newDrop == newDropMenuItem}");
    // print("Other eq: ${listEquals(newDrop, newDropMenuItem)}");

    // print("Items: ${customTuningBloc.getTuning[0]}");
    // print(
    //     "Types: d - ${dropdownValue.runtimeType} | c - ${customTuningBloc.getTuning[0].runtimeType}");
    // // print("Parsed value: ${parseDisplay(dropdownValue!)}");
    // print("Tunings: ${customTuningBloc.getTuning}");
    // print("Equal: ${customTuningBloc.getTuning[0] == dropdownValue}");

    // print("Equal types?: ${dropdownValue! == customTuningBloc.getTuning[0]}");

    // print("Equal: ${tst == dropdownValue}");
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Text(
                "Tuning target",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
              flex: 11,
              child: Align(
                // alignment: FractionalOffset.center,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).inputDecorationTheme.fillColor,
                  ),
                  height: 35,
                  width: 300,
                  padding: EdgeInsets.only(left: 12.0),
                  child: DropdownButtonHideUnderline(
                    child: Center(
                      child: DropdownButton<TuningList?>(
                        value: dropdownValue,
                        hint: Center(
                          child: Text(
                            parseDisplay(dropdownValue!.getList),
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      color: DarkTunerColors.gray,
                                      // fontFamily: "Arial",
                                    ),
                          ),
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black.withAlpha(100),
                        ),
                        iconSize: 25,
                        elevation: 16,
                        onChanged: (TuningList? newValue) async {
                          setState(() => {
                                globals.flutterFft.setTuning =
                                    newValue!.getList,
                                dropdownValue = newValue,
                              });
                          await _updateData();
                        },
                        iconEnabledColor: Colors.black,
                        items: menuItems,
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
    await prefs.setStringList(key, dropdownValue!.getList);
  }

  String parseDisplay(List<String> value) {
    String newStr = "";

    for (String note in value) {
      if (note.length == 2) {
        newStr += note[0] + octaveToSuperscript(note[1]);
      } else if (note.length == 3) {
        newStr += note[0] + note[1] + octaveToSuperscript(note[2]);
      } else {
        throw "Wrong note";
      }

      if (note != value[value.length - 1]) {
        newStr += " ";
      }
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
