import 'dart:io';

const List<String> words = [ 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'];

Future<void> main() async {
  final File input = File('1/input.txt');
  final List<String> lines = await input.readAsLines();
  final RegExp exp = RegExp(r'([0-9]|' + words.join('|') + ')');

  final int sum = lines.fold(0, (sum, line) {
    final List<String> numbers = [];
    for(int i = 0; i < line.length; i++) {
      final Iterable<RegExpMatch> matches = exp.allMatches(line, i);
      if(matches.isNotEmpty) {
        final String source = matches.first.group(0)!;
        numbers.add((source.length > 1) ? (words.indexOf(source) + 1).toString() : source);
      }
    }
    return sum + int.parse(numbers.first + numbers.last);
  });

  print("Sum: $sum");
}