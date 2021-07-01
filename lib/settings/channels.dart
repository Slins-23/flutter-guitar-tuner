import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import 'package:tuner/blocs/theme_bloc.dart';
import 'package:tuner/colors/dark_colors.dart';
import 'package:tuner/colors/light_colors.dart';
import "package:tuner/extensions/globals.dart" as globals;

class Channels extends StatefulWidget {
  @override
  ChannelsState createState() => ChannelsState();
}

class ChannelsState extends State<Channels> {
  static int? dropdownValue;

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
              flex: 2,
              child: Text(
                "Channels",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
              flex: 10,
              child: Align(
                alignment: FractionalOffset.center,
                child: Padding(
                  padding: EdgeInsets.only(left: 275),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).inputDecorationTheme.fillColor,
                    ),
                    height: 35,
                    padding: EdgeInsets.only(left: 8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: dropdownValue,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black.withAlpha(100),
                        ),
                        iconSize: 25,
                        elevation: 16,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Theme.of(context).primaryColor ==
                                      Themes.dark.primaryColor
                                  ? DarkTunerColors.gray
                                  : LightTunerColors.gray,
                              fontSize: 16,
                            ),
                        onChanged: (int? newValue) async {
                          setState(() => {
                                dropdownValue = newValue,
                                globals.flutterFft.setNumChannels = newValue!,
                              });
                          await _updateData();
                        },
                        iconEnabledColor: Colors.black,
                        items: <int>[1, 2, 3, 4, 5, 6, 7]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Container(
                              child: Text(
                                value.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      color: Theme.of(context).primaryColor ==
                                              Themes.dark.primaryColor
                                          ? DarkTunerColors.gray
                                          : LightTunerColors.gray,
                                      fontSize: 15,
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
    final key = "NumChannels";
    prefs.setInt(key, dropdownValue!);
  }
}
