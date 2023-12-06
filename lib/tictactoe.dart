// new type with fixed number of values it can take on
import 'dart:html';

enum Player {
  //initialize these enum vars with string rep
  //because line 14
  none('-'),
  x('x'),
  o('o');

  //Associate each type a String representation
  //or we can attach other fields to enum like we do with object
  //by declaring final/const
  final String str;

  //like constructor: name of enum
  const Player(this.str);

  //Override toString
  @override
  // String toString() {
  //   return str;
  // }
  String toString() => str;
}

class TicTacToeState {
  static const size = 3;
  static const numCells = size * size;
  //all winning states
  static const lines = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  //field associated with each state
  //not initialize it here -> init later
  //use 'late'
  late List<Player> board;
  late Player currentPlayer, winner;
  late int turn;

  //default constructor
  TicTacToeState() {
    //reset the state
    reset();
  }

  void reset() {
    //no one plays in this initial state
    //9 cells
    board = List.filled(numCells, Player.none);
    currentPlayer = Player.x;
    winner = Player.none;
    turn = 0; //0 turns have been taken
  }

  bool playAt(int i) {
    if (winner == Player.none && board[i] == Player.none) {
      board[i] = currentPlayer;
      currentPlayer = (currentPlayer == Player.x) ? Player.o : Player.x;
      turn++;
      _checkWinner();
      return true;
    }
    return false;
  }

  void _checkWinner() {
    for (List<int> line in lines) {
      if (board[line[0]] != Player.none &&
          board[line[0]] == board[line[1]] &&
          board[line[1]] == board[line[2]]) {
            winner = board[line[0]];
            return;
          }
    }
  }

  Player getWinner() => winner;

  bool isGameOver() => turn == numCells || winner != Player.none;

  String getStatus() {
    if (isGameOver()) {
      if (winner == Player.none) {
        return 'Draw';
      }
      return '$winner wins!';
    }
    return '$currentPlayer to play';
  }

  @override
  //toString for TicTacToeState
  String toString() {
    var sb = StringBuffer();

    for (int i = 0; i < board.length; i++) {
      sb.write(board[i].toString());

      if (i % size == size - 1) {
        sb.writeln();
      }
    }
    sb.writeln(getStatus());
    return sb.toString();
  }
}

//Test code
void main() {
  // var s = TicTacToeState();
  // print(s);
  // // self convert to index 0 - 8
  // var plays = [4, 0, 2, 6, 3, 5, 7, 1, 8];
  // for (var i in plays) {
  //   print('Playing at $i.');
  //   s.playAt(i);
  //   print(s);
  // }
}