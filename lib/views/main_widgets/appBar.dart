import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_beta/controllers/mode.dart';

class MyAppBarActions extends StatelessWidget {
  const MyAppBarActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ModeProvider modeProvider =
        Provider.of<ModeProvider>(context, listen: false);
    return 
        IconButton(
            onPressed: () {
              modeProvider.changeThemeMode();
            },
            icon: modeProvider.mode == ThemeMode.light
                ? Icon(Icons.wb_sunny)
                : Icon(Icons.dark_mode))
     ;
  }
}
