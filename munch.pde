class munch {
  PVector pos;
  boolean eaten;
  int node;

  munch(int xin, int yin) {
    pos = new PVector(xin, yin);
    eaten = false;
    node = 0;
  }

  void draw() {
    if (!eaten) {
      fill(255, 255, 0);
      noStroke();
      ellipse(pos.x, pos.y, 8, 8);
      stroke(1);
    }
  }

  void update() {
    if (abs(p.pos.x-pos.x)<8 && abs(p.pos.y-pos.y)<8) {
      if (!eaten) {
        p.score +=10;
      }
      eaten = true;
    }
  }
}