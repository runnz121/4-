function button(){

//함수의 생략 가능한 매개변수

function sum(array, start, end){
  //매개변수 array 에 전달된 값이 없을 경우 빈 배열을 할당합니다.
  //if 문을 대신해 다음의 || 연산자를 이용한 조건문을 작성할 수 도 있습니다.
  //array = array || [];
  if (!array)
    array = [];
  //매개변수 start에 전달된 값이 없을 경우 0을 할당합니다.
  if(!start) start = 0;
  //매개변수 end에 전달된 값이 없을 경우 배열의 원소의 갯수를 할당합니다.
  if(!end) end = array.length;

  //매개변수 array 에 전달된 값이 배열 객체일 경우에만 합계를 계산합니다.
  if(array instanceof Array){
    //매개변수 start와 end 에 전달된 값이 숫자일 경우에만 합계를 계산합니다.
    if((typeof start) !='number' || (typeof end) !='number')
      throw new Error('sum():두번째 매개변수와 세번째 매개변수의 전달 인자는 숫자여야 합니다.');

    var result = 0;
    for(var i= start; i < end; i++){
      //배열 array의 원소가 숫자 타입일 경우에만 합계를 계산합니다.
      if((typeof array[i]) != 'number')
      throw new Error('sum(): array[' + i + ']에 저장된 값' + array[i] +
    '는 숫자 타입이 아닙니다.');
    result +=array[i];
    }
    return result;
  } else{//매개변수 array에 전달된 값이 배열 객체가 아닐 경우 예외를 발생시킵니다.
  throw new Error('sum(): 첫번째 매개변수의 전달 인자는 배열이여야 합니다.');
  }
}

var arr1 = [1,2,3,4,5];
var obj = {name : '홍길동', phone : '010-1234-5678'};
var arr2 = [1,2,'3rd',4,5];

try {
  document.writeln('sum(arr1, 0, arr1.length):' + sum(arr1,0,arr1.length)+'<br>');

  document.writeln('sum(arr1, 0, 4): ' + sum(arr1,0,4) + '<br>');
  document.writeln('sum(arr1, 0): ' + sum(arr1,0) + '<br>');
  document.writeln('sum(arr1, 2): ' + sum(arr1,2) + '<br>');
  document.writeln('sum(arr1): ' + sum(arr1) + '<br>');
  document.writeln('sum(): ' + sum() + '<br>');
  document.writeln('sum(obj): ' + sum(obj) + '<br>');

} catch (e) {
  document.writeln(e + '<br>');
}

try{
  document.writeln('sum(arr1, \'X\', 4) : ' + sum(arr1,'x',4) + '<br>');
} catch (e) {
  document.writeln(e + '<br>');
}

try{
  document.writeln('sum(arr2):' + sum(arr2) + '<br>');
} catch(e) {
  document.writeln(e + '<br>');
}
  document.writeln('<br>');

};
