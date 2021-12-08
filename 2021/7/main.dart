import 'dart:io';

Future<void> main() async {
  final File input = File('6/input.txt');
  final List<String> lines = await input.readAsLines();
  //final List<String> lines = [ '3,4,3,1,2' ];
  final List<int> initial = lines[0].split(',').map((e) => int.parse(e)).toList();

  final List<int> timers = List<int>.generate(9, (_) => 0);

  initial.forEach((timer) {
    timers[timer] += 1;
  });

  for(int i = 0; i < 256; i++) {
    print("Tick: $i");
    int newborns = timers[0];
    for(int t = 1; t < timers.length; t++) {
      timers[t-1] = timers[t];
    }
    timers[6] += newborns;
    timers[8] = newborns;
  }

  print("Total size: ${timers.reduce((value, element) => value+element)}");
  print("Results: $timers");
}