var inputMin = 108457;
var inputMax = 562041;

var solutions = [];

function check(current) {
    var hasDuplicit = false;
    for(var pos = 0; pos < current.length; pos ++) {
        var currentChar = current[pos];
        if(current.includes(currentChar + currentChar) && !current.includes(currentChar + currentChar + currentChar)) {
            hasDuplicit = true;
        }

        if(current[pos-1] > current[pos])
            return false;
    }
    return hasDuplicit; 
}

for(var i = inputMin; i <= inputMax; i++) {
    if(check(i.toString(10)))
      solutions.push(i);
}

console.log("Solutions: ", solutions.join());
console.log("Count: ", solutions.length);