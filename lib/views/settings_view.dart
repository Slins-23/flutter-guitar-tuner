import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:tuner/blocs/custom_tuning_bloc.dart';
import "package:tuner/settings/frequency_tolerance.dart";
import "package:tuner/settings/sample_rate.dart";
import "package:tuner/settings/channels.dart";
import "package:tuner/settings/help.dart";
import "package:tuner/settings/interval_duration.dart";
import "package:tuner/settings/theme_changer.dart";
import "package:tuner/settings/reset.dart";
import "package:tuner/settings/tuning_picker.dart";
import "package:tuner/settings/custom_tuning.dart";

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider<CustomTuningBloc>.value(
        value: CustomTuningBloc(),
        child: ListView(
          children: [
            // Select the tuning target.
            TuningPicker(),

            // Implement your own custom tuning targets.
            CustomTuning(),

            // Update how often the plugin API gets called.
            IntervalDuration(),

            // Select how far apart the frequency and target frequency can be in order to be considered on pitch.
            FrequencyTolerance(),

            // Change the sample rate.
            SampleRate(),

            // Select the number of channels.
            Channels(),

            // Button that changes the theme to dark/light once clicked, depending on which theme is currently set.
            ThemeChanger(),

            // Help dialog.
            Help(),

            // Button that resets the data and restarts the application to the current (settings) view.
            Reset(),
          ],
        ),
      ),
    );
  }
}
