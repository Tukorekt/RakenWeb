import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc.dart';

var src = "https://i.imgur.com/R92ZuGn.png", name ="", date ="", country ="", rating ="", kinds ="", pg ="", time ="";
var data;

class EndPage extends StatefulWidget {
  EndPage({Key? key}) : super(key: key);

  @override
  State<EndPage> createState() => _EndPage();
}

class _EndPage extends State<EndPage>{
  var bloc;

  Future<void> Response() async {
    setState(() async {
      await bloc.add(OnCreate());
      await bloc.add(GetEnd());
    });
  }

  @override
  void initState() {
    bloc = StringBloc({"https://i.imgur.com/R92ZuGn.png"," ","  ","   ","    ","     ","      ","       ","        "});
    Response();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Raken: Результат',
          style: GoogleFonts.montserrat(
            fontSize: 30,
            fontStyle: FontStyle.normal,
            color: Colors.white,
            fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purpleAccent,
        actions: [
          GestureDetector(
            child: const Icon(Icons.arrow_back,),
            onTap: (){
              Navigator.pushReplacementNamed(context, '/main');
            },
          )
        ],
      ),
      body: Center(
        child: Row(
          children: [
            Image.network(src, height: _size.height / 2,),
            SizedBox(
              height: _size.height / 2,
              child: Column(
                children: [
                  Text(
                    name,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    date,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    country,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    rating,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    kinds,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    pg,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    time,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _size.height / 2,
              child: Column(
                children: [
                  GestureDetector(
                    child: const Card(
                      child: Text('Выбрать иначе'),
                    ),
                    onTap: (){
                      Navigator.pushReplacementNamed(context, '/main');
                    },
                  ),
                  GestureDetector(
                    child: const Card(
                      child: Text('Следующий'),
                    ),
                    onTap: (){
                      bloc.add(GetEnd());
                      setState(() {});
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}

