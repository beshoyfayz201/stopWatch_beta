import 'package:flutter/material.dart';
import 'dart:async';
import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_beta/controllers/mode.dart';
import 'package:stop_watch_beta/styles/themes.dart';
import 'package:stop_watch_beta/views/main_widgets/appBar.dart';
import 'package:stop_watch_beta/views/main_widgets/background.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ModeProvider(), child: HomeSettings());
  }
}

class HomeSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: A(),
      themeMode: Provider.of<ModeProvider>(context).mode,
      darkTheme: AppStyles.dark,
      theme: AppStyles.light
    );
  }
}

class A extends StatefulWidget {
  State<StatefulWidget> createState() {
    return AState();
  }
}

class AState extends State<A> {
  Stopwatch watch = Stopwatch();
  late Timer timer;
  String elapsedTime = "0 : 0 : 0";
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();
  final _chartSize = const Size(250, 250);
  Color labelColor = Colors.blue;

  build(BuildContext context) {
    TextStyle _labelStyle = TextStyle(
        fontSize: 24,
        color: Provider.of<ModeProvider>(context).mode == ThemeMode.dark
            ? Colors.cyan.shade200
            : Colors.black);

    return Scaffold(
      appBar: AppBar(
        actions: [MyAppBarActions()],
      ),
      body: BackGround(
        //
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Container(
              child: AnimatedCircularChart(
                key: _chartKey,
                size: _chartSize,
                initialChartData: _generateChartData(0, 0),
                chartType: CircularChartType.Radial,
                edgeStyle: SegmentEdgeStyle.round,
                percentageValues: true,
                holeLabel: elapsedTime,
                labelStyle: _labelStyle,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: stopWatch,
                  child: Icon(
                    Icons.stop,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: resetWatch,
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: startWatch,
                  child: Icon(Icons.play_arrow, color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  startWatch() {
    watch.start();
    timer = new Timer.periodic(Duration(milliseconds: 100), updateTime);
  }

  stopWatch() {
    watch.stop();
    setTime();
  }

  resetWatch() {
    watch.reset();
    setTime();
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
      List<CircularStackEntry> data = _generateChartData(0, 0);
      _chartKey.currentState!.updateData(data);
    });
  }

  transformMilliSeconds(int i) {
    int hundreds = (i / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = ((minutes % 60).toString().padLeft(2, "0"));
    String secondsStr = ((seconds % 60).toString().padLeft(2, "0"));
    String hundredsStr = ((hundreds % 100).toString().padLeft(2, "0"));

    return "$minutesStr : $secondsStr : $hundredsStr";
  }

  List<CircularStackEntry> _generateChartData(int min, int sec) {
    double temp = sec * 0.6;
    double tempmin = min * 0.6;
    double adjustedMin = tempmin + min;
    double adjustedSeo = sec + temp;
    Color dialColor = Colors.orange[900]!;
    labelColor = dialColor;
    List<CircularStackEntry> data = [
      new CircularStackEntry([new CircularSegmentEntry(adjustedSeo, dialColor)])
    ];

    if (min > 0) {
      data.removeAt(0);

      data.add(
          CircularStackEntry([CircularSegmentEntry(adjustedSeo, Colors.blue)]));
      data.add(CircularStackEntry(
          [CircularSegmentEntry(adjustedMin, Colors.green)]));
    }
    return data;
  }

  updateTime(Timer timer) {
    if (watch.isRunning) {
      var milliseconds = watch.elapsedMilliseconds;
      int hundreds = (milliseconds / 10).truncate();
      int seconds = (hundreds / 100).truncate();
      int minutes = (seconds / 60).truncate();
      setState(() {
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
        if (seconds > 59) {
          seconds = seconds - (59 * minutes);
          seconds = seconds - minutes;
        }
        List<CircularStackEntry> data = _generateChartData(minutes, seconds);
        _chartKey.currentState!.updateData(data);
      });
    }
  }
}
