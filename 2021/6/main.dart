import 'dart:io';

class Fish {
  int timer;
  Fish([this.timer = 8]);

  @override
  String toString() {
    return '$timer';
  }

  bool tick() {
    timer--;
    if(timer < 0) {
      timer = 6;
      return true;
    }
    return false;
  }
}

class Pool {
  final List<Fish> _content = [];

  Pool(List<Fish> initial) {
    _content.addAll(initial);
  }

  void add(Fish fish) => _content.add(fish);

  void tick() {
    int newborns = 0;
    _content.forEach((fish) {
      if(fish.tick()) newborns++;
    });
    for(int i = 0; i < newborns; i++) {
      _content.add(Fish());
    }
  }

  @override
  String toString() {
    return _content.map((e) => e.timer).join(',');
  }

  int get size => _content.length;
}

Future<void> main() async {
  final File input = File('6/input.txt');
  final List<String> lines = await input.readAsLines();
  //final List<String> lines = [ '3,4,3,1,2' ];
  final List<Fish> initial = lines[0].split(',').map((e) => Fish(int.parse(e))).toList();
  final Pool pool = Pool(initial);

  for(int i = 0; i < 80; i++) {
    pool.tick();
    //print(pool);
  }

  print("Pool size: ${pool.size}");
}