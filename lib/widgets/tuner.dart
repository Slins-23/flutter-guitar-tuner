import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuner/settings/tuning_picker.dart';
import 'package:tuner/extensions/tuner_extension.dart';

class Tuner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 100,
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: BlocBuilder<TunerBloc, TunerState>(
                condition: (previousState, state) =>
                    state.runtimeType != previousState.runtimeType,
                builder: (context, state) {
                  return Column(
                    children: _mapStateToButtons(
                        tunerBloc: BlocProvider.of<TunerBloc>(context),
                        context: context),
                  );
                },
              ),
            ),
          ),
          Flexible(
            flex: 162,
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: BlocBuilder<TunerBloc, TunerState>(
                builder: (context, state) {
                  return _mapStateToNote(
                    tunerBloc: BlocProvider.of<TunerBloc>(context),
                    context: context,
                  );
                },
              ),
            ),
          ),
          Divider(
            height: 50,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }

  List<Widget> _mapStateToButtons({TunerBloc tunerBloc, BuildContext context}) {
    final TunerState currentState = tunerBloc.state;

    if (currentState is Ready) {
      return [
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 25,
              spreadRadius: 2,
              color: Colors.black.withAlpha(150),
            ),
          ]),
          child: RaisedButton(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Ready",
              style: Theme.of(context).textTheme.button.copyWith(
                    color: Colors.green,
                  ),
            ),
            onPressed: () {
              tunerBloc.add(
                Start(),
              );
            },
            color: Theme.of(context).buttonColor,
          ),
        ),
      ];
    } else if (currentState is Running) {
      return [
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 25,
              spreadRadius: 2,
              color: Colors.black.withAlpha(150),
            ),
          ]),
          child: RaisedButton(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Stop",
              style: Theme.of(context).textTheme.button.copyWith(
                    color: Colors.red,
                  ),
            ),
            onPressed: () {
              tunerBloc.add(
                Stop(),
              );
            },
            color: Theme.of(context).buttonColor,
          ),
        ),
      ];
    } else if (currentState is Stopped) {
      print("Stopped");
      return [
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 25,
              spreadRadius: 2,
              color: Colors.black.withAlpha(150),
            ),
          ]),
          child: RaisedButton(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Restart",
              style: Theme.of(context).textTheme.button.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            onPressed: () {
              tunerBloc.add(
                Stop(),
              );
            },
            color: Theme.of(context).buttonColor,
          ),
        ),
      ];
    }

    return [];
  }

  Widget _mapStateToNote({TunerBloc tunerBloc, BuildContext context}) {
    final TunerState currentState = tunerBloc.state;

    String instruction;
    Color instructionColor;

    if (currentState is Running) {
      double dist = currentState.frequency - currentState.target;
      if (dist < 0) {
        instruction = "Strengthen string by";
        instructionColor = Colors.orange;
      } else if (dist > 0) {
        instruction = "Loosen string by";
        instructionColor = Colors.red;
      } else if (dist == 0) {
        instruction = "Perfectly tuned!";
        instructionColor = Colors.green;
      }

      return currentState.isOnPitch
          ? Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Text(
                    "On Pitch!",
                    style: Theme.of(context).textTheme.display1.copyWith(
                          fontSize: 35,
                          letterSpacing: -1,
                          fontFamily: 'Eczar',
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: Theme.of(context).canvasColor.withAlpha(75),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Perfect tuning is",
                      style: Theme.of(context).textTheme.display1.copyWith(
                            fontSize: 22,
                            letterSpacing: -1,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w200,
                            color: Colors.green,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 105,
                      child: Text(
                        dist > 0
                            ? "-${dist.abs().toStringAsFixed(2)}"
                            : "+${dist.abs().toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.display2.copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              color: instructionColor,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0),
                    ),
                    Text(
                      "away!",
                      style: Theme.of(context).textTheme.display1.copyWith(
                            fontSize: 22,
                            letterSpacing: -1,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w200,
                            color: Colors.green,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 65,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Note:",
                      style: Theme.of(context).textTheme.display1.copyWith(
                            color: Colors.green,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0),
                    ),
                    Container(
                      child: Text(
                        currentState.note +
                            TuningPickerState.octaveToSuperscript(
                                currentState.octave.toString()),
                        style: Theme.of(context).textTheme.display1.copyWith(
                              fontSize: 30,
                              fontFamily: 'Roboto',
                              color: Colors.green,
                            ),
                      ),
                      transform: Matrix4.translationValues(0.0, -2.5, 0.0),
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Frequency:",
                        style: Theme.of(context).textTheme.display1.copyWith(
                              color: Colors.green,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.0),
                      ),
                      Text(
                        currentState.frequency.toStringAsFixed(2),
                        style: Theme.of(context).textTheme.display1.copyWith(
                              fontFamily: 'Roboto',
                              color: Colors.green,
                            ),
                      ),
                    ],
                  ),
                  transform: Matrix4.translationValues(0.0, -20, 0.0),
                ),
                SizedBox(
                  height: 2.5,
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      width: 225,
                      child: Text(
                        instruction,
                        style: Theme.of(context).textTheme.display1.copyWith(
                            color: instructionColor.withAlpha(900),
                            fontSize: 28,
                            letterSpacing: -1,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w200),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0),
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        currentState.distance.toStringAsFixed(2),
                        style: Theme.of(context).textTheme.display2.copyWith(
                              color: instructionColor,
                              fontFamily: 'Roboto',
                              fontSize: 30,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Note:".padLeft(5),
                      style: Theme.of(context).textTheme.display1.copyWith(
                            color: instructionColor.withAlpha(900),
                            fontWeight: FontWeight.w200,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0),
                    ),
                    Container(
                      width: 50,
                      child: Text(
                        currentState.note +
                            TuningPickerState.octaveToSuperscript(
                                currentState.octave.toString()),
                        style: Theme.of(context).textTheme.display1.copyWith(
                              fontFamily: 'Roboto',
                              fontSize: 30,
                              color: instructionColor,
                            ),
                      ),
                      transform: Matrix4.translationValues(0.0, -1.5, 0.0),
                    )
                  ],
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Frequency:",
                        style: Theme.of(context).textTheme.display1.copyWith(
                              color: instructionColor.withAlpha(900),
                              fontWeight: FontWeight.w200,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.0),
                      ),
                      Container(
                        width: 125,
                        child: Text(
                          currentState.frequency.toStringAsFixed(2),
                          style: Theme.of(context).textTheme.display1.copyWith(
                                fontFamily: 'Roboto',
                                fontSize: 30,
                                color: instructionColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Target note:",
                      style: Theme.of(context).textTheme.display1.copyWith(
                            color: Colors.green.withAlpha(900),
                            fontWeight: FontWeight.w200,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0),
                    ),
                    Container(
                      width: 50,
                      child: Text(
                        currentState.nearestNote +
                            TuningPickerState.octaveToSuperscript(
                                currentState.nearestOctave.toString()),
                        style: Theme.of(context).textTheme.display1.copyWith(
                              fontFamily: 'Roboto',
                              fontSize: 30,
                              color: Colors.green,
                            ),
                      ),
                      transform: Matrix4.translationValues(0.0, -1.5, 0.0),
                    )
                  ],
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Target frequency:",
                        style: Theme.of(context).textTheme.display1.copyWith(
                              color: Colors.green.withAlpha(900),
                              fontWeight: FontWeight.w200,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.0),
                      ),
                      Container(
                        width: 125,
                        child: Text(
                          currentState.nearestTarget.toStringAsFixed(2),
                          style: Theme.of(context).textTheme.display1.copyWith(
                                fontFamily: 'Roboto',
                                fontSize: 30,
                                color: Colors.green,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
    } else if (currentState is Stopped || currentState is Ready) {
      return Text(
        "Waiting...",
        style: Theme.of(context).textTheme.body2.copyWith(color: Colors.white),
      );
    } else {
      throw new Exception(
          "Exception thrown at 'tuner01.dart', in the method '_mapStateToNote({TunerBloc tunerBloc}).");
    }
  }
}
