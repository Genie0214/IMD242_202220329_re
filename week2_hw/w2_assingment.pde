//void setup() {
  //size(300, 300);
  //background(0);
//}

//void draw() {
  //background(0);
  //noStroke();
  //fill(255, 100, 150 );
  //circle(mouseX +50, mouseY, 50);
  //circle(mouseX -50, mouseY, 50);}

float eyeRadius = 30;
float eyeSpacing = 100;
float eyeX, eyeY;
float leftAntennaAngle = 0;
float rightAntennaAngle = 0;
boolean leftAntennaRight = true; 
boolean rightAntennaRight = true;
boolean mouthSurprised = false;
boolean eyesSurprised = false;   
void setup() {
  size(600, 600); 
  background(63, 226, 179);
  // Set initial eye position at the center
  eyeX = width / 2 - eyeSpacing / 2;
  eyeY = height / 2 - 50;
}

void draw() {
  background(101, 206, 174);
  
  // Draw antennae with rotation
  pushMatrix();
  translate(250, 150);  
  rotate(radians(leftAntennaAngle)); 
  stroke(0);
  strokeWeight(3);
  line(0, 0, 0, -50); 
  fill(223, 248, 67, 350);
  ellipse(0, -60, 20, 20); 
  popMatrix();
  
  pushMatrix();
  translate(350, 150); 
  rotate(radians(rightAntennaAngle));  
  stroke(0);
  strokeWeight(3);
  line(0, 0, 0, -50);  
  fill(223, 248, 67, 350);
  ellipse(0, -60, 20, 20);  
  popMatrix();
  
  // Bolts on the side of the head
  fill(216, 128, 197);
  strokeWeight(3);
  ellipse(150, height / 2, 90, 100);  
  ellipse(450, height / 2, 90, 100); 
  
  // Draw the robot's head
  fill(154, 207, 251);
  rect(150, 150, 300, 300, 30); 
  
  // Draw the robot's eyes (toggle between normal and surprised)
  fill(255);  
  ellipse(width / 2 - eyeSpacing / 2, height / 2 - 50, 80, 80); 
  ellipse(width / 2 + eyeSpacing / 2, height / 2 - 50, 80, 80);  

  // Draw the pupils that toggle between normal and surprised
  if (eyesSurprised) {
    // Surprised pupils (larger and centered)
    fill(0);
    ellipse(width / 2 - eyeSpacing / 2, height / 2 - 50, 50, 50);  
    ellipse(width / 2 + eyeSpacing / 2, height / 2 - 50, 50, 50);  
  } else {
    // Normal pupils that follow the mouse
    drawPupil(width / 2 - eyeSpacing / 2, height / 2 - 50);  
    drawPupil(width / 2 + eyeSpacing / 2, height / 2 - 50); 
  }
  
  // Draw the robot's mouth (toggle between surprised and normal)
  strokeWeight(3);
  fill(0);  // Black mouth
  if (mouthSurprised) {
    ellipse(width / 2, height / 2 + 90, 80, 80);  
  } else {
    rect(width / 2 - 70, height / 2 + 70, 140, 30, 20); 
  }
}

void drawPupil(float x, float y) {
  float angle = atan2(mouseY - y, mouseX - x);
  float pupilX = x + cos(angle) * eyeRadius;  
  float pupilY = y + sin(angle) * eyeRadius; 

  fill(0);  // Black pupil
  ellipse(pupilX, pupilY, 30, 30);  // Draw the pupil
}

void mousePressed() {
  // Toggle left antenna direction on click
  if (dist(mouseX, mouseY, 250, 150) < 30) {
    if (leftAntennaRight) {
      leftAntennaAngle += 45;
    } else {
      leftAntennaAngle -= 45;
    }
    leftAntennaRight = !leftAntennaRight; 
  }
  
  // Toggle right antenna direction on click
  if (dist(mouseX, mouseY, 350, 150) < 30) {
    if (rightAntennaRight) {
      rightAntennaAngle += 45;
    } else {
      rightAntennaAngle -= 45;
    }
    rightAntennaRight = !rightAntennaRight; 
  }
  
  // Toggle mouth expression (normal or surprised)
  mouthSurprised = !mouthSurprised;
  
  // Toggle eyes expression (normal or surprised)
  eyesSurprised = !eyesSurprised;
}