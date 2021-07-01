import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:tuner/blocs/theme_bloc.dart';
import 'package:tuner/colors/dark_colors.dart';
import 'package:tuner/colors/light_colors.dart';
import "package:tuner/extensions/globals.dart" as globals;

class SampleRate extends StatefulWidget {
  @override
  SampleRateState createState() => SampleRateState();
}

class SampleRateState extends State<SampleRate> {
  static int? sliderValue;
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
                "Sample Rate",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Flexible(
              flex: 12,
              child: Slider(
                onChanged: (newValue) {
                  setState(
                    () => {
                      sliderValue = newValue.toInt(),
                      textEditingController.text = sliderValue.toString()
                    },
                  );
                }, // UPDATE HERE
                onChangeEnd: (_) async {
                  setState(
                      () => globals.flutterFft.setSampleRate = sliderValue!);
                  await _updateData();
                },
                value: sliderValue!.toDouble(), // SET NEW VALUE HERE
                max: 50000,
                min: 0,
                activeColor: Theme.of(context).cardColor,
                inactiveColor: Theme.of(context).canvasColor,
              ),
            ),
            Expanded(
              flex: 4,
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
                      setState(() => {
                            sliderValue = int.parse(text),
                            globals.flutterFft.setSampleRate = sliderValue!,
                          }),
                      await _updateDataString(),
                    },
                    maxLength: 5,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Theme.of(context).primaryColor ==
                                  Themes.dark.primaryColor
                              ? DarkTunerColors.gray
                              : LightTunerColors.gray,
                          fontSize: 16,
                        ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
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
    final key = "SampleRate";
    await prefs.setInt(key, sliderValue!);
  }

  _updateDataString() async {
    final prefs = await SharedPreferences.getInstance();
    final key = "SampleRate";
    await prefs.setInt(key, sliderValue!);
  }
}
