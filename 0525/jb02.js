function button(){

//전역 스코프와 지역스코프

//전역스코프를 가진 전역변수
var x = 'global x';
var y = 'global y';

function func() {
  //지역 스코프를 가진 지역 변수는 반드시 var 키워드와 함께 선언되어야 합니다.
  var x = 'local X';

  //var 키워드 없을 경우 전역스코프에 접근해 동일 이름을 가진 전역변수를 사용하며,
  //만일 동일 이르미의 전역 변수가 없을 경우 전역변수를 새로 등록합니다.
  y='?????';

  document.writeln('x: ' + x + '<br>');
  document.writeln('y: ' + y + '<br>');
  document.writeln('<br>');
}

  document.writeln('func() 호출 전'+'<br>');
  document.writeln('x: ' + x + '<br>');
  document.writeln('y: ' + y + '<br>');
  document.writeln('<br>');

  document.writeln('func() 호출' + '<br>')
  func();

  document.writeln('func() 호출 후' + '<br>');
  document.writeln('x: ' + x + '<br>');  // x 대신 func함수에 매개변수 추가하여 출력하게함
  document.writeln('y: ' + y + '<br>');
  document.writeln('<br>');
}
