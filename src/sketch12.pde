//Cole Cram | 12/3/2022 | 3D space game
// i am very proud of this engine, but i am not proud of the game.

float fov, cx, cy, cz, xq, yq, zq, x, y, fca, fcb, fcc, fcd, fce, qarea, lowz, time,bldz, oldDist;
float[] xposs = new float[10000];
float[] yposs = new float[10000];
color[] colors = new color[10000];
color[] presetcolors = {
  color(0,200,200),color(0,120,200),
color(0,200,200),color(0,120,200),
color(255,200,0),color(255,0,0),
color(255,100,0),color(255,100,0),
color(255,100,0),color(0,200,100),
};
float[] dangers = new float[10000];
float[] zorder = new float[10000];
int[] numorder = new int[10000];
float[] zhold = new float[4];
float[] xdrawo = new float[10000];
float[] ydrawo = new float[10000];
int[] order = new int[10000];
float[] zorderhold = new float[10000];
int quads, quadct, poly, vertnum, iteration, vertex, lownum, sdiv, pillarcalc;
boolean facing, showfaces, doFill, lowsectors, renderfirst;
void setup() {
  //noCursor();
  size(1000, 1000);
  fov = 300;
  cx = 0;
  cy = 0;
  cz = 25;
  y = -PI/1.3;
  showfaces = false;
  doFill = true;
  lowsectors = false;
  sdiv = 5;
  quads = 4;
  //noStroke();
  for (int i = 0; i < colors.length; i++) {
    if(int(random(10)) >= 7) {
    dangers[i] = random(-100,100);
    }
    if(i < presetcolors.length) {
    colors[i] = presetcolors[i];
    } else {
   colors[i] = color(random(50, 200), random(0, 60), random(0, 60));
    }
  }
  strokeWeight(0);
}

void draw() {
  //if(time < 6.3) {y = time-PI/1.6;} else { y = -PI/1.6;}
  time+= 0.1;
  poly = -1;
  quadct = 0;
  background(0);
  fill(0);
  //drawCube();
  //  doFill = false;
  x = mouseX/PI/(height/10)+PI/2;
  cx = (mouseX/20)-25;
  y = -PI/1.6;
  cz = 10;
  cy = 0;
  renderfirst = true;
  drawShip();
  renderfirst = false;
  //  doFill = true;
    cy = -30;
  x = 0;
  cx = 0;
    x = 0;
  cz = 100;
  y = -PI/8;
  bldz = ((0-time*(5+time/5)))-2000;
  //println(1+time/5);
    for(int i = 0; i < 80; i++) {
    bdng(i*30);
    }
  calcorder();
  drawProjected();
  //x += 0.01;
  //y = -mouseY/PI/(height/40);
}

void bdng(float dist) {
  oldDist = dist;
  dist = (dist + bldz)%2000+1910;
rect3d(10,30,0,-50+x,0,dist,1,0);
rect3d(0,30,5,-40+x,0,5+dist,1,0);
rect3d(10,30,0,50+x,0,dist,1,0);
rect3d(0,30,5,40+x,0,5+dist,-1,0);
rect3d(400,0,15,0+x,30,dist,-1,1);
pillarcalc = abs(int((oldDist)%2000));
//println(dangers[pillarcalc]);
if(((dangers[pillarcalc]+50)*8)-400 >= mouseX-20 && ((dangers[pillarcalc]+50)*8)-400 <= mouseX+20 && dist < 10 && time > 10){
  println(((dangers[pillarcalc]+50)*8)-400);
  exit();
  //exit();
} //else {println("all good");}
if (dangers[pillarcalc] > 1) {
rect3d(10,30,0,-50+dangers[pillarcalc],0,dist,1,0);
//dangers[abs(int(oldDist%1000))] += random(-1,1);
//if(dangers[pillarcalc] > 120 || dangers[pillarcalc] < 0) {
//dangers[pillarcalc] = 60;
//}
}
}

void drawShip() {
  //top
quad3d(5,0,0,0,-0.5,1.5,0,0,1.5,0,10,0,-1,0,0,0);
quad3d(0,0,1.5,0,-0.5,1.5,-5,0,0,0,10,0,-1,0,0,0);
//bottom
quad3d(5,0,0,0,-0.5,-1.5,0,0,-1.5,0,10,0,1,0,0,0);
quad3d(0,0,-1.5,0,-0.5,-1.5,-5,0,0,0,10,0,1,0,0,0);
//back
quad3d(0,-0.5,-1.5,-5,0,0,0,-0.5,1.5,5,0,0,-1,0,0,0);
//jet back
quad3d(0,-1,-1.5+cos(time),-2.5+sin(time),-1,0,0,-1,1.5-cos(time),2.5-sin(time),-1,0,-1,0,0,0);
quad3d(0,-1.5,-1.5+(cos(time)*0.5),-1.5+(cos(time)*0.5),-1.5,0,0,-1.5,1.5-(cos(time)*0.5),1.5-(cos(time)*0.5),-1.5,0,-1,0,0,0);
//jet front
quad3d(0,-0.5,-1.5,-2.5,-1,0,0,-1,1.5,2.5,-1,0, 1,0,0,0);
quad3d(0,-1.5,-1.5,-1.5,-1.5,0,0,-1.5,1.5,1.5,-1.5,0, 1,0,0,0);

}


void drawCube() {
  rect3d(0, 20, 20, 20, 0, 0, 1, 0);
  rect3d(-20, -20, 0, 0, 0, -20, 1, 0);
  rect3d(20, 20, 0, 0, 0, 20, -1, 0);
  rect3d(0, -20, -20, -20, 0, 0, -1, 0);
  rect3d(-20, 0, -20, 0, 20, 0, 1, 1);
  rect3d(-20, 0, -20, 0, -20, 0, -1, 1);
  
  rect3d(0, 20, 20, 30, 0, 0, -1, 0);
  rect3d(0, 20, 20, 30, 0, 0, 1, 0); //-
  
  rect3d(0, 20, 20, -30, 0, 0, -1, 0); //-
  rect3d(0, 20, 20, -30, 0, 0, 1, 0);
  
  rect3d(20, 20, 0, 0, 0, 30, -1, 0); //-
  rect3d(20, 20, 0, 0, 0, 30, 1, 0);
  
  rect3d(20, 20, 0, 0, 0, -30, -1, 0);
  rect3d(20, 20, 0, 0, 0, -30, 1, 0); //-
  
  rect3d(-20, 0, -20, 0, 30, 0, -1, 1);
  rect3d(-20, 0, -20, 0, 30, 0, 1, 1); //-
  
  rect3d(-20, 0, -20, 0, -30, 0, -1, 1); //-
  rect3d(-20, 0, -20, 0, -30, 0, 1, 1);
}

void rect3d(float xs, float ys, float zs, float ox, float oy, float oz, int side, int top) {
  poly++;
  vertnum = poly*4;
  if (top == 0) {
    three(-xs+ox, -ys+oy, -zs+oz, x, y, 0, 0, 0, 0);

    xposs[vertnum] = xq;
    yposs[vertnum] = yq;
    zhold[0] = zq;
    three(-xs+ox, ys+oy, -zs+oz, x, y, 0, 0, 0, 0);
    vertnum += 1;
    xposs[vertnum] = xq;
    yposs[vertnum] = yq;
    zhold[1] = zq;

    three(xs+ox, ys+oy, zs+oz, x, y, 0, 0, 0, 0);
    vertnum += 1;
    xposs[vertnum] = xq;
    yposs[vertnum] = yq;
    zhold[2] = zq;

    three(xs+ox, -ys+oy, zs+oz, x, y, 0, 0, 0, 0);
    vertnum += 1;
    xposs[vertnum] = xq;
    yposs[vertnum] = yq;
    zhold[3] = zq;
  } else {


    three(-xs+ox, -ys+oy, -zs+oz, x, y, 0, 0, 0, 0);

    xposs[vertnum] = xq;
    yposs[vertnum] = yq;
    zhold[0] = zq;

    three(-xs+ox, ys+oy, zs+oz, x, y, 0, 0, 0, 0);
    vertnum += 1;
    xposs[vertnum] = xq;
    yposs[vertnum] = yq;
    zhold[1] = zq;

    three(xs+ox, ys+oy, zs+oz, x, y, 0, 0, 0, 0);
    vertnum += 1;
    xposs[vertnum] = xq;
    yposs[vertnum] = yq;
    zhold[2] = zq;

    three(xs+ox, -ys+oy, -zs+oz, x, y, 0, 0, 0, 0);
    vertnum += 1;
    xposs[vertnum] = xq;
    yposs[vertnum] = yq;
    zhold[3] = zq;
  }
  calcfacing(side);
}


void quad3d(float x0, float y0, float z0, float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, int side, float ox, float oy, float oz) {
  poly++;
  vertnum = poly*4;
  x0 += ox;
  x1 += ox;
  x2 += ox;
  y0 += oy;
  y1 += oy;
  y2 += oy;
  z0 += oz;
  z1 += oz;
  z2 += oz;
    three(x0, y0, z0, x, y, 0, 0, 0, 0);

    xposs[vertnum] = xq;
    yposs[vertnum] = yq;
    zhold[0] = zq;
    three(x1, y1, z1, x, y, 0, 0, 0, 0);
    vertnum += 1;
    xposs[vertnum] = xq;
    yposs[vertnum] = yq;
    zhold[1] = zq;

    three(x2, y2, z2, x, y, 0, 0, 0, 0);
    vertnum += 1;
    xposs[vertnum] = xq;
    yposs[vertnum] = yq;
    zhold[2] = zq;

    three(x3, y3, z3, x, y, 0, 0, 0, 0);
    vertnum += 1;
    xposs[vertnum] = xq;
    yposs[vertnum] = yq;
    zhold[3] = zq;
    
    calcfacing(side);
}

void calc3d(float x, float y, float z) {
  if (-z < cz) {
    xq = width/2 + fov * ((x + cx) / (z + cz));
    yq = height/2 + fov * ((y + cy) / (z + cz));
    if(!renderfirst) {
    zq = z;
    } else {zq = z -500;}
  } else {
  xq = 500;
  yq = height;
  }
}

void three(float x, float y, float z, float xr, float yr, float zr, float xc, float yc, float zc) {
  //x = x * cos(zr) - y * sin(zr);
  //y = y * cos(zr) + x * sin(zr);
  calc3d(
    xc + (((x * cos(xr)) + (z * sin(xr)))),
    yc + ((y * cos(yr) )  + ( ((z * cos(xr)) - (x*sin(xr))) * sin(yr))),
    zc + ( (((z*cos(xr)) - (x*sin(xr)) ) * cos(yr)) - (y * sin(yr))));
}

void calcorder() {
  lowz = -1000;
  //zorderhold = zorder;
  for (int i = 0; i < poly+1; i++) {

    for (int u = 0; u < poly+1; u++) {
      if (zorder[u] > lowz) {
        lowz = zorder[u];
        lownum = u;
      }
    }
    numorder[i] = lownum;
    zorder[lownum] = -100000;
    lowz = -100000;
  }
}

void drawProjected() {
  for (int i = 0; i <= poly; i++) {
    vertex = numorder[i];
    //println(vertex + ", " + i);
    if (zorderhold[vertex] > -9999) {
      if(doFill) {
      fill(colors[vertex]);
      }
      stroke(colors[vertex]);
      if(!lowsectors) {
      quad(xposs[vertex*4], yposs[vertex*4], xposs[1+vertex*4], yposs[1+vertex*4], xposs[2+vertex*4], yposs[2+vertex*4], xposs[3+vertex*4], yposs[3+vertex*4]);
      } else {
      quad(round(xposs[vertex*4]/sdiv)*sdiv, round(yposs[vertex*4]/sdiv)*sdiv, round(xposs[1+vertex*4]/sdiv)*sdiv, round(yposs[1+vertex*4]/sdiv)*sdiv, round(xposs[2+vertex*4]/sdiv)*sdiv, round(yposs[2+vertex*4]/sdiv)*sdiv, round(xposs[3+vertex*4]/sdiv)*sdiv, round(yposs[3+vertex*4]/sdiv)*sdiv);
      }
    }
  }
}

void calcfacing(int side) {
  vertnum = vertnum - 3;
  fca = (xposs[vertnum] * yposs[1+vertnum]) - (yposs[vertnum] * xposs[1+vertnum]);
  fcb = (xposs[1+vertnum] * yposs[2+vertnum]) - (yposs[1+vertnum] * xposs[2+vertnum]);
  fcc = (xposs[2+vertnum] * yposs[3+vertnum]) - (yposs[2+vertnum] * xposs[3+vertnum]);
  fcd = (xposs[3+vertnum] * yposs[vertnum]) - (yposs[3+vertnum] * xposs[vertnum]);
  qarea = (fca + fcb + fcc + fcd);
  if ((qarea / abs(qarea)) != side || showfaces) {
    zorder[poly] = (zhold[0] + zhold[1] + zhold[2] + zhold[3]) / 4;
  } else {
    zorder[poly] = -100000;
  }
}

// + ((x * cos(zr)) - (y * sin(zr)))
// + ((x * sin(zr)) + (y * cos(zr)))
