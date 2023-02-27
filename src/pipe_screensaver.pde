// Cole Cram| oct, 9, 2022 | screenSaver
float xpos, ypos, strokeW, pointCount, repCount;
void setup() {
  size(400, 400);
  xpos = random(width);
  ypos = random(height);
}

void draw () {
  //repCount = random(0,80);
  //xpos = 0;
  //ypos = 0;
  //while (repCount < 200) {
    strokeW = random(1, 3);
    pointCount = random(2, 10);
    stroke(random(10), random(100), random(200));
    if (xpos > width || xpos < 0 || ypos > height || ypos < 0) {
      xpos = random(width);
      ypos = random(height);
    }
    if (random(100)>75) {
      strokeWeight(strokeW);
      moveLeft(xpos, ypos, pointCount);
    } else if (random(100)<75) {
      strokeWeight(strokeW);
      moveUp(xpos, ypos, pointCount);
    } else if (random(100)>75) {
      strokeWeight(strokeW);
      moveDown(xpos, ypos, pointCount);
    } else {
      strokeWeight(strokeW);
      moveRight(xpos, ypos, pointCount);
    }
    while(millis()%100 > 99) {
      stroke(255);
    text("WAITING",width/2,height/2);
    }
    repCount++;
  }
//}

void moveRight(float startX, float startY, float moveCount) {
  for (float i=0; i<moveCount; i++) {
    point(startX+i, startY);
    xpos = startX + i;
  }
}

void moveLeft(float startX, float startY, float moveCount) {
  for (float i=0; i<moveCount; i++) {
    point(startX - i, startY);
    xpos = startX - i;
  }
}

void moveUp(float startX, float startY, float moveCount) {
  for (float i=0; i<moveCount; i++) {
    point(startX, startY-i);
    ypos = startY - i;
  }
}

void moveDown(float startX, float startY, float moveCount) {
  for (float i=0; i<moveCount; i++) {
    point(startX, startY+i);
    ypos = startY + i;
  }
}
