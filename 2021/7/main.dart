import 'dart:io';

Future<void> main() async {
  final File input = File('7/input.txt');
  final List<String> lines = await input.readAsLines();
  //final List<String> lines = [ '3,4,3,1,2' ];
  final List<int> initial = lines[0].split(',').map((e) => int.parse(e)).toList();
  final List<int> results = [];

  int min = initial.reduce((value, element) => (value >= element) ? element : value);
  int max = initial.reduce((value, element) => (value >= element) ? value : element);
  print("Range: $min - $max");

  int lowest = 99999999999999999;
  int target = min;
  for(int i = min; i < max; i++) {
    int consumption = calculateFuel(i, initial);
    if(consumption < lowest) {
      lowest = consumption;
      target = i;
    }
    results.insert(i, consumption);
  }

  print("Results: $results");
  print("Lowest fuel: $lowest | Target: $target");
}

int calculateFuel(int target, List<int> crabs) {
  return crabs.map((e) => price((target - e).abs())).reduce((value, element) => value + element);
}

int price(int distance) {
  return ((distance / 2) * (1 + distance)).round();
}