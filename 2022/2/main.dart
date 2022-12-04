import 'dart:io';

final Map<String, String> elfSigns = {
  'A' : 'Rock',
  'B' : 'Paper',
  'C' : 'Scissors'
};

final Map<String, String> mySigns = {
  'X' : 'Rock',
  'Y' : 'Paper',
  'Z' : 'Scissors'
};

final Map<String, int> shapeScore = {
  'Rock' : 1,
  'Paper' : 2,
  'Scissors' : 3
};

Future<void> main() async {
  final File input = File('2/input.txt');
  final List<String> lines = await input.readAsLines();

  int score = 0;
  for (final line in lines) {
    List<String> game = line.split(' ');
    final String elf = elfSigns[game[0]]!;
    final String me = mySigns[game[1]]!;
    final int roundPoints = gamePoints(elf, me);
    final int shapePoints = shapeScore[me]!;
    print('Round: $elf vs $me: $roundPoints + $shapePoints');
    score += roundPoints + shapePoints;
    print('Semi-total: $score');
  }

  print("Total score: $score");
}

int gamePoints(String elf, String me) {
  if(me == elf) return 3;
  if(me == 'Rock' && elf == 'Scissors') return 6;
  if(me == 'Scissors' && elf == 'Paper') return 6;
  if(me == 'Paper' && elf == 'Rock') return 6;
  return 0;
}