//Pacman 2.0 - Nick Gonella

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

world World[][] = new world[29][32];
munch Dots[][] = new munch[28][31];
pacman p = new pacman();
winMan w = new winMan();
ghost g = new ghost(color(255, 0, 0));
vestigial stage = new vestigial((29*16), (32*16));
//lives l = new lives();
Minim controller = new Minim(this);
AudioPlayer chomp;
AudioPlayer death;
PImage gameOver;
int gIndex = 16;
boolean playState = false;
int life = 3;
int dIndex = 0;
boolean deathOnce = false;
boolean help = true;


void setup() {
  //(29*16) x (34*16)
  size(464, 544);
  String[] rows = loadStrings("maps/standard.txt");
  String[] letters = new String[29];
  int x = 0;
  int y = 0;
  gameOver = loadImage("data/gameOver.png");
  chomp = controller.loadFile("pacman_chomp.wav", 512);
  death = controller.loadFile("pacman_death.wav", 512);
  for (y = 0; y< stage.height; y+=16) {
    letters = split(rows[y/16], ',');
    for (x = 0; x < stage.width; x+=16) {
      if (letters[x/16].equals("W")) {  
        World[x/16][y/16]=new world(x, y, 1);
      } else if (letters[x/16].equals("I")) {
        World[x/16][y/16]=new world(x, y, 3);
      } else {
        World[x/16][y/16]=new world(x, y, 0);
      }
    }
  }
}


void draw() {
  fill(0);
  rect(0, stage.height, stage.width, 32);
  if (p.alive&&!p.win) {
    //l.draw();
    //l.update();
    for (int y = 0; y< stage.height; y+=gIndex) {
      for (int x = 0; x < stage.width; x+=gIndex) {
        World[x/gIndex][y/gIndex].draw();
        World[x/gIndex][y/gIndex].typeUpdate();
      }
    }
    if (playState) {
      for (int y=16; y < stage.height-16; y+=16) {
        for (int x=16; x < stage.width-16; x+=16) {
          if (Dots[(x/16)-1][(y/16)-1] != null) {
            Dots[(x/16)-1][(y/16)-1].draw();
            Dots[(x/16)-1][(y/16)-1].update();
          }
        }
      }
    }
    p.draw();
    if (!g.noGhost) {
      g.draw();
    }
    if (keyPressed && playState && key != 'p') {
      p.update();
      if (frameCount%45==0) {
        chomp.play();
        chomp.rewind();
      }
      p.mouth += p.mIndex;
      if (p.mouth > 20 || p.mouth < 0) {
        p.mIndex = -1*p.mIndex;
      }
    }
    if (playState) {
      g.update();
    }
  }
  helpScreen();
  if (abs(PVector.dist(g.pos, p.pos))<32) {
    death();
  }
  if (p.score>=2980) {
    win();
  }
}


void mousePressed() {
  if (mouseY < stage.height && !playState) {
    if (mouseButton==LEFT) {
      World[mouseX/gIndex][mouseY/gIndex].worldType++;
    }
    if (mouseButton==RIGHT) {
      World[mouseX/gIndex][mouseY/gIndex].worldType=3;
    }
  }
  if (mouseX<60&&mouseY>stage.height) {
    help = !help;
  }
}


void keyPressed() {
  String[] rowsout = new String[32];
  String[] lettersout =  new String[29];
  String[] rowsin = loadStrings("maps/custom.txt");
  String[] lettersin = new String[29];
  switch(key) {
  case 'p':
    playState = true;
    for (int y=16; y < stage.height-16; y+=16) {
      for (int x=16; x < stage.width-16; x+=16) {
        if (World[x/gIndex][y/gIndex].worldType==0 && World[(x/gIndex)-1][y/gIndex].worldType==0 && World[x/gIndex][(y/gIndex)-1].worldType==0 && World[(x/gIndex)-1][(y/gIndex)-1].worldType==0) {
          Dots[(x/16)-1][(y/16)-1] = new munch(x, y);
        } else {
          Dots[(x/16)-1][(y/16)-1] = null;
        }
      }
    }
    break;
  case 'r':
    p.alive=true;
    p.win=false;
    g.noGhost = false;
    p.score = 0;
    dIndex = 0;
  case 'e':
    playState = false;
    p.pos.set(232, 288);
    g.pos.set(232, 192);
    p.mouth=0;
    p.angle=0;
    break;
  case 'q':
    for (int y = 0; y< stage.height; y+=16) {
      for (int x = 0; x < stage.width; x+=16) {
        if (World[x/16][y/16].worldType == 1) {
          lettersout[x/16] = "W";
        } else if (World[x/16][y/16].worldType == 3) {
          lettersout[x/16] = "I";
        } else {
          lettersout[x/16] = "O";
        }
      }
      rowsout[y/16]= join(lettersout, ",");
    }
    saveStrings("maps/custom.txt", rowsout);
    break;
  case 'l':
    for (int y = 0; y< stage.height; y+=16) {
      lettersin = split(rowsin[y/16], ',');
      for (int x = 0; x < stage.width; x+=16) {
        if (lettersin[x/16].equals("W")) {  
          World[x/16][y/16]=new world(x, y, 1);
        } else if (lettersin[x/16].equals("I")) {  
          World[x/16][y/16]=new world(x, y, 3);
        } else {
          World[x/16][y/16]=new world(x, y, 0);
        }
      }
    }
  case TAB:
    p.score=2960;
    break;
  default:
    break;
  }
}

void death() {
  g.noGhost=true;
  playState=false;
  if (!deathOnce) {
    death.play();
    deathOnce=true;
  }
  if (dIndex<7) {
    p.mouth=0;
    p.angle += dIndex;
    if (frameCount%18==0) {
      dIndex++;
    }
  } else {
    p.alive=false;
    background(0);
    image(gameOver, -70, 0);
  }
}

void win() {
  p.win=true;
  background(0);
  fill(0);
  stroke(0, 0, 255);
  strokeWeight(5);
  rect(160, 190, 140, 140);
  strokeWeight(1);
  textSize(48);
  fill(255, 255, 0);
  text("YOU\nWIN", 181, ((stage.height)/2)-16);
  w.draw();
  w.update();
}

void helpScreen() {
  fill(255, 255, 0);
  textSize(25);
  text("HELP", 0, height-5);
  if (help) {
    background(0);
    fill(0);
    stroke(0, 0, 255);
    strokeWeight(5);
    rect(112, 105, width-225, height-210);
    strokeWeight(1);
    fill(255, 255, 0);
    textSize(25);
    text("CLOSE", 0, height-5);
    fill(255);
    textSize(35);
    text("PACMAN", 160, 143);
    textSize(20);
    text("UP", 132, 180);
    text("W", 312, 180);
    text("DOWN", 132, 210);
    text("S", 312, 210);
    text("LEFT", 132, 240);
    text("A", 312, 240);
    text("RIGHT", 132, 270);
    text("D", 312, 270);
    text("RESET", 132, 300);
    text("R", 312, 300);
    text("PLAY MODE", 132, 330);
    text("P", 312, 330);
    text("EDIT MODE", 132, 360);
    text("E", 312, 360);
    text("SAVE", 132, 390);
    text("Q", 312, 390);
    text("LOAD", 132, 420);
    text("L", 312, 420);
  }
}