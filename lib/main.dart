import 'package:flutter/material.dart';
import 'pag_selec_dificuldade.dart';
import 'pag_jogo.dart';

void main() {
  runApp(GameApp());
}

class GameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Velha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Velha'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Escolha seu modo de jogo',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pagJogo(jogador1sim: 'X', jogador2sim: 'O', contraComp: false, dificuldade: '')),
                );
              },
              child: Text('Jogar contra outro jogador'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => dificuldadeSelecPag()),
                );
              },
              child: Text('Jogar contra o computador'),
            ),
          ],
        ),
      ),
    );
  }
}
