function button() {// 프로토타입 객체와 prototype 프로퍼티

  function Rectangle(x, y, w, h) {    //  Rectangle 생성자 함수 & 4개의 프로퍼티
    this.pointX = x;
    this.pointY = y;
    this.width = w;
    this.height = h;
  }

  // 모든 함수가 가지고 있는 prototype 프로퍼티는 프로토타입 객체에 대한 연결을 가집니다.
  // Rectangle 생성자 함수의 prototype 프로퍼티가 참조하는 객체에 toString 이란
  // 이름의 프로퍼티를 추가하는데 그 값으로 함수 리터럴을 대입하여 메소드를 추가합니다.
  // 이 메소드는  Rectangle 생성자 함수를 통해 생성되는 객체에 상속될 것입니다.
  Rectangle.prototype.toString = function() {    // Rectangle 생성자를 통해 만든 모든 객체들은 앞으로 toString 메소드에 접근 가능
    return 'Rectangle : { pointX : ' + this.pointX + ', pointY : ' + this.pointY
           + ', width : ' + this.width + ', height : ' + this.height + ' }';
  };

  // 위의 toString() 메소드와 마찬가지로 Rectangle 생성자 함수의 prototype 프로퍼티가
  // 참조하는 객체에 area() 메소드를 추가하여, Rectangle 생성자 함수를 통해 생성되는
  // 객체에 상속될 것입니다.
  Rectangle.prototype.area = function() {
    return this.width * this.height;
  };

  var rect1 = new Rectangle(100, 120, 20, 30);
  var rect2 = new Rectangle(250, 300, 30, 50);

  document.writeln('rect1: ' + rect1 + '<br/>');
  document.writeln('rect1.area(): ' + rect1.area() + '<br/>');

  document.writeln('rect2: ' + rect2 + '<br/>');
  document.writeln('rect2.area(): ' + rect2.area() + '<br/>');

  document.writeln('<br/>');
};
