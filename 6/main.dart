import 'dart:io';

Map _loadData() {
  List<String> lines = new File('input.txt').readAsLinesSync();
  Map<String, List<String>> orbits = Map();
  lines.forEach((line) {
    var parsed = line.split(")");
    orbits.update(parsed[0], (val) { val.add(parsed[1]); return val; }, ifAbsent: () => [ parsed[1] ]);
    orbits.putIfAbsent(parsed[1], () => []);
  });
  return orbits;
}

int countOrbits(String key, Map orbits) {
  if(key == "COM")
    return 0;
  else {
    MapEntry center = orbits.entries.firstWhere((entry) => entry.value.contains(key));
    return (1 + countOrbits(center.key, orbits));
  }    
}

int countTotalOrbits(Map orbits) {
  int totalOrbits = 0;
  orbits.forEach((key, value) {
    totalOrbits += countOrbits(key, orbits);
  });
  return totalOrbits;
}

int countUsableOrbits(String key, Map orbits) {
  if(key == "SAN")
    return 0;
  else {
    MapEntry center = orbits.entries.firstWhere((entry) => entry.value.contains(key));
    return (1 + countOrbits(center.key, orbits));
  }    
}

int countTransferOrbits(Map orbits) {  
  // "SAN"
  // "YOU"
  
  return 0;
}

void main() {
  var orbits = _loadData();  
  //print("Total orbits: ${countTotalOrbits(orbits)}");
  //print("Transfer orbits: ${countTransferOrbits(orbits)}");
}