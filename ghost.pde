class ghost {
  PVector pos;
  PVector v;
  PVector tmp;
  color c;
  char direction;
  int randomNum;
  boolean noGhost;
  boolean cUp;
  boolean cDown;
  boolean cLeft;
  boolean cRight;

  ghost (color cin) {
    pos= new PVector(232, 192);
    v = new PVector(0, 0);
    tmp = new PVector(0,0);
    c = cin;
    direction = 'a';
    noGhost = false;
    cUp = false;
    cDown = false;
    cLeft = false;
    cRight = false;
  }

  void draw() {
    fill(c);
    noStroke();
    arc(pos.x, pos.y, 30, 30, PI, TWO_PI);
    rect(pos.x-15, pos.y-2, 30, 18);
    fill(255, 255, 0);
    textSize(25);
    text("Score: " + str(p.score), 320, 540);
    fill(0);
    triangle(pos.x-15, pos.y+16, pos.x-11, pos.y+12, pos.x-6, pos.y+16);
    triangle(pos.x-5, pos.y+16, pos.x, pos.y+12, pos.x+5, pos.y+16);
    triangle(pos.x+6, pos.y+16, pos.x+11, pos.y+12, pos.x+15, pos.y+16);
    stroke(0);
  }

  void update() {
    if (World[(int)((pos.x)/16)][((int)(pos.y/16))-1].worldType == 1 || World[((int)(pos.x)/16)][((int)(pos.y/16))].worldType == 1) {
      cUp = true;
    }
    if (World[(int)((pos.x)/16)][((int)(pos.y/16))+1].worldType == 1 || World[(int)((pos.x)/16)][((int)(pos.y/16))].worldType == 1) {
      cDown = true;
    }
    if (World[((int)((pos.x)/16))-1][(int)(pos.y/16)].worldType == 1 || World[(int)((pos.x)/16)][((int)(pos.y/16))].worldType == 1) {
      cLeft = true;
    }
    if (World[((int)((pos.x)/16))+1][((int)(pos.y/16))].worldType == 1 || World[(int)((pos.x)/16)][((int)(pos.y/16))].worldType == 1) {
      cRight = true;
    }
    if (frameCount%1==0) {
        if (g.pos.y>p.pos.y && !cUp) {
        direction = 'u';
      } else if (g.pos.x<p.pos.x && !cRight) {
        direction = 'r';
      } else if (g.pos.y<p.pos.y && !cDown) {
        direction = 'd';
      } else if (g.pos.x>p.pos.x && !cLeft) {
        direction = 'l';
      } else {
      }
    }
    //println(direction);
    switch (direction) {
    case 'u':
      if (!cUp) {
        v.x = 0;
        v.y = -0.5;
      }
      cDown = false;
      cRight = false;
      cLeft = false;
      break;
    case 'd':
      if (!cDown) {
        v.x = 0;
        v.y = 0.5;
      }
      cUp = false;
      cRight = false;
      cLeft = false;
      break;
    case 'r':
      if (!cRight) {
        v.x = 0.5;
        v.y = 0;
      }
      cUp = false;
      cDown = false;
      cLeft = false;
      break;
    case 'l':
      if (!cLeft) {
        v.x = -0.5;
        v.y = 0;
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