import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:tuner/blocs/theme_bloc.dart';
import 'package:tuner/colors/dark_colors.dart';
import 'package:tuner/colors/light_colors.dart';
import "package:tuner/extensions/globals.dart" as globals;

class IntervalDuration extends StatefulWidget {
  @override
  IntervalDurationState createState() => IntervalDurationState();
}

class IntervalDurationState extends State<IntervalDuration> {
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
                "Detection interval",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
              flex: 9,
              child: Align(
                alignment: FractionalOffset.center,
                child: Padding(
                  padding: EdgeInsets.only(left: 200),
                  child: Container(
                    height: 30,
                    child: TextField(
                      controller: textEditingController,
                      onSubmitted: (text) async => {
                        result = validated(text),
                        if (result is String)
                          {
                            setState(
                              () => {
                                sliderValue = double.parse(result),
                                globals.flutterFft.setSubscriptionDuration =
                                    sliderValue!,
                              },
                            ),
                            await _updateData(),
                          }
                        else
                          {
                            print("Could not validate text."),
                          }
                      },
                      maxLength: 6,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Theme.of(context).primaryColor ==
                                    Themes.dark.primaryColor
                                ? DarkTunerColors.gray
                                : LightTunerColors.gray,
                            fontSize: 16,
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
    final key = "Interval";
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
