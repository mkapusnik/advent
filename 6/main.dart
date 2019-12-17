import 'dart:io';

void main() {
  List<String> contents = new File('input.txt').readAsLinesSync();
  print(contents);
}