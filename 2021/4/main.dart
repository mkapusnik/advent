import 'dart:io';
import 'dart:math';

class Board {
  List<List<int>> _rows = [];
  List<List<int>> _columns = [];

  Board(final List<String> table) {
    _columns.add([]);
    _columns.add([]);
    _columns.add([]);
    _columns.add([]);
    _columns.add([]);

    for(int y = 0; y < table.length; y++) {
      final List<int> row = table[y]
          .split(' ')
          .where((element) => element.isNotEmpty)
          .map((e) => int.tryParse(e) ?? 0)
          .toList();
      if(row.length > 5) print(row.join('-'));
      _rows.add(row);
      for(int x = 0; x < row.length; x++) {
        _columns[x].add(row[x]);
      }
    }
  }

  bool isWinner() {
    for(List<int> row in _rows) {
      if(row.every((element) => element == -1)) return true;
    }
    for(List<int> column in _columns) {
      if(column.every((element) => element == -1)) return true;
    }
    return false;
  }

  void callNumber(int number) {
    for(List<int> row in _rows) {
      int pos = row.indexWhere((element) => element == number);
      if(pos >= 0) row[pos] = -1;
    }
    for(List<int> column in _columns) {
      int pos = column.indexWhere((element) => element == number);
      if(pos >= 0) column[pos] = -1;
    }
  }

  int score() {
    return _rows.map((e) => e.reduce(reducer)).reduce(reducer);
  }

  int reducer(int value, int element) {
    return max(value, 0) + max(element, 0);
  }

  List<String> get rows => _rows.map((e) => e.join(',')).toList();
  List<String> get columns => _columns.map((e) => e.join(',')).toList();
}

Future<void> main() async {
  final File input = File('4/input.txt');
  final List<String> lines = await input.readAsLines();

  final String callNumbers = lines[0];
  final List<Board> boards = [];

  for(int pos = 1; (pos+5) < lines.length; pos+=6) {
    final Board board = Board(lines.sublist(pos+1, pos+6));
    boards.add(board);
  }

  print("Loaded ${boards.length} boards ...");

  Board lastWinner = boards[0];
  int lastNumber = -1;
  for (final number in callNumbers.split(',').map((e) => int.tryParse(e) ?? 0)) {
      boards.forEach((board) => board.callNumber(number));
      final List<Board> winners = boards.where((board) => board.isWinner()).toList();
      boards.removeWhere((board) => board.isWinner());

      if(winners.isNotEmpty) {
        lastWinner = winners.first;
        lastNumber = number;
      }
  }

  print('We have the last winner!');
  int score = lastNumber * lastWinner.score();
  print("Final score is: $score");
  print("Number: $lastNumber | Score: ${lastWinner.score()}");
  for(final row in lastWinner.rows) print(row);
  print('   ----    ');
  for(final column in lastWinner.columns) print(column);
}