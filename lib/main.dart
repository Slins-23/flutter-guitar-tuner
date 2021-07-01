import 'dart:convert';

import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import "package:tuner/widgets/navigation.dart";
import "package:provider/provider.dart";
import "package:tuner/blocs/theme_bloc.dart";
import "package:tuner/extensions/globals.dart" as globals;
import "package:tuner/settings/channels.dart";
import "package:tuner/settings/frequency_tolerance.dart";
import "package:tuner/settings/interval_duration.dart";
import "package:tuner/settings/sample_rate.dart";
import "package:tuner/settings/theme_changer.dart";
import "package:tuner/settings/tuning_picker.dart";
import "package:tuner/blocs/custom_tuning_bloc.dart";
import "package:flutter_fft/flutter_fft.dart";
import "package:tuner/extensions/custom_classes.dart";

void main() async => {
      WidgetsFlutterBinding
          .ensureInitialized(), // Makes sure that all widgets are initialized before loading the data.
      await loadData(), // Loads the data.
      runApp(
        // Widget that handles restarting the application, its state gets updated once the user clicks the reset settings to default button.
        RestartWidget(
          child: App(),
        ),
      ),
    };

int initialTabIdx = 0; // Starting navigation view/tab

loadData() async {
  final prefs = await SharedPreferences.getInstance();
  final keys = [
    "NumChannels",
    "Tolerance",
    "Interval",
    "SampleRate",
    "Theme",
    "Tuning",
    "CustomTunings",
  ];

  final numChannels =
      prefs.getInt(keys[0]) ?? globals.flutterFft.getNumChannels;
  final tolerance = prefs.getDouble(keys[1]) ?? globals.flutterFft.getTolerance;
  final interval =
      prefs.getDouble(keys[2]) ?? globals.flutterFft.getSubscriptionDuration;
  final sampleRate = prefs.getInt(keys[3]) ?? globals.flutterFft.getSampleRate;
  final theme = prefs.getString(keys[4]) ?? "dark";
  final tuning = prefs.getStringList(keys[5]) ?? globals.flutterFft.getTuning;

  final customTunings = prefs.getString(keys[6]) ?? CustomTuningBloc.tuning;

  List<TuningList> finalCustomTunings = [];

  // Checks if the variable "customTunings" returns a json array, handle the custom tunings if it does.
  if (customTunings.runtimeType == String) {
    final customTuningsJSON = jsonDecode(customTunings as String);

    for (int i = 0; i < customTuningsJSON.length; i++) {
      List<dynamic> currentTuning = customTuningsJSON['${i + 1}'];
      finalCustomTunings.add(TuningList(currentTuning.cast<String>().toList()));
    }
  } else {
    // Otherwise, set it to the default value, which was already returned by "customTunings".
    finalCustomTunings = customTunings as List<TuningList>;
  }

  // Sets number of channels in the plugin.
  globals.flutterFft.setNumChannels = numChannels;

  // Sets tolerance in the plugin. (How far apart can the frequency and target frequency be to be considered on pitch).
  globals.flutterFft.setTolerance = tolerance;

  // Sets calls to the API in "interval" time in the plugin.
  globals.flutterFft.setSubscriptionDuration = interval;

  // Sets sample rate in the plugin.
  globals.flutterFft.setSampleRate = sampleRate;

  // Sets current active tuning target in the plugin. (Which tuning the user is aiming for/selected in the settings, such as the standard tuning)
  globals.flutterFft.setTuning = tuning;

  ChannelsState.dropdownValue = numChannels;
  FrequencyToleranceState.sliderValue = tolerance;
  FrequencyToleranceState.textEditingController.text =
      tolerance.toStringAsFixed(2);
  IntervalDurationState.sliderValue = interval;
  IntervalDurationState.textEditingController.text =
      interval.toStringAsFixed(2);
  SampleRateState.sliderValue = sampleRate;
  SampleRateState.textEditingController.text = sampleRate.toString();
  ThemeChanger.currentTheme = theme;

  // Tuning target set by the user.
  TuningPickerState.dropdownValue = TuningList(tuning);

  // Available tuning settings, including default and user set.
  CustomTuningBloc.tuning = finalCustomTunings;
}

resetData() async {
  // Resets data to default.
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Clears shared preferences storage.
  await prefs.clear();

  // Instantiates the plugin, which has its own default settings. (The app's default settings are the same as the plugin's default settings)
  globals.flutterFft = new FlutterFft();

  ChannelsState.dropdownValue = globals.flutterFft.getNumChannels;
  FrequencyToleranceState.sliderValue = globals.flutterFft.getTolerance;
  FrequencyToleranceState.textEditingController.text =
      globals.flutterFft.getTolerance.toStringAsFixed(2);
  IntervalDurationState.sliderValue =
      globals.flutterFft.getSubscriptionDuration;
  IntervalDurationState.textEditingController.text =
      globals.flutterFft.getSubscriptionDuration.toStringAsFixed(2);
  SampleRateState.sliderValue = globals.flutterFft.getSampleRate;
  SampleRateState.textEditingController.text =
      globals.flutterFft.getSampleRate.toString();
  ThemeChanger.currentTheme = "dark";
  TuningPickerState.dropdownValue = TuningList(globals.flutterFft.getTuning);
  final tempTuning = CustomTuningBloc.tuning[1];
  CustomTuningBloc.tuning = [];

  CustomTuningBloc.tuning.add(TuningPickerState.dropdownValue!);
  CustomTuningBloc.tuning.add(tempTuning);
}

// Widget responsible for restarting the application.
class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  // When the application restarts (when the user clicks the reset button in this case), re-draw the application at the settings view.
  static void restartApp(BuildContext context) async {
    initialTabIdx = 1;
    await resetData();
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() => key = UniqueKey());
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class App extends StatelessWidget {
  final Themes themes = new Themes();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChangerBloc>(
      create: (_) => ThemeChangerBloc(
          ThemeChanger.currentTheme == "light" ? Themes.light : Themes.dark),
      child: Application(),
    );
  }
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChangerBloc>(context);
    return MaterialApp(
      title: "Tuner",
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      home: TabController(),
    );
  }
}

class TabController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        initialIndex: initialTabIdx,
        length: 2,
        child: Scaffold(
          body: Views(),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black,
                  width: 0.25,
                ),
              ),
            ),
            child: NavigationBar(),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
