function button(){// consturctor 프로퍼티

function Rectangle(x, y, w, h) {
this.pointX = x;
this.pointY = y;
this.width = w;
this.height = h;
}

Rectangle.prototype.toString = function() {
return 'Rectangle : { pointX : ' + this.pointX + ', pointY : ' + this.pointY
       + ', width : ' + this.width + ', height : ' + this.height + ' }';
};

Rectangle.prototype.area = function() {
return this.width * this.height;
};

var rect1 = new Rectangle(100, 120, 20, 30);

if (rect1.constructor == Rectangle)
document.writeln('rect1 객체의 생성자 함수는 Rectangle입니다.<br/>');

if (rect1.constructor.prototype == Rectangle.prototype)
document.writeln('rect1 객체의 생성자 함수의 프로토타입 객체는 Rectangle 생성자함수의 프로토타입 객체와 동일합니다.<br/>');

var rect2 = new rect1.constructor(250, 300, 30, 50);
document.writeln('rect2: ' + rect2 + '<br/>');
document.writeln('<br/>');
};
