class world {
  color c;
  int worldType;
  PVector topLeft = new PVector(0, 0);

  world(int inx, int iny) {
    topLeft = new PVector(inx, iny);
    c = color(255);
    worldType=0;
  }

  world(int inx, int iny, int inState) {
    topLeft = new PVector(inx, iny);
    c = color(255);
    worldType=inState;
  }

  void draw() {
    fill(c);
    rect(topLeft.x, topLeft.y, 16, 16);
  }

  void typeUpdate() {
    switch(worldType) {
    case 0: 
      c=color(0);
      break;
    case 1: 
      c=color(0, 0, 255);
      break;
    case 3:
      c=color(0);
      break;
    default: 
      worldType=0;
      break;
    }
  }
}
