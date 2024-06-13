import 'package:flutter/material.dart';
import 'pag_jogo.dart';

class simboloSelecPag extends StatelessWidget {
  final String dificuldade;

  simboloSelecPag({required this.dificuldade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha seu símbolo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pagJogo(jogador1sim: 'X', jogador2sim: 'O', contraComp: true, dificuldade: dificuldade)),
                );
              },
              child: Text('X'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pagJogo(jogador1sim: 'O', jogador2sim: 'X', contraComp: true, dificuldade: dificuldade)),
                );
              },
              child: Text('O'),
            ),
          ],
        ),
      ),
    );
  }
}
