class pacman {
  PVector pos;
  PVector v;
  int angle;
  int mouth;
  int mIndex;
  int score;
  boolean alive;
  boolean win;
  boolean cUp = false;
  boolean cDown = false;
  boolean cLeft = false;
  boolean cRight = false;

  pacman() {
    pos = new PVector(232, 288);
    v = new PVector(0, 0);
    angle=0;
    mouth = 0;
    mIndex = 1;
    alive=true;
    win=false;
    score = 0;
  }

  void draw() {
    fill(255, 255, 0);
    arc(pos.x, pos.y, 32, 32, radians(angle-340-mouth), radians(angle-20+mouth));
  }

  void update() {
    if (World[(int)(pos.x/16)][((int)(pos.y/16))-1].worldType == 1 || World[((int)(pos.x/16))][((int)(pos.y/16))].worldType == 1 ) {
      cUp = true;
    }
    if (World[(int)(pos.x/16)][((int)(pos.y/16))+1].worldType == 1 || World[(int)(pos.x/16)][((int)(pos.y/16))].worldType == 1) {
      cDown = true;
    }
    if (World[((int)(pos.x/16))-1][(int)(pos.y/16)].worldType == 1 || World[(int)(pos.x/16)][((int)(pos.y/16))].worldType == 1) {
      cLeft = true;
    }
    if (World[((int)(pos.x/16))+1][((int)(pos.y/16))].worldType == 1 || World[(int)(pos.x/16)][((int)(pos.y/16))].worldType == 1) {
      cRight = true;
    }
    switch (key) {
    case 'w':
      if (!cUp) {
        v.x = 0;
        v.y = -1;
        angle=270;
      }
      cDown = false;
      cRight = false;
      cLeft = false;
      break;
    case 's':
      if (!cDown) {
        v.x = 0;
        v.y = 1;
        angle=90;
      }
      cUp = false;
      cRight = false;
      cLeft = false;
      break;
    case 'd':
      if (!cRight) {
        v.x = 1;
        v.y = 0;
        angle=0;
      }
      cUp = false;
      cDown = false;
      cLeft = false;
      break;
    case 'a':
      if (!cLeft) {
        v.x = -1;
        v.y = 0;
        angle = 180;
      }
      cUp = false;
      cDown = false;
      cRight = false;
      break;
    default:
      break;
    }
    pos.add(v);
    v.set(0, 0);
    if (pos.x == 17) {
      pos.x = stage.width-18;
    }
    if (pos.x == stage.width-17) {
      pos.x = 18;
    }
  }
}
