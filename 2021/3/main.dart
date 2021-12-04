import 'dart:io';

Future<void> main() async {
  final File input = File('3/input.txt');
  final List<String> lines = await input.readAsLines();

  final int count = lines.length;
  final List<int> report = reportOccurences(lines);

  String gamma = '', epsilon = '';
  for(int pos = 0; pos < report.length; pos++) {
    bool one = report[pos] > (count / 2);

    gamma += (one ? '1' : '0');
    epsilon += (one ? '0' : '1');
  }

  final int binGamma = int.tryParse(gamma, radix: 2) ?? 0;
  final int binEpsilon = int.tryParse(epsilon, radix: 2) ?? 0;

  print("Inputs: $count");

  print("Gamma: $gamma, Decimal: $binGamma");
  print("Epsilon: $epsilon, Decimal: $binEpsilon");

  print("Result: ${binGamma * binEpsilon}");

  final String oxygen = findUniqueValue(lines, (source, position, candidate) {
    int ones = reportOnPosition(source, position);
    final String common = (ones >= (source.length / 2)) ? '1' : '0';
    return candidate[position] == common;
  });

  final String co2 = findUniqueValue(lines, (source, position, candidate) {
    int ones = reportOnPosition(source, position);
    final String common = (ones >= (source.length / 2)) ? '0' : '1';
    return candidate[position] == common;
  });

  final int binOxygen = int.tryParse(oxygen, radix: 2) ?? 0;
  final int binCo2 = int.tryParse(co2, radix: 2) ?? 0;

  print("Oxygen: $oxygen, Decimal: $binOxygen");
  print("CO2: $co2, Decimal: $binCo2");

  print("Result: ${binOxygen * binCo2}");
}

String findUniqueValue(List<String> list, bool Function(List<String>, int, String) criteria, [int position = 0]) {
  if(list.isEmpty) throw 'No candidates left!';
  if(list.length == 1) return list.single;
  if(position >= 12) throw 'All positions tested!';

  final List<String> reduced = list.where((element) => criteria(list, position, element)).toList();
  print("New candidates size: ${reduced.length}");
  return findUniqueValue(reduced, criteria, (position+1));
}

List<int> reportOccurences(List<String> source) {
  List<int> report = List.filled(12, 0);
  for (final line in source) {
    for(int pos = 0; pos < line.length; pos++) {
      int current = report[pos];
      if(line[pos] == '1') current++;
      report[pos] = current;
    }
  }
  return report;
}

int reportOnPosition(List<String> source, [ int pos = 0]) {
  int sum = 0;
  for (final line in source) {
    if(line[pos] == '1') sum++;
  }
  return sum;
}