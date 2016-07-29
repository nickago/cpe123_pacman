class winMan extends pacman {
  
  int startFrame;
  int turn;
  boolean once;
  
  winMan(){
    super();
    turn = 0;
    once=false;
  }

  void draw() {
    stroke(0);
    super.draw();
  }
  
  void update() {
  if(!once){
  startFrame=frameCount;
  pos.set(335,367);
  once=true;
  }
    if((frameCount-startFrame)%210 == 0){
      turn++;
    }
    switch(turn){
      case 0:
         v.set(0,1);
         angle=90;
         break;
      case 1:
         v.set(-1,0);
         angle=180;
         break;
      case 2:
         v.set(0,-1);
         angle=270;
         break;
      case 3:
         v.set(1,0);
         angle=0;
         break;
      default:
         turn=0;
         break;
    }
    pos.add(v);
    v.set(0,0);
  }
}