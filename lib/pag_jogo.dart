import 'package:flutter/material.dart';
import 'dart:math';
import 'minimax.dart';

class pagJogo extends StatefulWidget {
  final String jogador1sim;
  final String jogador2sim;
  final bool contraComp;
  final String dificuldade;

  pagJogo({required this.jogador1sim, required this.jogador2sim, required this.contraComp, required this.dificuldade});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<pagJogo> {
  late List<List<String>> _campo;
  late bool _jogadaJogador;
  late String _ganhador;
  late int _jogador1vit;
  late int _jogador2vit;
  late Minimax _minimax;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
    _jogador1vit = 0;
    _jogador2vit = 0;
    _minimax = Minimax(computadorSim: widget.jogador2sim, jogadorSim: widget.jogador1sim);

    if (widget.jogador1sim == 'O' && widget.contraComp) {
      _jogadaJogador = false;
      _performComputerMove();
    }
  }

  void _initializeBoard() {
    _campo = List.generate(3, (_) => List.filled(3, ''));
    _jogadaJogador = true;
    _ganhador = '';
  }

  void _handleButtonPressed(int row, int col) {
    if (_campo[row][col] == '' && _ganhador == '') {
      setState(() {
        _campo[row][col] = _jogadaJogador ? widget.jogador1sim : widget.jogador2sim;
        if (_checkWinner(row, col)) {
          _ganhador = _jogadaJogador ? widget.jogador1sim : widget.jogador2sim;
          if (_ganhador == widget.jogador1sim) {
            _jogador1vit++;
          } else {
            _jogador2vit++;
          }
          _showWinnerDialog(_ganhador);
        } else if (_isBoardFull()) {
          _showWinnerDialog(null);
        } else {
          _jogadaJogador = !_jogadaJogador;
          if (!_jogadaJogador && widget.contraComp) {
            _performComputerMove();
          }
        }
      });
    }
  }

  void _performComputerMove() {
    if (widget.dificuldade == 'easy') {
      _performRandomMove();
    } else {
      var bestMove = _minimax.findBestMove(_campo);
      _handleButtonPressed(bestMove[0], bestMove[1]);
    }
  }

  void _performRandomMove() {
    var emptyCells = <List<int>>[];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_campo[i][j] == '') {
          emptyCells.add([i, j]);
        }
      }
    }

    var random = Random();
    var move = emptyCells[random.nextInt(emptyCells.length)];
    _handleButtonPressed(move[0], move[1]);
  }

  bool _checkWinner(int row, int col) {
    String player = _campo[row][col];

    // Check row
    if (_campo[row].every((cell) => cell == player)) return true;

    // Check column
    if (_campo.every((row) => row[col] == player)) return true;

    // Check diagonal
    if (row == col && _campo.every((row) => row[_campo.indexOf(row)] == player)) return true;

    // Check anti-diagonal
    if (row + col == 2 && _campo.every((row) => row[2 - _campo.indexOf(row)] == player)) return true;

    return false;
  }

  bool _isBoardFull() {
    return _campo.every((row) => row.every((cell) => cell != ''));
  }

  void _showWinnerDialog(String? ganhador) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(ganhador != null ? 'Vencedor' : 'Empate'),
          content: Text(ganhador != null ? 'Jogador $ganhador venceu!' : 'O jogo terminou em empate!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _initializeBoard();
                  if (widget.jogador1sim == 'O' && widget.contraComp) {
                    _jogadaJogador = false;
                    _performComputerMove();
                  }
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
          if (_jogadaJogador || !widget.contraComp) {
            _handleButtonPressed(row, col);
          }
        },
        child: Text(
          _campo[row][col],
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
                'Vitórias - ${widget.jogador1sim}: $_jogador1vit | ${widget.jogador2sim}: $_jogador2vit',
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
                  if (widget.jogador1sim == 'O' && widget.contraComp) {
                    _jogadaJogador = false;
                    _performComputerMove();
                  }
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
