import 'dart:io';

class Field {
  static const int size = 1000;
  final List<List<int>> _table = List<List<int>>.generate(size, (i) => List<int>.generate(size, (i) => 0));

  void addLine(Line line) {
    int x = line.x1;
    int y = line.y1;
    _table[y][x]++;
    while(x != line.x2 || y != line.y2) {
      if(x < line.x2) x++;
      if(x > line.x2) x--;
      if(y < line.y2) y++;
      if(y > line.y2) y--;
      _table[y][x]++;
    }
  }

  int getDangerousFields() {
    return _table
        .map((e) => e.where((element) => element >= 2))
        .map((e) => e.length)
        .reduce((value, element) => value + element);
  }

  void graph() {
    _table
        .map((e) => e.map((number) => " ${(number > 0) ? number : '.'} ").join())
        .forEach((element) => print(element));
  }
}

class Line {
  late int x1, y1, x2, y2;

  Line(final String line) {
    var re = RegExp(r'([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)');
    final match = re.allMatches(line).toList()[0];

    x1 = int.parse(match[1]!);
    y1 = int.parse(match[2]!);
    x2 = int.parse(match[3]!);
    y2 = int.parse(match[4]!);
  }

  @override
  String toString() {
    return 'Line [$x1, $y1] -> [$x2, $y2]';
  }
}

Future<void> main() async {
  final File input = File('5/input.txt');
  final List<String> lines = await input.readAsLines();
  final List<Line> processedLines = lines.map((e) => Line(e)).toList();
  /*final List<Line> validLines = processedLines
      .where((line) => line.x1 == line.x2 || line.y1 == line.y2)
      .toList();*/

  final Field field = Field();
  processedLines.forEach((element) => field.addLine(element));
  //field.graph();

  print('');
  print("Loaded ${lines.length} lines ... processed ${processedLines.length}");
  print("Number of dangerous fields: ${field.getDangerousFields()}");
}