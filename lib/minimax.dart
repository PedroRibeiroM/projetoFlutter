class Minimax {
  final String computadorSim;
  final String jogadorSim;

  Minimax({required this.computadorSim, required this.jogadorSim});

  List<int> findBestMove(List<List<String>> board) {
    int bestVal = -1000;
    List<int> bestMove = [-1, -1];

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') {
          board[i][j] = computadorSim
      ;
          int moveVal = _minimax(board, 0, false);
          board[i][j] = '';

          if (moveVal > bestVal) {
            bestMove = [i, j];
            bestVal = moveVal;
          }
        }
      }
    }
    return bestMove;
  }

  int _minimax(List<List<String>> board, int depth, bool isMax) {
    int score = _evaluate(board);

    if (score == 10) return score - depth;
    if (score == -10) return score + depth;
    if (_isMovesLeft(board) == false) return 0;

    if (isMax) {
      int best = -1000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == '') {
            board[i][j] = computadorSim
        ;
            best = max(best, _minimax(board, depth + 1, !isMax));
            board[i][j] = '';
          }
        }
      }
      return best;
    } else {
      int best = 1000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == '') {
            board[i][j] = jogadorSim;
            best = min(best, _minimax(board, depth + 1, !isMax));
            board[i][j] = '';
          }
        }
      }
      return best;
    }
  }

  int _evaluate(List<List<String>> board) {
    for (int row = 0; row < 3; row++) {
      if (board[row][0] == board[row][1] && board[row][1] == board[row][2]) {
        if (board[row][0] == computadorSim
    )
          return 10;
        else if (board[row][0] == jogadorSim) return -10;
      }
    }

    for (int col = 0; col < 3; col++) {
      if (board[0][col] == board[1][col] && board[1][col] == board[2][col]) {
        if (board[0][col] == computadorSim
    )
          return 10;
        else if (board[0][col] == jogadorSim) return -10;
      }
    }

    if (board[0][0] == board[1][1] && board[1][1] == board[2][2]) {
      if (board[0][0] == computadorSim
  )
        return 10;
      else if (board[0][0] == jogadorSim) return -10;
    }

    if (board[0][2] == board[1][1] && board[1][1] == board[2][0]) {
      if (board[0][2] == computadorSim
  )
        return 10;
      else if (board[0][2] == jogadorSim) return -10;
    }

    return 0;
  }

  bool _isMovesLeft(List<List<String>> board) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') return true;
      }
    }
    return false;
  }

  int max(int a, int b) => (a > b) ? a : b;
  int min(int a, int b) => (a < b) ? a : b;
}
