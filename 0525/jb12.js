function button() {

// 생성자 함수: 객체를 정의하는 방법

// 이 함수는 Rectangle 생성자 함수로 설계되었습니다.
function Rectangle(x, y, w, h) {
  // this 키워드는 생성자 함수에 의해 생성되는 객체를 나타냅니다.
  // 따라서 다음의 구문은 pointX, pointY, width, height 프로퍼티를 생성자 함수에 의해
  // 생성되는 객체에 추가하고  매개변수 x, y, w, h로 전달된 값을 pointX, pointY, width, height
  // 프로퍼티에 대입하는 문장이 됩니다.
  this.pointX = x;
  this.pointY = y;
  this.width = w;
  this.height = h;
  this.toString = function() {
    return 'Rectangle : { pointX : ' + this.pointX + ', pointY : ' + this.pointY
           + ', width : ' + this.width + ', height : ' + this.height + ' }';
  };

  // 생성자 함수는 return 문을 만들지 않습니다.
}

// new 연산자는  아무런 프로퍼티도 정의되어 있지 않은 비어있는 객체를 생성합니다.
// 객체 생성 이후 new 연산자는 지정된 생성자 함수를 호출하여 명시된 인자들을 전달하고
// 방금 생성돤 새로운 객체에 대한 참조를 생성자 함수 내의 this 키워드를 통해 전달합니다.
// 생성자 함수는 이 this 키워드와 전달된 인자 값들을 사용하여 새로운 객체를 초기화합니다.
var rect1 = new Rectangle(100, 120, 20, 30);
var rect2 = new Rectangle(250, 300, 30, 50);

document.writeln(rect1 + '<br/>');
document.writeln(rect2 + '<br/>');
document.writeln('<br/>');
};
