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

  @override
  String toString() {
    return _rows.join('|');
  }
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
  for(final board in boards) {
    print('Board:');
    print(board);
  }

  for (final number in callNumbers.split(',').map((e) => int.tryParse(e) ?? 0)) {
      boards.forEach((board) => board.callNumber(number));
      final List<Board> winners = boards.where((board) => board.isWinner()).toList();
      if(winners.isNotEmpty) {
        int position = boards.indexOf(winners.first);
        print("We have a winner! ... Board #$position");
        int score = number * winners.first.score();
        print("Final score is: $score");
        return;
      }
  }
}