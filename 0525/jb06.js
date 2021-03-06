function button(){//사칙연산 관련 메소드를 가진 calculator 객체를 정의합니다.

var calculator = {
  add : function(x,y){
    return x + y;
  },
  subtract : function(x,y){
    return x - y;
  },
  multiply : function(x,y){
    return x*y;
  },
  divide : function(x,y){
    return x/y;
  }
};

//위에 정의된 calculator 객체의 메소드를 첫번째 매개변수의 전달 값으로,
//나머지 두 개의 매개변수는 첫번째 매개변수로 전달된 calculator 객체의 메소드의
//매개변수로 사용할 operator 함수를 정의합니다.
function operate1(operator, operand1, operand2){
  return operator(operand1, operand2);
}

//첫번째 매개변수로 calculator 객체의 프로퍼티명을 전달하고, 나머지 두개의 매개변수는
//calculator 객체의 메소드의 매개변수로 사용할 operate2 함수를 정의합니다.
function operate2(operatorName, operand1, operand2){
  //프로퍼티 타입이 함수일 경우 그 메소드를 실행합니다.
  if((typeof calculator[operatorName])=='function')
    return calculator[operatorName](operand1, operand2);
    else
      throw new Error('operator2() : ' + operatorName + '은(는) 정의되어 있지 않은 연산자입니다.');
    }
  //((3-8) + (2*5))
  var result1 = operate1(calculator.add, operate1(calculator.subtract,3,8),operate1(calculator.multiply,2,5));
  document.writeln('result1: ' + result1 + '<br>');

  try {
    var result2 = operate2('add', operate2('subtract',3,8),operate2('multiply',2,5));
    document.writeln('result2: ' + result2 + '<br>');
  } catch(e) {
    document.writeln(e+'<br>');
  }
  document.writeln('<br>');
};
