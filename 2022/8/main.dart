import 'dart:core';
import 'dart:io';

List<List<int>> grid = [];

Future<void> main() async {
  final File input = File('8/input.txt');
  final List<String> lines = await input.readAsLines();

  for(String line in lines) {
    grid.add(line.split('').map((e) => int.parse(e)).toList());
  }

  int score = 0;
  for(int y = 0; y < grid.length; y++) {
    for(int x = 0; x < grid[y].length; x++) {
      int candidate = calculateScore(x, y);
      if(candidate > score) score = candidate;
    }
  }
  print("Max scenic score: $score");
}

int calculateScore(int x, int y) {
  final int value = grid[y][x];
  int scoreLeft = x,
      scoreRight = grid[y].length - x - 1,
      scoreTop = y,
      scoreBottom = grid.length - y - 1;
  for(int i = x-1; i >= 0; i--) {
    if(grid[y][i] >= value) {
      scoreLeft = (x-i);
      break;
    }
  }
  for(int i = x+1; i < grid[y].length; i++) {
    if(grid[y][i] >= value) {
      scoreRight = (i-x);
      break;
    }
  }
  for(int i = y-1; i >= 0; i--) {
    if(grid[i][x] >= value) {
      scoreTop = (y-i);
      break;
    }
  }
  for(int i = y+1; i < grid.length; i++) {
    if(grid[i][x] >= value) {
      scoreBottom = (i-y);
      break;
    }
  }
  int total = scoreLeft * scoreRight * scoreTop * scoreBottom;
  //print("[$x,$y]: $value | $scoreTop * $scoreLeft * $scoreRight * $scoreBottom = $total");
  return total;
}