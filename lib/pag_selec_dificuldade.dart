import 'package:flutter/material.dart';
import 'pag_selec_simbolo.dart';

class dificuldadeSelecPag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha a dificuldade'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => simboloSelecPag(dificuldade: 'easy')),
                );
              },
              child: Text('Fácil'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => simboloSelecPag(dificuldade: 'hard')),
                );
              },
              child: Text('Difícil'),
            ),
          ],
        ),
      ),
    );
  }
}
