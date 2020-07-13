//함수의 정의와 호출


//function 문에 의해 정의된 print 함수는 매개변수 message에 전달도니 값을 출력한다.






var t = document.getElementById("kk");
t.addEventListener("click", button);




function button() {

        function print(message) {
          document.writeln(message);
        }

        //function 문에 의해 정의된 println 함수는 매개변수 message에 전달된 값과 문자열 '<br>' 을 접합연산한 결과를 출력
        function println(message) {
          document.writeln(message + '<br>');
        }


        //function 문에 의해 정의된 distance 함수는 x, y 프로퍼티를 가진 객체를 매개변수로 하여 내장 객체 Math가 제공하는 sqrt 함수를 호출해 두 점간의 거리를 반환
        function distance(p1,p2) {
          var dX = p2.x - p1.x;
          var dY = p2.y - p1.y;
          return Math.sqrt(dX*dX,dY*dY);
        }


        var pointA = { x: 25, y : 40};
        var pointB = { x :50, y : 80};

       tag1;
        print('pointA와 pointB 사이의 거리 : ');
        println(distance(pointA, pointB));


        //함수리터럴에 의해 정의된 area 함수는 x, y 프로퍼티를 가진 객체를 매개변수로 하여 두 점을 이용해 구성된 사각형의 면적을 반환
        var square = function(leftTop, rightButtom){
          var width = rightButtom.x - leftTop.x;
          var height = rightButtom.y - leftTop.y;
          return width * height;
        };

         tag2;
        print('pointA와 pointB로 구성한 사각형의 넓이:');
        println(square(pointA, pointB));


        //Function 생성자에 의해 정의된 triangle 함수는 base 와 height 매개변수에 전달된 값을 이용해 삼각형의 면적을 반환
        var triangle = new Function('base', 'height', 'return(base*height) / 2;');
        tag3;
        print('base와 height로 구성한 삼각형의 넓이 :');
        println(triangle(30,20));


};
