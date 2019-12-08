var fs = require("fs");

var content = fs.readFileSync("input.txt", "utf8").split(",").map(function(i) { return BigInt(i);});
console.log("Original content: ", content.join());

function attempt(noun, verb, data) {
  var position = 0;
  data[1] = noun;
  data[2] = verb;

  function getValue(position) {
    return data[data[position]];
  }

  while(position < data.length) {
    var opcode = data[position];
    if(opcode == 1) {
      data[data[position+3]] = BigInt(getValue(position+1)) + BigInt(getValue(position+2));
    } else if(opcode == 2) {
      data[data[position+3]] = BigInt(getValue(position+1)) * BigInt(getValue(position+2));
    } else if(opcode == 99) {
      break;
    } else {
      console.log("ERR: ", position, " Value: ", opcode);
    }

    position += 4;
  }

  return data[0];
}

for(var noun = 0; noun <= 99; noun++) {
  for(var verb = 0; verb <= 99; verb++) {
    var result = attempt(noun, verb, content.slice());
    if(result == 19690720) {
      console.log("Noun: ", noun, " Verb: ", verb, " Result: ", result);
    }
  }
}
