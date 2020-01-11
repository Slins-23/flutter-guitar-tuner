import "package:flutter/material.dart";

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child:
                    Text("Help", style: Theme.of(context).textTheme.display4),
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
      onTap: () => showAlertDialog(context),
    );
  }

  void showAlertDialog(BuildContext context) {
    Widget close = FlatButton(
      child: Text(
        "Close",
        style: TextStyle(
          fontFamily: "Roboto Condensed",
          fontSize: 16,
          letterSpacing: 0.8,
          color: Colors.red,
          inherit: false,
        ),
      ),
      color: Colors.red.withAlpha(35),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog dialog = AlertDialog(
      backgroundColor: Theme.of(context).canvasColor,
      elevation: 25,
      title: Text(
        "Help",
        style: Theme.of(context).textTheme.title.copyWith(
              fontFamily: "Roboto Condensed",
              fontSize: 20,
            ),
      ),
      content: Text(
        "Here goes help.",
        style: Theme.of(context)
            .textTheme
            .display1
            .copyWith(fontFamily: "Eczar", fontSize: 16),
      ),
      contentTextStyle: TextStyle(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
      actions: <Widget>[
        close,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}
