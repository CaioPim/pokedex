import 'package:flutter/material.dart';
class Texto extends StatelessWidget {

  String s;
  Color c;
  double size;

  Texto([this.s = "", this.c = Colors.black, this.size = 20]);
  @override
  Widget build(BuildContext context) {
    return Text(

        s,
        style: TextStyle(
          color: c,
          fontSize: size,


        ),
      );
    }
  }

