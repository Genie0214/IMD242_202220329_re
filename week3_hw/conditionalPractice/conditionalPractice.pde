void setup() {
  size(640, 360);
  background(0);
  rectMode(CENTER);
}

void draw() {
  background(0);
  stroke(127);
  strokeWeight(4);
  
  line(0, height / 4, width, height / 4);
  line(0, height / 2, width, height / 2);
  line(0, 3 * height / 4, width, 3 * height / 4);
  
  stroke(255);
  float size = 60;
  fill(175);
  
  if (mouseY < height / 4) {
    line(width / 2 - size / 2, height / 8 - size / 2, width / 2 + size / 2, height / 8 + size / 2);
  } else if (mouseY < height / 2) {
    ellipse(width / 2, height / 4 + height / 8, size, size);
  } else if (mouseY < 3 * height / 4) {
    rect(width / 2, height / 2 + height / 8, size, size, 15);
  } else {
    rect(width / 2, 3 * height / 4 + height / 8, size, size);
  }
}
