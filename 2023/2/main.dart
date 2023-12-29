import 'dart:io';
import 'dart:math';

const Map<String, int> maximum = {
  'red' : 12,
  'green': 13,
  'blue' : 14
};

Future<void> main() async {
  final File input = File('2/input.txt');
  final List<String> lines = await input.readAsLines();
  final RegExp expGame = RegExp(r'Game ([0-9]+):');
  final RegExp expDice = RegExp(r'([0-9]+) (blue|green|red)');

  final int sum = lines.fold(0, (sum, line) {
    final String id = expGame.firstMatch(line)!.group(1)!;
    final List<String> games = line.substring(line.indexOf(':')+1).split(';');

    final Map<String, int> minimum = {
      'red' : 0,
      'green': 0,
      'blue' : 0
    };

    games.forEach((game) {
      final Map<String, int> result = Map.fromEntries(game.split(',').map((dice) {
        final RegExpMatch match = expDice.firstMatch(dice)!;
        return MapEntry(match.group(2)!, int.parse(match.group(1)!));
      }));
      result.forEach((key, value) {
        minimum[key] = max(minimum[key]!, value);
      });
    });

    return sum + minimum.entries.fold(1, (previousValue, element) => previousValue * element.value);
  });

  print("Sum: $sum");
}