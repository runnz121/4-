function button(){//중첩함수

function circle(radius){
  var pi = 3.14;

  //중첩함수 내부 변수에 접근가능합니다.
  function area(r){
    return r*r*pi;
  }

  //중첩함수는 내부에서만 호출 가능합니다.
  return area(radius);
}

document.writeln('circle(5):' + circle(5) + '<br>');
document.writeln('<br>');
};
