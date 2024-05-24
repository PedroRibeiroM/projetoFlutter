import 'package:flutter/material.dart';

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
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late List<List<String>> _board;
  late bool _isPlayer1Turn;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    _board = List.generate(3, (_) => List.filled(3, ''));
    _isPlayer1Turn = true;
  }

  void _handleButtonPressed(int row, int col) {
    if (_board[row][col] == '') {
      setState(() {
        _board[row][col] = _isPlayer1Turn ? 'O' : 'X';
        _isPlayer1Turn = !_isPlayer1Turn;
      });
    }
  }

  Widget _buildCell(int row, int col) {
    return SizedBox(
      width: 100,
      height: 100,
      child: OutlinedButton(
        onPressed: () {
          _handleButtonPressed(row, col);
        },
        child: Text(
          _board[row][col],
          style: const TextStyle(fontSize: 40.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo da Velha'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var i = 0; i < 3; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (var j = 0; j < 3; j++) _buildCell(i, j),
                ],
              ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  _initializeBoard();
                });
              },
              child: const Text(
                'Reiniciar',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
