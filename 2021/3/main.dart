import 'dart:io';

Future<void> main() async {
  final File input = File('3/input.txt');
  final List<String> lines = await input.readAsLines();

  int count = 0;
  List<int> report = List.filled(12, 0);
  for (final line in lines) {
    for(int pos = 0; pos < line.length; pos++) {
      int current = report[pos];
      if(line[pos] == '1') current++;
      report[pos] = current;
    }
    count++;
  }

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
}