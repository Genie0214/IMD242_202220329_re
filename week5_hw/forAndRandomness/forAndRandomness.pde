float circleSize = 100; 
float[][] angles; 
int minGrid = 3; // 최소 그리드 수
int maxGrid = 16; // 최대 그리드 수

void setup() {
  size(800, 800);
  noFill();
  stroke(255);
}

void draw() {
  background(0);
  
  // 마우스 X 위치에 따라 타일의 갯수를 동적으로 변경
  int cols = int(map(mouseX, 0, width, minGrid, maxGrid)); 
  int rows = cols; // 정사각형 배치
  
  // 각도 배열의 크기 갱신
  angles = new float[cols][rows];
  
  // 타일의 크기 화면 크기에 맞게
  float tileSize = width / cols;

  // 마우스 Y 위치에 따라 노이즈 값 조정 (위: 노이즈 큼, 아래쪽: 작음)
  float noiseFactor = pow(10, map(mouseY, 0, height, 0, -3));

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float x = i * tileSize + tileSize / 2; // X 좌표 계산
      float y = j * tileSize + tileSize / 2; // Y 좌표 계산
      
      // 원 그리기
      ellipse(x, y, tileSize * 0.8, tileSize * 0.8); // 원 크기를 타일 크기에 맞게 조정
      
      // 노이즈 값을 사용해 회전 속도 조정
      float noiseValue = noise(i * 0.8, j * 0.8, frameCount * noiseFactor);
      float rotationSpeed = map(mouseY, 0, height, 1.0, 0.07); // 회전 속도 조정 (값을 줄여서 부드럽게 회전)
      angles[i][j] += map(noiseValue, 0, 0.7, -rotationSpeed, rotationSpeed) * 3; // 각도 변화를 더 크게
        
      // 점이 원 안에서 타일 크기에 비례해 움직이도록
      float ballRadius = tileSize * 0.4 - 5; // 타일 크기에 비례한 반지름
      float ballX = x + cos(angles[i][j]) * ballRadius;
      float ballY = y + sin(angles[i][j]) * ballRadius;
      
      // 선 그리기
      line(x, y, ballX, ballY);
      
      // 원 끝의 움직이는 점
      fill(255);
      ellipse(ballX, ballY, 10, 10);
      noFill();
    }
  }
}