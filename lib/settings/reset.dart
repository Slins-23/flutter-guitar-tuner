import "package:flutter/material.dart";
import 'package:tuner/main.dart';

class Reset extends StatelessWidget {
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
                child: Text("Reset settings to default",
                    style: Theme.of(context).textTheme.headline1),
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
      onTap: () async => {
        RestartWidget.restartApp(context),
      },
    );
  }
}
