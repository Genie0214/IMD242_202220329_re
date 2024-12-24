let colours = ['#257180', '#F2E5BF', '#FD8B51', '#CB6040'];
let gravity = [0, 0.1];
let friction = 0.99;
let cnt = 0;
let mouse = [0, 0];

let confetties = [];

function setup() {
  createCanvas(800, 800);
}

function gen(x, y, n) {
  for (let i = 0; i < n; i++) {
    let randomW = random(4, 20);
    let randomH = random(4, 20);
    let randomForce = random(1, 10);
    let randomAngForce = random(-30, 30);
    let newConfetti = new Confetti(
      x,
      y,
      randomW,
      randomH,
      random(colours),
      randomForce,
      randomAngForce
    );
    confetties.push(newConfetti);
  }
}

function mousePressed() {
  cnt = 0;
  mouse[0] = mouseX;
  mouse[1] = mouseY;
}

function mouseReleased() {
  console.log('gen: ' + cnt);
  gen(mouse[0], mouse[1], cnt);
}

function keyPressed() {
  if (key === 'p' || key === 'P') {
    console.log('confetties: ' + confetties.length);
  }
}

function draw() {
  if (mouseIsPressed) {
    cnt++;
  }
  background(255);
  for (let i = confetties.length - 1; i >= 0; i--) {
    let aConfetti = confetties[i];
    aConfetti.update(gravity, friction);
    if (aConfetti.isOutOfScreen()) {
      confetties.splice(i, 1);
    }
  }
  for (let i = 0; i < confetties.length; i++) {
    confetties[i].display();
  }
}

class Confetti {
  constructor(x, y, w, h, color, force, angForce) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.color = color;
    this.vx = random(-force, force);
    this.vy = random(-force, force);
    this.angle = random(0, TWO_PI);
    this.angularVelocity = angForce * 0.01;
  }

  update(gravity, friction) {
    this.vx += gravity[0];
    this.vy += gravity[1];
    this.vx *= friction;
    this.vy *= friction;
    this.x += this.vx;
    this.y += this.vy;
    this.angle += this.angularVelocity;
  }

  isOutOfScreen() {
    return (
      this.x < -this.w || this.x > width + this.w || this.y > height + this.h
    );
  }

  display() {
    push();
    translate(this.x, this.y);
    rotate(this.angle);
    noStroke();
    fill(this.color);
    rectMode(CENTER);
    rect(0, 0, this.w, this.h);
    pop();
  }
}
