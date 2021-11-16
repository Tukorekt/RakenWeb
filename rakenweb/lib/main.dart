import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';
import 'endpage.dart';

var resp = "", uniqueList = [];
var chosenList = []; var round = 1;

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp( MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/main',
      routes: {
        '/main':(BuildContext context) => MyHomePage(),
        '/login':(BuildContext context) => EndPage(),
      },
      onGenerateRoute: (routeSettings){
        var path = routeSettings.name!.split('/');
        if (path[1] == "main") {
          return MaterialPageRoute(
            builder: (context) => MyHomePage(),
            settings: routeSettings,
          );
        }
        if (path[1] == "login") {
          return MaterialPageRoute(
            builder: (context) => EndPage(),
            settings: routeSettings,
          );
        }
      }));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var bloc2;
  late final subscription;

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  void initState() {
    bloc2 = StringBloc({"0",""," "});
    bloc2.add(GetCount());
    subscription = bloc2.stream.listen(print);
    getData();
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }


  void getData() async {
    await Future.delayed(const Duration(seconds: 1));
    bloc2.add(Update());
    setState(() {});
  }

  Future<void> NextStage() async {
    await bloc2.add(NextStageBloc());
    if (bloc2.state.contains("truee")) {
      bloc2.add(OnCreate());
      subscription.cancel();
      bloc2.close();
      Navigator.pushReplacementNamed(context, '/login');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        title: Text(
          'Raken',
          style: GoogleFonts.montserrat(
              fontSize: 30,
              fontStyle: FontStyle.normal,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: _size.height * .005,
          ),
          SizedBox(
            width: _size.width,
            child: Center(
              child: Text(
                'Раунд $round \n${int.parse(bloc2.state.elementAt(0))+1} из ${uniqueList.length / 2}',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  color: Colors.black,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),

          Row(
            children: <Widget>[
              GestureDetector(
                child: SizedBox(
                  width: _size.width / 2,
                  height: _size.height * .8,
                  child: Card(
                    color: Colors.blue.withOpacity(.5),
                    child: Center(
                      child: Text(
                        '${bloc2.state.elementAt(1)}',
                        style: GoogleFonts.montserrat(
                          fontSize: 25,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (int.parse(bloc2.state.elementAt(0))+1 < (uniqueList.length / 2)) {
                    chosenList.add(bloc2.state.elementAt(1));
                    bloc2.add(Update());
                  }
                  else {
                    chosenList.add(bloc2.state.elementAt(1));
                    NextStage();
                  }
                  setState(() {});
                },
              ),
              GestureDetector(
                child: SizedBox(
                  width: _size.width / 2,
                  height: _size.height * .8,
                  child: Card(
                    color: Colors.red.withOpacity(.5),
                    child: Center(
                      child: Text(
                        '${bloc2.state.elementAt(2)}',
                        style: GoogleFonts.montserrat(
                          fontSize: 25,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (int.parse(bloc2.state.elementAt(0))+1 < (uniqueList.length / 2)) {
                    chosenList.add(bloc2.state.elementAt(2));
                    bloc2.add(Update());
                  }
                  else {
                    chosenList.add(bloc2.state.elementAt(2));
                    NextStage();
                  }
                  setState(() {});
                },
              )
            ],
          ),
        ],
      )
    );
  }
}
