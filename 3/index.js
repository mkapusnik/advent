const lineReader = require('line-reader');

var positions = [];

function visitPosition(x, y, line) {
    var index = "X" + x + "Y" + y;
    var existing = positions[index] || [];
    if(!existing.includes(line)) {
        existing.push(line);
        positions[index] = existing;        
    } else {
        console.log("Visitor: ", index, ": ", positions[index]);
    }
}
var lineId = 0;

function execute(line) {
    lineId++;
    var instructions = line.split(",");
    var x = 0;
    var y = 0;
    instructions.forEach(function(instruction) {
        var steps = Number(instruction.substring(1));
        var direction = instruction[0];
        for(var i = 0; i < steps; i++) {
            switch(direction) {
                case "U":
                    y++                
                    break;
                case "D":
                    y--;
                    break;        
                case "L":
                    x--;
                    break;
                case "R":
                    x++;
                    break;
            }
            visitPosition(x, y, lineId);
        }
    });
};

lineReader.eachLine('input.txt', function(line, last) {
    execute(line);

    if(last) {
        var crossings = positions.filter(function (visitors) {
            return visitors.length > 1;
        });

        console.log("Positions: ");
        positions.forEach(function(value, index) {
            console.log(index);
        });
        console.log("Crossing positions: ");
        crossings.forEach(function(value, index) {
            console.log(index);
        });
    }
});