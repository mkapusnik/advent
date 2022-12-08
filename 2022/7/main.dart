import 'dart:core';
import 'dart:io';

final List<PathNode> structure = [];
final PathNode root = PathNode('/');

Future<void> main() async {
  final File input = File('7/input.txt');
  final List<String> lines = await input.readAsLines();

  PathNode current = root;
  structure.add(root);

  for(String command in lines) {
    if(command.startsWith('\$ ls')) continue;
    if(command.startsWith('\$ cd /')) {
      current = root;
      continue;
    };
    if(command.startsWith('\$ cd')) {
      if(command.startsWith('\$ cd ..')) {
        current = current.parent!;
      } else {
        final List<String> metadata = command.split(' ');
        final String newPath = current.fullPath() + '/' + metadata[2];
        final PathNode change = structure.firstWhere((node) => node.fullPath() == newPath);
        current = change;
      }
    } else {
      final List<String> metadata = command.split(' ');
      if(command.startsWith('dir')) {
        structure.add(PathNode(metadata[1], current));
      } else {
        current.size += int.parse(metadata[0]);
      }
    }
  }

  root.printStructure();

  int sizeSummary = structure
      .where((node) => node.totalSize() <= 100000)
      .map((e) => e.totalSize())
      .reduce((value, element) => value + element);
  print("Size summary: $sizeSummary");
}

List<PathNode> findChildren(String path) {
  return structure.where((node) => node.parent?.fullPath() == path).toList();
}

class PathNode {
  final PathNode? parent;
  final String name;
  int size = 0;

  PathNode(this.name, [ this.parent ]);

  String fullPath() {
    String path = (parent != null) ? parent!.fullPath() + '/' : '';
    return path + name;
  }

  int totalSize() {
    return findChildren(fullPath())
        .map((e) => e.totalSize())
        .fold(size, (value, element) => value + element);
  }

  void printStructure() {
    print('${fullPath()} - ${totalSize()}');
    findChildren(fullPath()).forEach((child) => child.printStructure());
  }
}