float xq, yq, fov, cx, cy, cz, tx0,tx1,tx2,ty0,ty1,ty2, xr, yr, zr, a;
void setup() {
size(500,500);
fill(255);
fov = 300;
cx = 0;
cy = 0;
cz = 50;
}

void draw() {
  background(0);
  xr += 0.05;
  tri(0,10,10,0,0,0,10,10,0,0);
  tri(0,0,0,10,0,10,0,10,10,1);
  tri(10,10,0,0,10,10,10,0,10,0);
  tri(0,0,0,10,10,0,10,0,10,1);
}

void three(float x, float y, float z, float xr, float yr, float zr, float xc, float yc, float zc) {
  //rotation matrix
  x = xc + ( (x * cos(xr)) + (z * sin(xr)) );
  y = yc + ((y * cos(yr)) + ( ((z * cos(xr)) - (x*sin(xr))) * sin(yr)));
  z = zc + ( (((z*cos(xr)) - (x*sin(xr)) ) * cos(yr)) - (y * sin(yr)));
  //3d projection
  xq = width/2 + fov * ((x + cx) / (z + cz));
  yq = height/2 + fov * ((y + cy) / (z + cz));
}

void tri(float x0, float y0, float z0, float x1, float y1, float z1, float x2, float y2, float z2, float side) {
three(x0,y0,z0,xr,yr,zr,0,0,0);
tx0 = xq; ty0 = yq;
three(x1,y1,z1,xr,yr,zr,0,0,0);
tx1 = xq; ty1 = yq;
three(x2,y2,z2,xr,yr,zr,0,0,0);
tx2 = xq; ty2 = yq;

  a = ((tx0-tx1) * (tx0-tx2)) - ((ty0-ty1) * (ty0-ty2));
  if(((a < 0) && side == 0) || (a > 0 && side == 1)) {
  triangle(tx0,ty0,tx1,ty1,tx2,ty2);
  }
  println(a);
}
