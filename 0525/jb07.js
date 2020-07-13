function button(){

//함수에 함수 리터럴을 전달하는 익명함수

var calculator = {
  //operate 메소드의 첫번째 매개변수는 함수를 인자로 전달 받습니다.
  operate : function(method, operand1, operand2) {
    if(typeof method =='function') {
      if(typeof operand1 != 'number' || typeof operand2 != 'number')
      throw new Error('operate() : 두번째, 세번째 매개변수는 반드시 숫자를 전달해야합니다.');
      return method(operand1, operand2);
    }else
      throw new Error('operate() : 첫번째 매개변수로 함수를 전달해야 합니다.');
    }
  };

  try {
    //calculator.operate 메소드의 첫번째 매개변수로 익명함수를 전달합니다.
    var result1 = calculator.operate(function(x,y){return x +y;}, 2, 3);
    document.writeln('result1 : ' + result1 + '<br>');

    //두번째, 세번째 매개변수로 숫자가 아닌 값을 전달하면 예외를 발생시킵니다.
    var result2 = calculator.operate(function(x,y){return x+y;}, '2',3);
    document.writeln('result2: ' + result2 + '<br>');

  } catch(e) {
    document.writeln(e +'<br>');
  }
document.writeln('<br>');

//익명함수를 정의하고 바로 호출해 결과를 얻을 수도 있습니다.
var result3 = (function(x,y){return x+y;})(2,3);
document.writeln('result3: ' + result3 + '<br>');
document.writeln('<br>');
};
