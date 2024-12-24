// 양초의 기본 속성
float candleHeight;
float candleWidth;
float flameSize;
boolean isBurning = true;
float meltSpeed;
float flameDecay;
float wickHeight;
float wickShrinkSpeed;
float flickerNoiseOffset = 0;
float glowOpacity = 100;
float glowSize = 100;

// 녹아내린 양초 방울을 저장할 리스트
ArrayList<Drip> drips = new ArrayList<Drip>();

void setup() {
  size(1080, 720);
  background(0);
  noStroke();
  colorMode(HSB);
  resetCandle(); // 시작할 때 랜덤 양초 설정
}

void draw() {
  background(14, 16, 31);  // 검정 배경

  // 녹아내린 양초 방울들 그리기
  for (Drip drip : drips) {
    drip.update();
    drip.display();
  }

  // 양초 몸체 그리기
  fill(255);  // 양초 색상
  rect(width / 2 - candleWidth / 2, height - candleHeight - 50, candleWidth, candleHeight);  // 양초 위치 및 크기

  // 심지 그리기
  fill(0);  // 검은색 심지
  rect(width / 2 - 2, height - candleHeight - wickHeight - 50, 4, wickHeight);  // 심지 위치 및 크기

  // 불꽃이 타고 있을 때 후광 및 불꽃 그리기
  if (isBurning) {
    flickerNoiseOffset += 0.1; // 노이즈 오프셋 증가
    float flicker = map(noise(flickerNoiseOffset), 0, 1, -10, 10); // 노이즈 기반 불꽃 크기 변화
    drawGlow(width / 2, height - candleHeight - wickHeight - 60, glowSize + flicker);  // 후광 그리기
    drawFlame(width / 2, height - candleHeight - wickHeight - 60, flameSize + flicker); // 불꽃 그리기
    candleHeight -= meltSpeed;  // 양초가 녹음
    flameSize -= flameDecay;    // 불꽃 크기가 줄어듦
    wickHeight -= wickShrinkSpeed;  // 심지도 함께 줄어듦

    // 일정 시간마다 녹은 양초 방울 추가
    if (frameCount % 60 == 0) {
      drips.add(new Drip(width / 2, height - 50, random(5, candleWidth)));  // 녹아내린 양초 방울
    }

    // 양초가 완전히 녹거나 불꽃이 사라지면 다시 새 양초로 리셋
    if (candleHeight <= 50 || flameSize <= 10 || wickHeight <= 5) {
      resetCandle();
      drips.clear();  // 새 양초가 생길 때 녹은 방울들을 초기화
    }
  }
}

void drawFlame(float x, float y, float size) {
  // 바깥쪽 불꽃 (노란색)
  fill(30, 255, 255);
  ellipse(x, y, size, size * 1.5);

  // 안쪽 불꽃 (주황색)
  fill(10, 255, 255);
  ellipse(x, y + 10, size * 0.6, size * 1.2);
}

void drawGlow(float x, float y, float size) {
  // 후광 그리기
  for (int i = 0; i < 10; i++) {
    float glowFlicker = map(noise(flickerNoiseOffset + i), 0, 1, -5, 5);
    fill(30, 255, 255, glowOpacity - i * 15);  // 점점 투명해지는 후광
    ellipse(x, y, size + i * 60 + glowFlicker, size * 1.5 + i * 50 + glowFlicker);
  }
}

// 녹아내린 양초 방울 클래스
class Drip {
  float x, y, size, speed;

  Drip(float startX, float startY, float dripSize) {
    x = startX + random(-candleWidth / 2, candleWidth / 2);
    y = startY;
    size = dripSize;
    speed = random(1, 3);
  }

  void update() {
    y += speed;  // 방울이 아래로 흘러내림
    if (y > height - 50) {
      speed = 0;  // 바닥에 닿으면 멈춤
    }
  }

  void display() {
    fill(255);
    ellipse(x, y, size, size / 2);  // 방울의 형태
  }
}

void resetCandle() {
  // 랜덤한 크기의 양초 생성
  candleHeight = random(150, 400);  // 양초 높이 랜덤 설정
  candleWidth = random(50, 150);    // 양초 너비 랜덤 설정
  flameSize = random(60, 100);      // 불꽃 크기 랜덤 설정
  wickHeight = random(20, 40);      // 심지 길이 랜덤 설정
  meltSpeed = random(0.3, 0.8);     // 양초 녹는 속도 랜덤 설정
  flameDecay = random(0.1, 0.4);    // 불꽃 크기 감소 속도 랜덤 설정
  wickShrinkSpeed = random(0.1, 0.3);  // 심지 줄어드는 속도 랜덤 설정
  isBurning = true;    // 양초가 다시 타기 시작
}