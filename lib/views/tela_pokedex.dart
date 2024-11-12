import 'package:flutter/material.dart';

import '../widgets/textos.dart';
class TelaPokedex extends StatefulWidget {
  const TelaPokedex({super.key});

  @override
  State<TelaPokedex> createState() => _TelaPokedexState();
}

class _TelaPokedexState extends State<TelaPokedex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(211, 211, 211, 1),
          title: Texto("Pokédex", Colors.black),
        ),
        body: Center(
          child: AspectRatio(
            aspectRatio: 2 / 3, // Mantém a proporção 2:3 para o fundo
            child: Stack(
              children: [
                Container(
                  color: Color.fromRGBO(211, 211, 211, 1),
                  width: double.infinity,
                  height: double.infinity,
                ),
                // Imagem de fundo com aspect ratio 2:3
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/Data/pokedex.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  top: 250,
                  left: 180,
                  child: Image.asset(
                    'lib/Data/pokes/001.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
