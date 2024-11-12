import 'package:flutter/material.dart';
import 'package:pokedex/views/tela_pokedex.dart';
import 'package:pokedex/widgets/textos.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(211, 10, 64, 1),
        title: Texto("Pokédex", Colors.black87),
        actions: [
          IconButton(
            onPressed: (){
                _abrePokedex(context, TelaPokedex());
              },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }


  _abrePokedex(ctx, page) {
    Navigator.push(ctx, MaterialPageRoute(builder: (BuildContext context)
    {
      return page;
    }));
  }
}
