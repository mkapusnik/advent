var fs = require("fs");

var content = fs.readFileSync('input.txt', 'utf8');
var lines = content.split(/\r?\n/);

function getPositions(positions, line, lineId) {
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
            var index = "X" + x + "Y" + y;
            var existing = positions[index] || { lines: [], x: x, y: y };
            if(!existing.lines.includes(lineId)) {
                existing.lines.push(lineId);
                positions[index] = existing;        
            }
        }
    });
}

var positions = [];
lines.forEach(function(line, index) {
    getPositions(positions, line, index);
});

var distance;
for (var key in positions) {
    var details = positions[key];
    if(details.lines.length > 1) {
        var currentDistance = Math.abs(details.x) + Math.abs(details.y);        
        if(!distance || currentDistance < distance) {
            distance = currentDistance;
        }
        console.log("Current: ", currentDistance);
    }
}
console.log("Distance: ", distance);