import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import "package:shared_preferences/shared_preferences.dart";
import "package:tuner/blocs/custom_tuning_bloc.dart";
import 'package:tuner/extensions/custom_classes.dart';

class CustomTuning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomTuningBloc _customTuning = Provider.of<CustomTuningBloc>(context);

    return InkWell(
      onTap: () => {
        Navigator.of(context).push(
          MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return TuneCreation(tuningBloc: _customTuning);
            },
          ),
        ),
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Expanded(
                flex: 0,
                child: Align(
                  alignment: FractionalOffset.center,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.add_circle,
                      color: Theme.of(context).textTheme.headline1!.color,
                      size: 25,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Text(
                  "Add custom tuning",
                  style: Theme.of(context).textTheme.headline1,
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
      ),
    );
  }
}

class TuneCreation extends StatefulWidget {
  final CustomTuningBloc? tuningBloc;

  const TuneCreation({@required this.tuningBloc});
  @override
  TuneCreationState createState() => TuneCreationState(tuningBloc: tuningBloc!);
}

class TuneCreationState extends State<TuneCreation> {
  final CustomTuningBloc? tuningBloc;

  TuneCreationState({@required this.tuningBloc});

  static int strings = 6;

  List<String> notes = [];
  List<int> octaves = [];

  int currentStep = 0;
  bool firstComplete = false;

  static List<String> noteArray = [
    "A",
    "A#",
    "B",
    "C",
    "C#",
    "D",
    "D#",
    "E",
    "F",
    "F#",
    "G",
    "G#"
  ];

  static List<int> octaveArray = [1, 2, 3, 4, 5, 6, 7, 8];

  String note01 = noteArray[0];
  String note02 = noteArray[1];
  String note03 = noteArray[2];
  String note04 = noteArray[3];
  String note05 = noteArray[4];
  String note06 = noteArray[5];
  String note07 = noteArray[6];
  String note08 = noteArray[7];
  String note09 = noteArray[8];
  String note10 = noteArray[9];
  String note11 = noteArray[10];
  String note12 = noteArray[11];

  int octave01 = 2;
  int octave02 = 2;
  int octave03 = 2;
  int octave04 = 2;
  int octave05 = 2;
  int octave06 = 2;
  int octave07 = 2;
  int octave08 = 2;
  int octave09 = 2;
  int octave10 = 2;
  int octave11 = 2;
  int octave12 = 2;

  @override
  initState() {
    super.initState();
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  next() async {
    if (currentStep == 0) {
      setState(() {
        firstComplete = true;
      });
      goTo(1);
    } else if (currentStep == 1) {
      List<String> tune = List.filled(strings, "Q");

      notes = [
        note01,
        note02,
        note03,
        note04,
        note05,
        note06,
        note07,
        note08,
        note09,
        note10,
        note11,
        note12
      ];
      octaves = [
        octave01,
        octave02,
        octave03,
        octave04,
        octave05,
        octave06,
        octave07,
        octave08,
        octave09,
        octave10,
        octave11,
        octave12
      ];

      for (int i = 0; i < strings; i++) {
        tune[i] = notes[i] + octaves[i].toString();
      }

      await _updateData(TuningList(tune));
      close();
    } else {
      print("WRONG STEP.");
    }
  }

  close() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          Stepper(
            type: StepperType.vertical,
            steps: [
              Step(
                title: Text(
                  "Number of strings",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 25,
                        fontFamily: "Roboto",
                      ),
                ),
                isActive: true,
                state: firstComplete ? StepState.complete : StepState.editing,
                content: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: <Widget>[
                      DropdownButton<int>(
                        value: strings,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 25,
                        elevation: 16,
                        style: Theme.of(context).textTheme.headline1,
                        underline: Container(height: 2, color: Colors.black),
                        onChanged: (int? newValue) {
                          setState(() => {
                                strings = newValue!,
                                notes = [],
                                octaves = [],
                              });
                        },
                        iconEnabledColor: Colors.black,
                        items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Container(
                              child: Text(
                                value.toString(),
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              Step(
                title: Text(
                  "Notes and octaves (Highest to lowest)",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 25,
                        fontFamily: "Roboto",
                      ),
                ),
                isActive: firstComplete ? true : false,
                state: firstComplete ? StepState.editing : StepState.disabled,
                content: Padding(
                  padding: const EdgeInsets.only(left: 45.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "1st (Highest)",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(fontSize: 13),
                              ),
                              Row(
                                children: <Widget>[
                                  DropdownButton<String>(
                                    value: note01,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 25,
                                    elevation: 16,
                                    style: Theme.of(context).textTheme.caption,
                                    underline: Container(
                                        height: 1, color: Colors.black),
                                    onChanged: (String? newValue) {
                                      setState(() => {
                                            note01 = newValue!,
                                          });
                                    },
                                    iconEnabledColor: Colors.black,
                                    items: noteArray
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Container(
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth: 16,
                                            ),
                                            child: Text(
                                              value,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                  ),
                                  DropdownButton<int>(
                                    value: octave01,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 25,
                                    elevation: 16,
                                    style: Theme.of(context).textTheme.caption,
                                    underline: Container(
                                        height: 1, color: Colors.black),
                                    onChanged: (int? newValue) {
                                      setState(() => {
                                            octave01 = newValue!,
                                          });
                                    },
                                    iconEnabledColor: Colors.black,
                                    items: octaveArray
                                        .map<DropdownMenuItem<int>>(
                                            (int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Container(
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth: 1,
                                            ),
                                            child: Text(
                                              value.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 25),
                          ),
                          if (strings > 1)
                            Column(
                              children: <Widget>[
                                Text(
                                  "2nd",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(fontSize: 13),
                                ),
                                Row(
                                  children: <Widget>[
                                    DropdownButton<String>(
                                      value: note02,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 25,
                                      elevation: 16,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                      underline: Container(
                                          height: 1, color: Colors.black),
                                      onChanged: (String? newValue) {
                                        setState(() => {
                                              note02 = newValue!,
                                            });
                                      },
                                      iconEnabledColor: Colors.black,
                                      items: noteArray
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Container(
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: 16,
                                              ),
                                              child: Text(
                                                value,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    DropdownButton<int>(
                                      value: octave02,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 25,
                                      elevation: 16,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                      underline: Container(
                                          height: 1, color: Colors.black),
                                      onChanged: (int? newValue) {
                                        setState(() => {
                                              octave02 = newValue!,
                                            });
                                      },
                                      iconEnabledColor: Colors.black,
                                      items: octaveArray
                                          .map<DropdownMenuItem<int>>(
                                              (int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Container(
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: 1,
                                              ),
                                              child: Text(
                                                value.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          //PLACEHOLDER,
                        ],
                      ),
                      if (strings > 2)
                        Row(
                          children: <Widget>[
                            if (strings > 2)
                              Column(
                                children: <Widget>[
                                  Text(
                                    "3rd",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(fontSize: 13),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      DropdownButton<String>(
                                        value: note03,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 25,
                                        elevation: 16,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        underline: Container(
                                            height: 1, color: Colors.black),
                                        onChanged: (String? newValue) {
                                          setState(() => {
                                                note03 = newValue!,
                                              });
                                        },
                                        iconEnabledColor: Colors.black,
                                        items: noteArray
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Container(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 16,
                                                ),
                                                child: Text(
                                                  value,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      DropdownButton<int>(
                                        value: octave03,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 25,
                                        elevation: 16,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        underline: Container(
                                            height: 1, color: Colors.black),
                                        onChanged: (int? newValue) {
                                          setState(() => {
                                                octave03 = newValue!,
                                              });
                                        },
                                        iconEnabledColor: Colors.black,
                                        items: octaveArray
                                            .map<DropdownMenuItem<int>>(
                                                (int value) {
                                          return DropdownMenuItem<int>(
                                            value: value,
                                            child: Container(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 1,
                                                ),
                                                child: Text(
                                                  value.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            //PLACEHOLDER,
                            Padding(
                              padding: EdgeInsets.only(left: 25),
                            ),
                            Row(
                              children: <Widget>[
                                if (strings > 3)
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "4th",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(fontSize: 15),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          DropdownButton<String>(
                                            value: note04,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 25,
                                            elevation: 16,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                            underline: Container(
                                                height: 1, color: Colors.black),
                                            onChanged: (String? newValue) {
                                              setState(() => {
                                                    note04 = newValue!,
                                                  });
                                            },
                                            iconEnabledColor: Colors.black,
                                            items: noteArray
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Container(
                                                  child: ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      maxWidth: 16,
                                                    ),
                                                    child: Text(
                                                      value,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                          ),
                                          DropdownButton<int>(
                                            value: octave04,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 25,
                                            elevation: 16,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                            underline: Container(
                                                height: 1, color: Colors.black),
                                            onChanged: (int? newValue) {
                                              setState(() => {
                                                    octave04 = newValue!,
                                                  });
                                            },
                                            iconEnabledColor: Colors.black,
                                            items: octaveArray
                                                .map<DropdownMenuItem<int>>(
                                                    (int value) {
                                              return DropdownMenuItem<int>(
                                                value: value,
                                                child: Container(
                                                  child: ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      maxWidth: 1,
                                                    ),
                                                    child: Text(
                                                      value.toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                //PLACEHOLDER,
                              ],
                            )
                          ],
                        ),
                      //PLACEHOLDER,
                      if (strings > 4)
                        Row(
                          children: <Widget>[
                            if (strings > 4)
                              Column(
                                children: <Widget>[
                                  Text(
                                    "5th",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(fontSize: 13),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      DropdownButton<String>(
                                        value: note05,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 25,
                                        elevation: 16,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        underline: Container(
                                            height: 1, color: Colors.black),
                                        onChanged: (String? newValue) {
                                          setState(() => {
                                                note05 = newValue!,
                                              });
                                        },
                                        iconEnabledColor: Colors.black,
                                        items: noteArray
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Container(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 16,
                                                ),
                                                child: Text(
                                                  value,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      DropdownButton<int>(
                                        value: octave05,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 25,
                                        elevation: 16,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        underline: Container(
                                            height: 1, color: Colors.black),
                                        onChanged: (int? newValue) {
                                          setState(() => {
                                                octave05 = newValue!,
                                              });
                                        },
                                        iconEnabledColor: Colors.black,
                                        items: octaveArray
                                            .map<DropdownMenuItem<int>>(
                                                (int value) {
                                          return DropdownMenuItem<int>(
                                            value: value,
                                            child: Container(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 1,
                                                ),
                                                child: Text(
                                                  value.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            //PLACEHOLDER,
                            Padding(
                              padding: EdgeInsets.only(left: 25),
                            ),
                            if (strings > 5)
                              Column(
                                children: <Widget>[
                                  Text(
                                    "6th",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(fontSize: 13),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      DropdownButton<String>(
                                        value: note06,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 25,
                                        elevation: 16,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        underline: Container(
                                            height: 1, color: Colors.black),
                                        onChanged: (String? newValue) {
                                          setState(() => {
                                                note06 = newValue!,
                                              });
                                        },
                                        iconEnabledColor: Colors.black,
                                        items: noteArray
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Container(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 16,
                                                ),
                                                child: Text(
                                                  value,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      DropdownButton<int>(
                                        value: octave06,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 25,
                                        elevation: 16,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        underline: Container(
                                            height: 1, color: Colors.black),
                                        onChanged: (int? newValue) {
                                          setState(() => {
                                                octave06 = newValue!,
                                              });
                                        },
                                        iconEnabledColor: Colors.black,
                                        items: octaveArray
                                            .map<DropdownMenuItem<int>>(
                                                (int value) {
                                          return DropdownMenuItem<int>(
                                            value: value,
                                            child: Container(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 1,
                                                ),
                                                child: Text(
                                                  value.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            //PLACEHOLDER,
                          ],
                        ),
                      //PLACEHOLDER,
                      if (strings > 6)
                        Row(
                          children: <Widget>[
                            if (strings > 6)
                              Column(
                                children: <Widget>[
                                  Text(
                                    "7th",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(fontSize: 13),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      DropdownButton<String>(
                                        value: note07,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 25,
                                        elevation: 16,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        underline: Container(
                                            height: 1, color: Colors.black),
                                        onChanged: (String? newValue) {
                                          setState(() => {
                                                note07 = newValue!,
                                              });
                                        },
                                        iconEnabledColor: Colors.black,
                                        items: noteArray
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Container(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 16,
                                                ),
                                                child: Text(
                                                  value,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      DropdownButton<int>(
                                        value: octave07,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 25,
                                        elevation: 16,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        underline: Container(
                                            height: 1, color: Colors.black),
                                        onChanged: (int? newValue) {
                                          setState(() => {
                                                octave07 = newValue!,
                                              });
                                        },
                                        iconEnabledColor: Colors.black,
                                        items: octaveArray
                                            .map<DropdownMenuItem<int>>(
                                                (int value) {
                                          return DropdownMenuItem<int>(
                                            value: value,
                                            child: Container(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 1,
                                                ),
                                                child: Text(
                                                  value.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            //PLACEHOLDER,
                            Padding(
                              padding: EdgeInsets.only(left: 25),
                            ),
                            Row(
                              children: <Widget>[
                                if (strings > 7)
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "8th",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(fontSize: 15),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          DropdownButton<String>(
                                            value: note08,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 25,
                                            elevation: 16,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                            underline: Container(
                                                height: 1, color: Colors.black),
                                            onChanged: (String? newValue) {
                                              setState(() => {
                                                    note08 = newValue!,
                                                  });
                                            },
                                            iconEnabledColor: Colors.black,
                                            items: noteArray
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Container(
                                                  child: ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      maxWidth: 16,
                                                    ),
                                                    child: Text(
                                                      value,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                          ),
                                          DropdownButton<int>(
                                            value: octave08,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 25,
                                            elevation: 16,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                            underline: Container(
                                                height: 1, color: Colors.black),
                                            onChanged: (int? newValue) {
                                              setState(() => {
                                                    octave08 = newValue!,
                                                  });
                                            },
                                            iconEnabledColor: Colors.black,
                                            items: octaveArray
                                                .map<DropdownMenuItem<int>>(
                                                    (int value) {
                                              return DropdownMenuItem<int>(
                                                value: value,
                                                child: Container(
                                                  child: ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      maxWidth: 1,
                                                    ),
                                                    child: Text(
                                                      value.toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                //PLACEHOLDER,
                              ],
                            )
                          ],
                        ),
                      //PLACEHOLDER,
                      if (strings > 8)
                        Row(
                          children: <Widget>[
                            if (strings > 8)
                              Column(
                                children: <Widget>[
                                  Text(
                                    "9th",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(fontSize: 13),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      DropdownButton<String>(
                                        value: note09,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 25,
                                        elevation: 16,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        underline: Container(
                                            height: 1, color: Colors.black),
                                        onChanged: (String? newValue) {
                                          setState(() => {
                                                note09 = newValue!,
                                              });
                                        },
                                        iconEnabledColor: Colors.black,
                                        items: noteArray
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Container(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 16,
                                                ),
                                                child: Text(
                                                  value,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      DropdownButton<int>(
                                        value: octave09,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 25,
                                        elevation: 16,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        underline: Container(
                                            height: 1, color: Colors.black),
                                        onChanged: (int? newValue) {
                                          setState(() => {
                                                octave09 = newValue!,
                                              });
                                        },
                                        iconEnabledColor: Colors.black,
                                        items: octaveArray
                                            .map<DropdownMenuItem<int>>(
                                                (int value) {
                                          return DropdownMenuItem<int>(
                                            value: value,
                                            child: Container(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 1,
                                                ),
                                                child: Text(
                                                  value.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            //PLACEHOLDER,
                            Padding(
                              padding: EdgeInsets.only(left: 25),
                            ),
                            if (strings > 9)
                              Column(
                                children: <Widget>[
                                  Text(
                                    "10th",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(fontSize: 13),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      DropdownButton<String>(
                                        value: note10,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 25,
                                        elevation: 16,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        underline: Container(
                                            height: 1, color: Colors.black),
                                        onChanged: (String? newValue) {
                                          setState(() => {
                                                note10 = newValue!,
                                              });
                                        },
                                        iconEnabledColor: Colors.black,
                                        items: noteArray
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Container(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 16,
                                                ),
                                                child: Text(
                                                  value,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      DropdownButton<int>(
                                        value: octave10,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 25,
                                        elevation: 16,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        underline: Container(
                                            height: 1, color: Colors.black),
                                        onChanged: (int? newValue) {
                                          setState(() => {
                                                octave10 = newValue!,
                                              });
                                        },
                                        iconEnabledColor: Colors.black,
                                        items: octaveArray
                                            .map<DropdownMenuItem<int>>(
                                                (int value) {
                                          return DropdownMenuItem<int>(
                                            value: value,
                                            child: Container(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 1,
                                                ),
                                                child: Text(
                                                  value.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            //PLACEHOLDER,
                          ],
                        ),
                      //PLACEHOLDER,
                      if (strings > 10)
                        Row(
                          children: <Widget>[
                            if (strings > 10)
                              Column(
                                children: <Widget>[
                                  Text(
                                    "11th",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(fontSize: 13),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      DropdownButton<String>(
                                        value: note11,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 25,
                                        elevation: 16,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        underline: Container(
                                            height: 1, color: Colors.black),
                                        onChanged: (String? newValue) {
                                          setState(() => {
                                                note11 = newValue!,
                                              });
                                        },
                                        iconEnabledColor: Colors.black,
                                        items: noteArray
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Container(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 16,
                                                ),
                                                child: Text(
                                                  value,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      DropdownButton<int>(
                                        value: octave11,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 25,
                                        elevation: 16,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                        underline: Container(
                                            height: 1, color: Colors.black),
                                        onChanged: (int? newValue) {
                                          setState(() => {
                                                octave11 = newValue!,
                                              });
                                        },
                                        iconEnabledColor: Colors.black,
                                        items: octaveArray
                                            .map<DropdownMenuItem<int>>(
                                                (int value) {
                                          return DropdownMenuItem<int>(
                                            value: value,
                                            child: Container(
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: 1,
                                                ),
                                                child: Text(
                                                  value.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            //PLACEHOLDER,
                            Padding(
                              padding: EdgeInsets.only(left: 25),
                            ),
                            Row(
                              children: <Widget>[
                                if (strings > 11)
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "12th",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(fontSize: 15),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          DropdownButton<String>(
                                            value: note12,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 25,
                                            elevation: 16,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                            underline: Container(
                                                height: 1, color: Colors.black),
                                            onChanged: (String? newValue) {
                                              setState(() => {
                                                    note12 = newValue!,
                                                  });
                                            },
                                            iconEnabledColor: Colors.black,
                                            items: noteArray
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Container(
                                                  child: ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      maxWidth: 16,
                                                    ),
                                                    child: Text(
                                                      value,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                          ),
                                          DropdownButton<int>(
                                            value: octave12,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 25,
                                            elevation: 16,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                            underline: Container(
                                                height: 1, color: Colors.black),
                                            onChanged: (int? newValue) {
                                              setState(() => {
                                                    octave12 = newValue!,
                                                  });
                                            },
                                            iconEnabledColor: Colors.black,
                                            items: octaveArray
                                                .map<DropdownMenuItem<int>>(
                                                    (int value) {
                                              return DropdownMenuItem<int>(
                                                value: value,
                                                child: Container(
                                                  child: ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      maxWidth: 1,
                                                    ),
                                                    child: Text(
                                                      value.toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                //PLACEHOLDER,
                              ],
                            )
                          ],
                        )
                      //PLACEHOLDER,
                    ],
                  ),
                ),
              ),
            ],
            currentStep: currentStep,
            onStepContinue: next,
            onStepTapped: (step) => goTo(step),
            onStepCancel: close,
          ),
        ],
      ),
    );
  }

  String _encodeJSON() {
    String jsonEncoded = "{";

    int count = 1;
    CustomTuningBloc.tuning.forEach((tuning) => {
          if (count < CustomTuningBloc.tuning.length)
            {
              jsonEncoded +=
                  '"${count.toString()}": ["${tuning.getList.reduce((value, element) => value + '"' + ", " + '"' + element)}"], ',
              count++,
            }
          else if (count == CustomTuningBloc.tuning.length)
            {
              jsonEncoded +=
                  '"${count.toString()}": ["${tuning.getList.reduce((value, element) => value + '"' + ", " + '"' + element)}"]}',
            }
        });

    return jsonEncoded;
  }

  _updateData(TuningList tuning) async {
    //List<String> tuning = ["F1", "F2", "F3", "F4", "F5", "F6"];

    if (!CustomTuningBloc.tuning.toString().contains(tuning.toString())) {
      tuningBloc!.addTuning(tuning); // TUNING SET BY THE USER
      final prefs = await SharedPreferences.getInstance();
      final key = "CustomTunings";
      await prefs.setString(key, _encodeJSON());
    } else {
      print("Tuning already exists.");
    }
  }
}
