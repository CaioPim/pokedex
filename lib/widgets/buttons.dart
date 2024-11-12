import 'package:flutter/material.dart';
import 'textos.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  Button(this.text, {required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          onPrimary: Colors.amberAccent,
          primary: Colors.black87,
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

      ),
      onPressed: onPressed,
      child: Texto(text, Colors.amberAccent),
    );
  }
}
