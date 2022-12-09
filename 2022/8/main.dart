import 'dart:core';
import 'dart:io';

List<List<int>> grid = [];

Future<void> main() async {
  final File input = File('8/input.txt');
  final List<String> lines = await input.readAsLines();

  for(String line in lines) {
    grid.add(line.split('').map((e) => int.parse(e)).toList());
  }

  int visibleTrees = 0;
  for(int y = 0; y < grid.length; y++) {
    for(int x = 0; x < grid[y].length; x++) {
      if(isVisible(x, y)) visibleTrees++;
    }
  }
  print("Visible trees: $visibleTrees");
}

bool isVisible(int x, int y) {
  final int value = grid[y][x];
  bool left = true, right = true, top = true, bottom = true;
  for(int i = x-1; i >= 0; i--) {
    if(grid[y][i] >= value) {
      left = false;
      break;
    }
  }
  for(int i = x+1; i < grid[y].length; i++) {
    if(grid[y][i] >= value) {
      right = false;
      break;
    }
  }
  for(int i = y-1; i >= 0; i--) {
    if(grid[i][x] >= value) {
      top = false;
      break;
    }
  }
  for(int i = y+1; i < grid.length; i++) {
    if(grid[i][x] >= value) {
      bottom = false;
      break;
    }
  }
  return left || right || top || bottom;
}