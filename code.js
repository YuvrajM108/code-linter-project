let x = 5;
let y = 4;
console.log(add(x, y));
console.log(oddOrEven(add(x, y)));

function add(num1, num2) {
  let sum = num1 + num2;
  return sum;
}

function oddOrEven(val){
  if(val%2 == 0){
    return val + " is even.";
  }
  else{
    return val + " is odd.";
  }
}
