import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:tuner/blocs/theme_bloc.dart";
import "package:shared_preferences/shared_preferences.dart";

class ThemeChanger extends StatelessWidget {
  final Themes themes = new Themes();
  static String currentTheme;

  @override
  Widget build(BuildContext context) {
    ThemeChangerBloc _themeChanger = Provider.of<ThemeChangerBloc>(context);

    return InkWell(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Text("Change Theme to Light/Dark",
                    style: Theme.of(context).textTheme.display4),
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
      onTap: () => _updateData(_themeChanger),
    );
  }

  _updateData(ThemeChangerBloc themeChanger) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "Theme";
    if (themeChanger.getTheme() == Themes.dark) {
      await prefs.setString(key, "light");
      themeChanger.setTheme(Themes.light);
    } else if (themeChanger.getTheme() == Themes.light) {
      await prefs.setString(key, "dark");
      themeChanger.setTheme(Themes.dark);
    } else {
      throw new Exception("Could not set theme.");
    }
  }
}