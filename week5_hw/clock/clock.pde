void setup() {
  size(800, 800);
}

void draw() {
  background(201, 188, 156);
  translate(width / 2, height / 2);
  
  // 시계 판
  fill(255);
  stroke(0);
  strokeWeight(10);
  ellipse(0, 0, 700, 700);
  
  // 마커, 숫자
  strokeWeight(10);
  textSize(40);
  textAlign(CENTER, CENTER);
  String[] numbers = {"Twelve", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven"};
  
  for (int i = 0; i < 12; i++) {
    float angle = map(i, 0, 12, 0, TWO_PI) - HALF_PI; // 12가 맨 위로
    float xOuter = cos(angle) * 350;
    float yOuter = sin(angle) * 350;
    float xInner = cos(angle) * 318; // 글자 위치
    float yInner = sin(angle) * 318; // 글자 위치

    // 시 마커
    fill(0);
    noStroke();
    ellipse(xOuter * 0.95, yOuter * 0.95, 6, 6);
    
    // 숫
    fill(166, 255, 166);
    text(numbers[i], xInner * 0.85, yInner * 0.85);
  }
  
  // 분 마커
  for (int i = 0; i < 60; i++) {
    if (i % 5 != 0) {
      float angle = map(i, 0, 60, 0, TWO_PI) - HALF_PI;
      float xOuter = cos(angle) * 350;
      float yOuter = sin(angle) * 350;
      
      // 분 마커 더 작게하고 안으로
      fill(150);
      noStroke();
      ellipse(xOuter * 0.95, yOuter * 0.95, 4, 4);
    }
  }
  
 // 침 핀
 
  fill(166, 255, 166);
  rectMode(CENTER);
  rect(0, 0, 80, 80);

  // 현재 시간
  int h = hour();
  int m = minute();
  int s = second();
  
  // 시계 침
  // 시
  strokeWeight(10); // Thickest for hour hand
  float hourAngle = map(h % 12, 0, 12, 0, TWO_PI) + map(m, 0, 60, 0, TWO_PI / 12) - HALF_PI; // Adjust for top position
  float hourX = cos(hourAngle) * 200;
  float hourY = sin(hourAngle) * 200;
  stroke(0);
  line(0, 0, hourX, hourY);
  
  // 분
  strokeWeight(6); // Medium thickness for minute hand
  float minuteAngle = map(m, 0, 60, 0, TWO_PI) - HALF_PI; // Adjust for top position
  float minuteX = cos(minuteAngle) * 270;
  float minuteY = sin(minuteAngle) * 270;
  stroke(150); // Gray for the minute hand
  line(0, 0, minuteX, minuteY);
  
  // 초
  strokeWeight(2); // Thinnest for second hand
  float secondAngle = map(s, 0, 60, 0, TWO_PI) - HALF_PI; // Adjust for top position
  float secondX = cos(secondAngle) * 300;
  float secondY = sin(secondAngle) * 300;
  stroke(255, 0, 0); // Red for the second hand
  line(0, 0, secondX, secondY);
}
