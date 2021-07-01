import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:tuner/blocs/theme_bloc.dart';
import 'package:tuner/colors/dark_colors.dart';
import 'package:tuner/colors/light_colors.dart';
import "package:tuner/extensions/globals.dart" as globals;

class FrequencyTolerance extends StatefulWidget {
  @override
  FrequencyToleranceState createState() => FrequencyToleranceState();
}

class FrequencyToleranceState extends State<FrequencyTolerance> {
  static double? sliderValue;
  dynamic result;
  static TextEditingController textEditingController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            Flexible(
              flex: 5,
              child: Text(
                "Tolerance",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Flexible(
              flex: 15,
              child: Slider(
                onChanged: (newValue) {
                  setState(
                    () => {
                      sliderValue = newValue,
                      textEditingController.text =
                          sliderValue!.toStringAsFixed(2),
                    },
                  );
                }, // UPDATE HERE
                onChangeEnd: (_) async {
                  setState(
                      () => globals.flutterFft.setTolerance = sliderValue!);
                  await _updateData();
                },
                value: sliderValue!, // SET NEW VALUE HERE
                max: 999,
                min: 0,
                activeColor: Theme.of(context).cardColor,
                inactiveColor: Theme.of(context).canvasColor,
              ),
            ),
            Expanded(
              flex: 5,
              child: Align(
                alignment: FractionalOffset.center,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).inputDecorationTheme.fillColor,
                  ),
                  height: 32,
                  width: 72,
                  child: TextField(
                    controller: textEditingController,
                    onSubmitted: (text) async => {
                      result = validated(text),
                      print("Result $result"),
                      if (result is String)
                        {
                          setState(
                            () => {
                              sliderValue = double.parse(result),
                              globals.flutterFft.setTolerance = sliderValue!,
                            },
                          ),
                          await _updateDataString(),
                        }
                      else
                        {
                          print("Could not validate text."),
                        }
                    },
                    maxLength: 3,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Theme.of(context).primaryColor ==
                                  Themes.dark.primaryColor
                              ? DarkTunerColors.gray
                              : LightTunerColors.gray,
                          fontSize: 15,
                        ),
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    decoration: InputDecoration(
                      counterText: "",
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
    final key = "Tolerance";
    await prefs.setDouble(key, sliderValue!);
  }

  _updateDataString() async {
    final prefs = await SharedPreferences.getInstance();
    final key = "Tolerance";
    await prefs.setDouble(key, sliderValue!);
  }

  dynamic validated(String txt) {
    String newStr = "";

    bool foundSeparator = false;

    if (txt[0] == "," || txt[0] == ".") {
      return false;
    }

    for (int i = 0; i < txt.length; i++) {
      if (!foundSeparator && (txt[i] == "," || txt[i] == ".")) {
        newStr += '.';
        foundSeparator = true;
      } else if (!foundSeparator && (txt[i] != "," && txt[i] != ".")) {
        newStr += txt[i];
      } else if (foundSeparator && (txt[i] != "," && txt[i] != ".")) {
        newStr += txt[i];
      } else {
        continue;
      }
    }

    return newStr;
  }
}
