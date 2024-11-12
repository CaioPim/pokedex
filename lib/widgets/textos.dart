import 'package:flutter/material.dart';
class Texto extends StatelessWidget {

  String s;
  Color c;

  Texto(this.s, this.c);
  @override
  Widget build(BuildContext context) {
    return Text(

        s,
        style: TextStyle(
          color: c,
          fontSize: 20,

        ),
      );
    }
  }

