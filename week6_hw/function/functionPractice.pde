void drawHouse(float x, float y, float w, float h) {
  stroke(0);  // 외곽선
  strokeWeight(2);

  // 본체
  fill(random(150, 255), random(150, 255), random(150, 255));  // 랜덤 컬러
  rect(x, y, w, h);

  // 지붕
  fill(random(150, 255), random(50, 150), random(50, 150));
  triangle(x, y, x + w / 2, y - h / 2, x + w, y);

  // 문
  fill(100, 70, 0);
  float doorWidth = max(w / 5, 20);  // 문 최소 너비
  float doorHeight = h / 3;
  rect(x + w / 2 - doorWidth / 2, y + h - doorHeight, doorWidth, doorHeight);

  // 손잡이
  fill(0);
  ellipse(x + w / 2 + doorWidth / 5, y + h - doorHeight / 2, 8, 8);

  // 창문
  fill(255, 255, 0);
  float windowSize = w / 5;
  float leftWindowX = x + w / 4 - windowSize / 2;
  float rightWindowX = x + 3 * w / 4 - windowSize / 2;
  float windowY = y + h / 4;

  rect(leftWindowX, windowY, windowSize, windowSize);
  rect(rightWindowX, windowY, windowSize, windowSize);

  // 창틀
  stroke(0);
  line(leftWindowX, windowY + windowSize / 2, leftWindowX + windowSize, windowY + windowSize / 2);
  line(leftWindowX + windowSize / 2, windowY, leftWindowX + windowSize / 2, windowY + windowSize);

  line(rightWindowX, windowY + windowSize / 2, rightWindowX + windowSize, windowY + windowSize / 2);
  line(rightWindowX + windowSize / 2, windowY, rightWindowX + windowSize / 2, windowY + windowSize);

  noFill();  // 투명 창틀
}

// 배경
void drawBackground() {
  // 하늘
  fill(135, 206, 235);
  noStroke();
  rect(0, 0, width, height * 2 / 3);

  // 땅
  fill(60, 179, 113);
  rect(0, height * 2 / 3, width, height / 3);
}

// 겹치지 않는 집 배치
boolean isOverlap(float x1, float w1, float x2, float w2) {
  return (x1 < x2 + w2 && x1 + w1 > x2);  // 두 집의 X 좌표와 너비를 비교하여 겹치는지 확인
}

// 클릭할 때마다 랜덤으로 집 5개 그리기
void mousePressed() {
  drawBackground();  // 때마다 배경도 그리기

  // 이전 집들의 X와 너비를 저장하기 위한 배열
  float[] housePositionsX = new float[5];
  float[] houseWidths = new float[5];

  for (int i = 0; i < 5; i++) {
    float houseWidth = random(50, 200);
    float houseHeight = random(100, 300);
    float posX;
    boolean overlap;

    // 집들이 겹치지 않도록 X 좌표를 찾기
    int attempts = 0;
    do {
      posX = random(0, width - houseWidth);  // 화면에서 랜덤 X 위치
      overlap = false;
      for (int j = 0; j < i; j++) {
        if (isOverlap(posX, houseWidth, housePositionsX[j], houseWidths[j])) {
          overlap = true;
          break;
        }
      }
      attempts++;
      // 무한 루프 방지 -> 시도 횟수 제한
      if (attempts > 100) {
        break;
      }
    } while (overlap);  // 다른 집과 겹치지 않는 위치가 나올 때까지 반복

    // 집 위치와 너비 저장
    housePositionsX[i] = posX;
    houseWidths[i] = houseWidth;

    // 집을 땅 위에 겹치게 배치
    float groundLevel = height * 2 / 3;
    float posY = groundLevel - houseHeight + 50;

    drawHouse(posX, posY, houseWidth, houseHeight);
  }
}

void setup() {
  size(800, 800);
  drawBackground();
}

void draw() {
}