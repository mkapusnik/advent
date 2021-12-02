import 'dart:io';

Future<void> main() async {
  final File input = File('input.txt');
  final List<String> lines = await input.readAsLines();

  int increases = 0;
  int? measurementA, measurementB, measurementC;
  for (final line in lines) {
    int current = int.tryParse(line) ?? 0;
    if(measurementA == null) {
      measurementA = current;
      continue;
    }
    if(measurementB == null) {
      measurementB = current;
      continue;
    }
    if(measurementC == null) {
      measurementC = current;
      continue;
    }
    int prevSum = measurementA + measurementB + measurementC;
    int currentSum = measurementB + measurementC + current;

    if(prevSum < currentSum) {
      increases++;
    }
    measurementA = measurementB;
    measurementB = measurementC;
    measurementC = current;
  }
  print("Num of increases: $increases");
}