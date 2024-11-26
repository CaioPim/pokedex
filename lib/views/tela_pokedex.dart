import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/textos.dart';
class TelaPokedex extends StatefulWidget {
  const TelaPokedex({super.key});

  @override
  State<TelaPokedex> createState() => _TelaPokedexState();
}

Future<Map<String, dynamic>> loadJsonData() async {
  // Carrega o arquivo JSON
  String jsonString = await rootBundle.loadString('lib/Data/pokemon.json-master/pokemonDescricao.json');

  // Converte o conteúdo JSON para um Map
  Map<String, dynamic> jsonData = jsonDecode(jsonString);

  return jsonData;
}

Future<void> uploadJsonToFirestore() async {
  // Carregar dados do JSON
  Map<String, dynamic> jsonData = await loadJsonData();

  // Referência para a coleção onde os dados serão armazenados
  CollectionReference collection = FirebaseFirestore.instance.collection('dados_json');

  // Adicionar os dados ao Firestore
  try {
    await collection.add(jsonData);
    print('Dados adicionados ao Firestore!');
  } catch (e) {
    print('Erro ao adicionar dados: $e');
  }
}


class _TelaPokedexState extends State<TelaPokedex> {
  @override

  int numPoke = 1;
  String imagem =  "lib/Data/pokes/";
  String imagem2 = ".png";

  String sprite = "lib/Data/sprites/";
  String sprite2 = "MS.png";

  String imagePath = "lib/Data/pokes/001.png";
  String spritePath = "lib/Data/sprites/001MS.png";
  String nomePoke = "Bulbasaur";
  String descricao = "O bulbo em suas costas está cheio de nutrientes. Nele, Bulbasaur armazena suas energias. O bulbo vai crescendo à medida que envelhece porque ele absorve os raios de sol.";
  String numeroTexto = 1.toString().padLeft(3, '0');




  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(211, 211, 211, 1),
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
                width: double.infinity,
                height: double.infinity,
              ),
              Align(
                alignment: Alignment(-0.15,-0.25),
                child: FractionallySizedBox(
                  alignment: Alignment.center,
                  widthFactor: 0.3,
                  heightFactor: 0.3,
                  child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.55,0.18),
                child: FractionallySizedBox(
                  alignment: Alignment.center,
                  widthFactor: 0.13,
                  heightFactor: 0.13,
                  child: Image.asset(
                    spritePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.45,0.44),
                child: Container(
                  width: 70,
                  height: 70,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(227, 227, 227, 1),
                    ),
                    onPressed: () {
                      proximoPoke();
                    },
                    child: Image.asset(
                      'lib/Data/arrow.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(-0.65,0.44),
                child: Container(
                  width: 70,
                  height: 70,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(227, 227, 227, 1),
                    ),
                    onPressed: () {
                      anteriorPoke();
                    },
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(3.14159), // Inverte a imagem no eixo X (vertical)
                      child: Image.asset(
                        'lib/Data/arrow.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(-0.25,0.16),
                child: Container(
                    width: 150,
                    height: 50,
                    child: Align(
                      child: Texto(
                          nomePoke,
                          Colors.black,
                          17
                      ),
                    )
                ),
              ),
              Align(
                alignment: Alignment(-0.85,0.16),
                child: Container(
                    width: 150,
                    height: 60,
                    child: Align(
                    child: Texto(
                          numeroTexto,
                          Colors.black,
                          17
                      ),
                    )
                ),
              ),
              Align(
                alignment: Alignment(-0.25, 0.90), // Define o alinhamento do widget na tela
                child: Container(
                  width: 250, // Largura do Container
                  height: 125, // Altura do Container
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.5), // Fundo branco com 50% de transparência
                    border: Border.all(color: Colors.black, width: 1), // Borda azul com largura de 2
                    borderRadius: BorderRadius.circular(3), // Bordas arredondadas
                  ),
                  child: Align(
                    alignment: Alignment.center, // Alinha o texto no centro do Container
                    child: Texto(descricao, Colors.black, 15)
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void proximoPoke() async{
    if (numPoke == 151){
      numPoke = 1;
    }else{
      numPoke = numPoke +1;
    }
    String numeroComTresDigitos = numPoke.toString().padLeft(3, '0');

    await buscarPoke();

    setState(() {
      imagePath = imagem + numeroComTresDigitos + imagem2;
      spritePath = sprite + numeroComTresDigitos + sprite2;
      numeroComTresDigitos = numeroComTresDigitos;
    });
  }
  void anteriorPoke() async{
    if (numPoke == 1){
      numPoke = 151;
    }else{
      numPoke = numPoke -1;
    }
    String numeroComTresDigitos = numPoke.toString().padLeft(3, '0');

    await buscarPoke();
    setState(() {
      imagePath = imagem + numeroComTresDigitos + imagem2;
      spritePath = sprite + numeroComTresDigitos + sprite2;
      numeroComTresDigitos = numeroComTresDigitos;

    });
  }

  Future<String> buscarPoke() async {
    String numeroComTresDigitos = numPoke.toString().padLeft(3, '0');

    // Acessa a coleção 'dados_json' e o documento específico que contém o array 'pokemons'
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('dados_json')
        .doc('k2PsqDhnYTDVJdB5MUP3')
        .get();

    if (docSnapshot.exists) {
      // Obtém o array 'pokemons' do documento
      List<dynamic> pokemons = docSnapshot['pokemons'];

      if (pokemons[0].containsKey(numeroComTresDigitos)) {
        Map<String, dynamic> pokemon = pokemons[0][numeroComTresDigitos];
        print("$numeroComTresDigitos ${pokemon['name']}");
        alteraTexto(pokemon['name'], pokemon['descricao']);
        return(numeroComTresDigitos);
      } else {
        print('Chave $numeroComTresDigitos não encontrada.');
        return("000");

      }
    } else {
      print('Documento não encontrado.');
      return("000");
    }

  }

  void alteraTexto(String nome, String descricaoTexto) {
    String numeroComTresDigitos = numPoke.toString().padLeft(3, '0');

    setState(() {
      nomePoke = "${nome}";
      numeroTexto = numeroComTresDigitos;
      descricao = descricaoTexto;
    });
  }
}
