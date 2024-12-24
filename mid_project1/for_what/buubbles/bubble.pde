ArrayList<InteractiveShape> shapes; 
int shapeSize;  // 도형의 기본 크기

void setup() {
  fullScreen();  // 전체화면으로 설정기하기
  shapes = new ArrayList<InteractiveShape>();  // ArrayList 초기화하기
  frameRate(30);  // 애니메이션 프레임 30으로 설정하기
}

void draw() {
  background(0); 

  // 모든 도형을 업데이트되도록 새로 그리기
  //ai 도윰: 3초가 지나면 array들이 사라지는 효과를 구현하는 코드를 보여줘
  for (int i = shapes.size() - 1; i >= 0; i--) {
    InteractiveShape shape = shapes.get(i);
    shape.update();  // 위치, 속도 업데이트하기
    shape.display();  // 도형을 화면에 그리기
    // 3초가 지나면 도형 삭제하기
    if (shape.isExpired()) {
      shapes.remove(i);
    }
  }

  // ArrayList의 현재 크기가 화면 좌측 상단에 상시 표기되도록 하기
  fill(255);
  textSize(20);
  text("ArrayList Size: " + shapes.size(), 20, 30);
}

void mousePressed() {
  // 마우스를 클릭하면 새로운 복잡한 다각형 도형을 생성하게 한다
  InteractiveShape newShape = new InteractiveShape(mouseX, mouseY, shapeSize);
  shapes.add(newShape);
}

void mouseDragged() {
  // 마우스를 드래그하면 도형들이 따라가며 변화하게 한다
  InteractiveShape newShape = new InteractiveShape(mouseX, mouseY, shapeSize);
  shapes.add(newShape);
}

//ai도움: class에 도형의 위치, 크기, 색상, 회전속도, 회전 각도, 속도 외에 
//       어떤 클래스가 들어가야 의도한 바대로 움직이는지 도와줘 안 움직여..
class InteractiveShape {
  float x, y;  // 위치
  float size;  // 크기
  color fillColor;  // 색상
  float rotationSpeed;  // 회전 속도
  float angle;  // 현재 회전 각도
  float velocityX, velocityY;  // 속도
  int creationTime;  // 생성된 시간 (밀리초 단위입니다)

  InteractiveShape(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = random(10, 80);
    this.fillColor = color(random(255), random(255), random(255), random(100, 200));  // 색상
    this.rotationSpeed = random(-0.05, 0.05);  // 회전 속도
    //ai 도움: 회전 각도를 랜덤하게 할 건데 어떤 코드가 적용되어야해?
    this.angle = random(TWO_PI);  // 회전 각도
    this.velocityX = random(-2, 8);  // X축 속도
    this.velocityY = random(-2, 8);  // Y축 속도
    this.creationTime = millis();  // 생성 시간 (현재 밀리초)
  }

  void update() {
    // 도형의 위치를 계속해서 업데이트해주기 (속도에 따라 이동)
    x += velocityX;
    y += velocityY;



    // ai 도움: 도형이 회전하면서 화면 밖으로 나가지 않도록 반사시키기 위한 if구문을 코드로 작성해줘
    if (x < 0 || x > width) {
      velocityX *= -1;
    }
    if (y < 0 || y > height) {
      velocityY *= -1;
    }

    angle += rotationSpeed;  // 회전하는 애니메이션 효과
  }

  void display() {
    pushMatrix();
    translate(x, y);  // 도형의 위치로 이동
    rotate(angle);  // 회전 적용

    fill(fillColor);
    stroke(255);
    strokeWeight(2);
    
    // ai 도움: 변의 개수가 10에서 20각형으로 랜덤화하는 다각형 그리는 코드를 알려줘
    int sides = int(random(10, 20));  // 10에서 20각형으로 랜덤범위 설정하
    float angleStep = TWO_PI / sides;  // 각 변의 각도

    beginShape();
    for (int i = 0; i < sides; i++) {
      float xOffset = cos(angleStep * i) * size;
      float yOffset = sin(angleStep * i) * size;
      vertex(xOffset, yOffset);
    }
    endShape(CLOSE);

    popMatrix();
  }

  //ai도움: 3초가 지나면 도형을 화면에서 사라지게 해주는 코드를 작성해줘
  boolean isExpired() {
    // 3초가 지나면 도형은 삭제된다!
    return millis() - creationTime > 3000;
  }
}