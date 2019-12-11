var lineReader = require('readline').createInterface({
  input: require('fs').createReadStream('input.txt')
});

var totalFuel = 0;
lineReader.on('line', function (mass) {

  var addFuel = Math.floor(mass / 3) - 2;

  while (addFuel > 0) {
    console.log('Add Fuel: ', addFuel);
    totalFuel += addFuel;
    mass = addFuel;
    addFuel = Math.floor(mass / 3) - 2;    
  }     
}).on('close', function() {
  console.log('Total Fuel: ', totalFuel);
});

 