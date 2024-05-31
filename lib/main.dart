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
  late String _winner;
  late int _player1Wins;
  late int _player2Wins;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
    _player1Wins = 0;
    _player2Wins = 0;
  }

  void _initializeBoard() {
    _board = List.generate(3, (_) => List.filled(3, ''));
    _isPlayer1Turn = true;
    _winner = '';
  }

  void _handleButtonPressed(int row, int col) {
    if (_board[row][col] == '' && _winner == '') {
      setState(() {
        _board[row][col] = _isPlayer1Turn ? 'O' : 'X';
        if (_checkWinner(row, col)) {
          _winner = _isPlayer1Turn ? 'O' : 'X';
          if (_winner == 'O') {
            _player1Wins++;
          } else {
            _player2Wins++;
          }
          _showWinnerDialog(_winner);
        } else if (_isBoardFull()) {
          _showWinnerDialog("nada");
        } else {
          _isPlayer1Turn = !_isPlayer1Turn;
        }
      });
    }
  }

  bool _checkWinner(int row, int col) {
    String player = _board[row][col];

    // checar linha
    if (_board[row].every((cell) => cell == player)) return true;

    // checar coluna
    if (_board.every((row) => row[col] == player)) return true;

    // checar diagonal
    if (row == col && _board.every((row) => row[_board.indexOf(row)] == player))
      return true;

    // checar diagonal invertida
    if (row + col == 2 &&
        _board.every((row) => row[2 - _board.indexOf(row)] == player))
      return true;

    return false;
  }

  bool _isBoardFull() {
    return _board.every((row) => row.every((cell) => cell != ''));
  }

  void _showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(winner != "nada" ? 'Vencedor' : 'Empate'),
          content: Text(winner != "nada"
              ? 'Jogador $winner venceu!'
              : 'O jogo terminou em empate!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _initializeBoard();
                });
              },
              child: Text('Reiniciar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCell(int row, int col) {
    return SizedBox(
      width: 100,
      height: 100,
      child: ElevatedButton(
        onPressed: () {
          _handleButtonPressed(row, col);
        },
        child: Text(
          _board[row][col],
          style: TextStyle(fontSize: 40.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Velha'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Vitórias - O: $_player1Wins | X: $_player2Wins',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            for (var i = 0; i < 3; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (var j = 0; j < 3; j++) _buildCell(i, j),
                ],
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _initializeBoard();
                });
              },
              child: Text(
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
