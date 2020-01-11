import "package:flutter/material.dart";
import 'package:tuner/colors/dark_colors.dart';
import 'package:tuner/colors/light_colors.dart';

class ThemeChangerBloc with ChangeNotifier {
  ThemeData _themeData;

  ThemeChangerBloc(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData theme) {
    _themeData = theme;

    notifyListeners();
  }
}

class Themes {
  static ThemeData light = _buildLightTheme();

  static ThemeData dark = _buildDarkTheme();

  static ThemeData _buildLightTheme() {
    final base = ThemeData.light();
    return ThemeData(
      scaffoldBackgroundColor: LightTunerColors.primaryBackground,
      primaryColor: LightTunerColors.primaryBackground,
      focusColor: LightTunerColors.focusColor,
      textTheme: _buildLightTextTheme(base.textTheme),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(
          color: LightTunerColors.gray,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: LightTunerColors.inputBackground,
        focusedBorder: InputBorder.none,
      ),
      buttonColor: LightTunerColors.buttonColor,
      canvasColor: LightTunerColors.inputBackground,
      cardColor: LightTunerColors.cardBackground,
    );
  }

  static ThemeData _buildDarkTheme() {
    final base = ThemeData.dark();
    return ThemeData(
      scaffoldBackgroundColor: DarkTunerColors.primaryBackground,
      primaryColor: DarkTunerColors.primaryBackground,
      focusColor: DarkTunerColors.focusColor,
      textTheme: _buildDarkTextTheme(base.textTheme),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(
          color: DarkTunerColors.gray,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: DarkTunerColors.inputBackground,
        focusedBorder: InputBorder.none,
      ),
      buttonColor: DarkTunerColors.buttonColor,
      canvasColor: DarkTunerColors.inputBackground,
      cardColor: DarkTunerColors.cardBackground,
    );
  }

  static TextTheme _buildLightTextTheme(TextTheme base) {
    return base
        .copyWith(
          body1: base.body1.copyWith(
            fontFamily: 'Roboto Condensed',
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          body2: base.body2.copyWith(
            fontFamily: 'Eczar',
            fontSize: 40,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.4,
            shadows: [
              Shadow(
                blurRadius: 5,
                color: Colors.black,
                offset: Offset.lerp(
                    Offset.fromDirection(5), Offset.fromDirection(-5), 3),
              ),
              Shadow(
                blurRadius: 10,
                color: Colors.black,
                offset: Offset.lerp(
                    Offset.fromDirection(5), Offset.fromDirection(-5), 3),
              ),
              Shadow(
                blurRadius: 0,
                color: Colors.black,
                offset: Offset.lerp(
                    Offset.fromDirection(5), Offset.fromDirection(-5), 2),
              ),
            ],
          ),
          display1: base.display1.copyWith(
            fontFamily: 'Eczar',
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
          display2: base.display2.copyWith(
            fontFamily: 'Eczar',
            fontSize: 34,
            fontWeight: FontWeight.w500,
          ),
          display3: base.display3.copyWith(
            fontFamily: 'Eczar',
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          display4: base.display4.copyWith(
            fontFamily: 'Roboto Condensed',
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          caption: base.caption.copyWith(
            fontFamily: "Roboto Condensed",
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          button: base.button.copyWith(
            fontFamily: 'Roboto Condensed',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 1.5,
            shadows: [
              Shadow(
                blurRadius: 0,
                color: Colors.black,
                offset: Offset.lerp(
                    Offset.fromDirection(0), Offset.fromDirection(-6), 8),
              ),
              Shadow(
                blurRadius: 0,
                color: Colors.black,
                offset: Offset.lerp(
                    Offset.fromDirection(0), Offset.fromDirection(-6), 9),
              ),
              Shadow(
                blurRadius: 0,
                color: Colors.black,
                offset: Offset.lerp(
                    Offset.fromDirection(0), Offset.fromDirection(-6), 10),
              ),
              Shadow(
                blurRadius: 0,
                color: Colors.black,
                offset: Offset.lerp(
                    Offset.fromDirection(0), Offset.fromDirection(-6), 11),
              ),
            ],
          ),
          headline: base.body2.copyWith(
            fontFamily: 'Eczar',
            fontSize: 40,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.4,
          ),
        )
        .apply(
          displayColor: Colors.black,
          bodyColor: Colors.black,
        );
  }

  static TextTheme _buildDarkTextTheme(TextTheme base) {
    return base
        .copyWith(
          body1: base.body1.copyWith(
            fontFamily: 'Roboto Condensed',
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          body2: base.body2.copyWith(
            fontFamily: 'Eczar',
            fontSize: 40,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.4,
            shadows: [
              Shadow(
                blurRadius: 5,
                color: Colors.black,
                offset: Offset.lerp(
                    Offset.fromDirection(5), Offset.fromDirection(-5), 3),
              ),
              Shadow(
                blurRadius: 10,
                color: Colors.black,
                offset: Offset.lerp(
                    Offset.fromDirection(5), Offset.fromDirection(-5), 3),
              ),
              Shadow(
                blurRadius: 0,
                color: Colors.black,
                offset: Offset.lerp(
                    Offset.fromDirection(5), Offset.fromDirection(-5), 3),
              ),
            ],
          ),
          display1: base.display1.copyWith(
            fontFamily: 'Eczar',
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
          display2: base.display2.copyWith(
            fontFamily: 'Eczar',
            fontSize: 35,
            fontWeight: FontWeight.w500,
          ),
          display3: base.display3.copyWith(
            fontFamily: 'Eczar',
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          display4: base.display4.copyWith(
            fontFamily: 'Roboto Condensed',
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          caption: base.caption.copyWith(
            fontFamily: "Roboto Condensed",
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          button: base.button.copyWith(
            fontFamily: 'Roboto Condensed',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 1.5,
            shadows: [
              Shadow(
                blurRadius: 0,
                color: Colors.black,
                offset: Offset.lerp(
                    Offset.fromDirection(0), Offset.fromDirection(-6), 8),
              ),
              Shadow(
                blurRadius: 0,
                color: Colors.black,
                offset: Offset.lerp(
                    Offset.fromDirection(0), Offset.fromDirection(-6), 9),
              ),
              Shadow(
                blurRadius: 0,
                color: Colors.black,
                offset: Offset.lerp(
                    Offset.fromDirection(0), Offset.fromDirection(-6), 10),
              ),
              Shadow(
                blurRadius: 0,
                color: Colors.black,
                offset: Offset.lerp(
                    Offset.fromDirection(0), Offset.fromDirection(-6), 11),
              ),
            ],
          ),
          headline: base.body2.copyWith(
            fontFamily: 'Eczar',
            fontSize: 40,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.4,
          ),
        )
        .apply(
          displayColor: Colors.white,
          bodyColor: Colors.white,
        );
  }
}
