import 'dart:io';

final Map<String, String> elfSigns = {
  'A' : 'Rock',
  'B' : 'Paper',
  'C' : 'Scissors'
};

final Map<String, int> shapeScore = {
  'Rock' : 1,
  'Paper' : 2,
  'Scissors' : 3
};

final Map<String, int> roundPoints = {
  'X' : 0,
  'Y' : 3,
  'Z' : 6
};

Future<void> main() async {
  final File input = File('2/input.txt');
  final List<String> lines = await input.readAsLines();

  int score = 0;
  for (final line in lines) {
    List<String> game = line.split(' ');
    final String elf = elfSigns[game[0]]!;
    final int points = roundPoints[game[1]]!;

    final int shapePoints = myShapePoints(elf, points);

    //print('Round: $elf vs $me: $roundPoints + $shapePoints');
    score += points + shapePoints;
    print('Semi-total: $score');
  }

  print("Total score: $score");
}

int myShapePoints(String elf, int roundPoints) {
  if(roundPoints == 3) {
    return shapeScore[elf]!;
  }
  if(roundPoints == 6) {
    switch(elf) {
      case 'Rock': return shapeScore['Paper']!;
      case 'Paper': return shapeScore['Scissors']!;
      case 'Scissors': return shapeScore['Rock']!;
    }
  }
  if(roundPoints == 0) {
    switch(elf) {
      case 'Rock': return shapeScore['Scissors']!;
      case 'Paper': return shapeScore['Rock']!;
      case 'Scissors': return shapeScore['Paper']!;
    }
  }
  throw 'Invalid game state';
}