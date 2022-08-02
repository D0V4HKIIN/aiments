class Arrow {
  float x, y, dir, size, clr;
  Arrow(float x, float y, float direction, float size) {
    this.x = x;
    this.y = y;
    this.dir = direction;
    this.size = size;
  }
  void update() {
    int count = 0;
    for (Charge charge : aim) {
      count++;
    }
    float[][] vector = new float[count][2];
    int i = 0;
    for (Charge charge : aim) {
      vector[i][0] = (charge.x-x)*charge.p/pow(dist(x, y, charge.x, charge.y), 2);
      vector[i][1] = (charge.y-y)*charge.p/pow(dist(x, y, charge.x, charge.y), 2);
      //DIVIDE BY DIST
      i++;
    }
    //opti pour plus tard mais i = count dans ce cas la

    float fx = 0, fy = 0;
    for (int j = 0; j<vector.length; j++) {
      fx += vector[j][0];
      fy += vector[j][1];
    }

    if ((0>fy && 0<fx) || (0>fy && 0>fx)) {
      this.dir = atan(fx/fy);
    } else if ((0<fy && 0<fx) || (0<fy && 0>fx)) {
      this.dir = atan(fx/fy)+PI;
    }

    clr = (atan((fx*fx+fy*fy)*100000)/(PI/2))*255;

    stroke(255, 255-clr, 0);
    fill(255, 255-clr, 0);
    //ellipse(x,y,size/5,size/5);
    arrow(x, y, size, dir);
    //line(x,y,x+(fx*10000),y+(fy*10000));
  }
}

class Charge {
  float x, y, p;
  Charge(float x, float y, float puissance) {
    this.x = x;
    this.y = y;
    this.p = puissance;
  }
  void show() {
    if (p == 1) {
      fill(0, 255, 0);
      stroke(0, 255, 0);
      dline(x, y, 50, 0);
      dline(x, y, 50, PI/2);
    } else if (p == -1) {
      fill(255, 0, 0);
      stroke(255, 0, 0);
      dline(x, y, 50, PI/2);
      ellipse(x, y, 10, 10);
    }
  }
}

ArrayList<Arrow> arrows;
ArrayList<Charge> aim;
int nbx = 41;
int nby = 25;
void setup() {
  size(displayWidth, 1000);
  frameRate(60);
  arrows = new ArrayList<Arrow>();
  aim = new ArrayList<Charge>();
  //aim.add(new Charge(width/2+1,height/2-125,-1));
  //aim.add(new Charge(width/2-1,height/2+125,1));
  for (int x = 0; x<nbx; x++) {
    for (int y = 0; y<nby; y++) {
      arrows.add(new Arrow(x*width/(nbx-1), y*height/(nby-1), random(2*PI), 25));
    }
  }
}

boolean h = false;
int hold = 0;
void draw() {
  background(0);
  for (Charge charge : aim) {
    charge.show();
  }
  for (Arrow arrow : arrows) {
    arrow.update();
  }
  //Phone:
  /*if(h == true){
   hold ++;
   }else{
   hold = 0;
   }*/
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    aim.add(new Charge(mouseX, mouseY, -1));
  } else { 
    aim.add(new Charge(mouseX, mouseY, 1));
  }
  //Phone:
  //h = true;
}


//Phone
/*void mouseReleased(){
 if(hold > 15){
 aim.add(new Charge(mouseX,mouseY,-1));
 }else{
 aim.add(new Charge(mouseX,mouseY,1));
 }
 h = false;
 hold = 0;
 }*/

void keyPressed() {
  if (key == 'r') {
    frameCount = -1;
  }
}

void arrow(float x, float y, float size, float dir) {
  dline(x, y, size, dir);
  dline(x-(size/2)*sin(dir)+(size/4)*cos(dir+PI/4)+(size/2)*cos(PI/4)*sin(dir), y-(size/2)*cos(dir)+(size/4)*cos(dir+PI/4), size/2, dir+PI/4);
  dline(x-(size/2)*sin(dir)-(size/4)*cos(dir-PI/4)+(size/2)*cos(PI/4)*sin(dir), y-(size/2)*cos(dir)+(size/4)*cos(dir-PI/4), size/2, dir-PI/4);
}

void dline(float x, float y, float size, float dir) {
  strokeWeight(3);
  line(x-(size/2)*sin(dir), y-(size/2)*cos(dir), x+(size/2)*sin(dir), y+(size/2)*cos(dir));
}
