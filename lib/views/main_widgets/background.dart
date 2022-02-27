import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_beta/controllers/mode.dart';

class BackGround extends StatelessWidget {
  final child;

  const BackGround({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = Provider.of<ModeProvider>(context).mode;
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(themeMode == ThemeMode.dark
                    ? "assets/images/b.jpg"
                    : "assets/images/mb.jpg"),
                fit: BoxFit.fill)),
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: themeMode == ThemeMode.dark
                        ? [Colors.black87, Colors.black38]
                        : [Colors.transparent, Colors.grey.withOpacity(0.2)])),

            //
            //
            //
            //
            child: child));
  }
}
