function button(){

//함수의 매개변수와 스코프

//값을 매개변수로 전달하는 경우 함수 내에서의 매개변수 조작은 원본 값에 아무런 영향을 미치지 않습니다.
function swapByValue (x,y) {
  var temp = x;
  x = y;
  y = temp;
}

//참조값을 매개변수로 전달하는 경우 매개변수가 원본 객체를 참조하므로
//함수 내에서 매개변수를 통해 객체 조작은 원본 객체에 영향을 미칩니다.
function swapByReference(o) {
  var temp = o.x;
  o.x = o.y;
  o.y = temp;
}

var a = 5;
var b = 8;
var obj = {x : 5, y : 8};

document.writeln('swap 함수 호출 전' + '<br>');
document.writeln('a: ' + a + ', b: ' + b + '<br>');
document.writeln('obj.x: ' + obj.x + ', obj.y: ' + obj.y + '<br>');
document.writeln('<br>');

swapByValue(a,b);
swapByReference(obj);

document.writeln('swap 함수 호출 후' + '<br>');
document.writeln('a: ' + a + ', b: ' + b + '<br>');
document.writeln('obj.x: ' + obj.x + ', obj.y: ' + obj.y + '<br>');
document.writeln('<br>');
}
