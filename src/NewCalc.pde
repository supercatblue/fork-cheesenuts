// Cole Cram | Nov. 2022 | Calc Project
byte prs = 0, numq;
String kprs, kpout, kpoutf, kpin0, kpin1, disp0, disp1, disp2, disp3, disp4, mathq, lastfunct, qswitch;
boolean mr, md, firstcall, direction, neg0, neg1, negflip, equfirst;
double out, in0, in1, sto0, sto1;
int min, max, hold, calclen, memnum;
String[] mem = new String[1000];
Button[] numButtons = new Button[10];
Button[] opButtons = new Button[17];

void setup() {
  for(int i = 0; i < 1000; i++) {mem[i] = "000000000";}
  kpout = "000000000";
  kpin0 = "000000000";
  kpin1 = "000000000";
  disp0 = "000000000";
  disp1 = "000000000";
  disp2 = "000000000";
  disp3 = "000000000";
  disp4 = "000000000";
  lastfunct = " ";
  kpoutf = " ";
  size(900, 300);
  numButtons[0] = new Button(10, 10, 90, 40, "7", color(200));
  numButtons[1] = new Button(110, 10, 90, 40, "8", color(200));
  numButtons[2] = new Button(210, 10, 90, 40, "9", color(200));
  numButtons[3] = new Button(10, 60, 90, 40, "4", color(200));
  numButtons[4] = new Button(110, 60, 90, 40, "5", color(200));
  numButtons[5] = new Button(210, 60, 90, 40, "6", color(200));
  numButtons[6] = new Button(10, 110, 90, 40, "1", color(200));
  numButtons[7] = new Button(110, 110, 90, 40, "2", color(200));
  numButtons[8] = new Button(210, 110, 90, 40, "3", color(200));
  numButtons[9] = new Button(110, 160, 90, 40, "0", color(200));

  opButtons[0] = new Button(10, 160, 90, 40, "ADD", color(200));
  opButtons[1] = new Button(210, 160, 90, 40, "SUB", color(200));
  opButtons[2] = new Button(310, 10, 90, 40, "STO", color(200));
  opButtons[3] = new Button(310, 60, 90, 40, "RCL", color(200));
  opButtons[4] = new Button(310, 110, 90, 40, "%", color(200));
  opButtons[5] = new Button(310, 160, 90, 40, ".", color(200));
  opButtons[6] = new Button(10, 210, 90, 40, "+/-", color(200));
  opButtons[7] = new Button(110, 210, 90, 40, "MIN", color(200));
  opButtons[8] = new Button(210, 210, 90, 40, "MAX", color(200));
  opButtons[9] = new Button(310, 210, 90, 40, "Σ", color(200));

  opButtons[10] = new Button(410, 10, 90, 40, "MOD", color(200));
  opButtons[11] = new Button(495, 210, 60, 40, "FLIP", color(200));
  opButtons[12] = new Button(410, 110, 90, 40, "MULT", color(200));
  opButtons[13] = new Button(410, 60, 90, 40, "DIV", color(200));
  opButtons[14] = new Button(410, 160, 90, 40, "MEM#", color(200));
  opButtons[15] = new Button(410, 210, 90, 40, "CLR", color(200));
  opButtons[16] = new Button(495, 85, 60, 190, "EQ0", color(200));
}

void draw() {
  rectMode(CENTER);
  background(250,250,255);
  fill(0);
  rect(730,130,320,230,6);
  fill(250);
  for (int i = 0; i < numButtons.length; i++) {
    numButtons[i].display();
    numButtons[i].hover(mouseX-40, mouseY-20, mr);
  }
  md = mr;
  for (int i = 0; i < opButtons.length; i++) {
    opButtons[i].display();
    opButtons[i].hover(mouseX-40, mouseY-20,mr);
  }
  calculate();
  updisp();
  calculateDisp();
  mr = false;
}

void mouseReleased() {
  mr = true;
}

void updisp() {
  stroke(255,151,80);
  fill(255,151,80);
  text(kpoutf,600,106);
  line(620,100,880,100);
  disp0 = kpin0;
disp1 = kpin1;

  //segment(590,20,int(kpout));
  segments(620,20,disp0.charAt(0));
  segments(650,20,disp0.charAt(1));
  segments(680,20,disp0.charAt(2));
  segments(710,20,disp0.charAt(3));
  segments(740,20,disp0.charAt(4));
  segments(770,20,disp0.charAt(5));
  segments(800,20,disp0.charAt(6));
  segments(830,20,disp0.charAt(7));
  segments(860,20,disp0.charAt(8));
  
  segments(620,60,disp1.charAt(0));
  segments(650,60,disp1.charAt(1));
  segments(680,60,disp1.charAt(2));
  segments(710,60,disp1.charAt(3));
  segments(740,60,disp1.charAt(4));
  segments(770,60,disp1.charAt(5));
  segments(800,60,disp1.charAt(6));
  segments(830,60,disp1.charAt(7));
  segments(860,60,disp1.charAt(8));
  
  segments(620,110,disp2.charAt(0));
  segments(650,110,disp2.charAt(1));
  segments(680,110,disp2.charAt(2));
  segments(710,110,disp2.charAt(3));
  segments(740,110,disp2.charAt(4));
  segments(770,110,disp2.charAt(5));
  segments(800,110,disp2.charAt(6));
  segments(830,110,disp2.charAt(7));
  segments(860,110,disp2.charAt(8));
  
  segments(620,180,mem[memnum].charAt(0));
  segments(650,180,mem[memnum].charAt(1));
  segments(680,180,mem[memnum].charAt(2));
  segments(710,180,mem[memnum].charAt(3));
  segments(740,180,mem[memnum].charAt(4));
  segments(770,180,mem[memnum].charAt(5));
  segments(800,180,mem[memnum].charAt(6));
  segments(830,180,mem[memnum].charAt(7));
  segments(860,180,mem[memnum].charAt(8));
  fill(0);
  stroke(0);
}

void calculate() {
  for(int i = 0; i < numButtons.length; i++) {
 kprs = numButtons[i].out;
 if (kprs != "NaN"){
 kpout = kpout + kprs;
 kpout = kpout.replaceFirst(str(kpout.charAt(0)),"");
 println (kpout);
 }
  }
 for(int i = 0; i < opButtons.length; i++) {
 kprs = opButtons[i].out;
 if (kprs != "NaN"){
 kpoutf = kprs;
 println(kpoutf);
 }
 }
}

void calculateDisp() {
  neg0 = !kpin0.contains("-");
neg1 = !kpout.contains("-");

switch(kpoutf) {
case "ADD": // NEXTFUNCT --------------------------
lastfunct = kpoutf;
if(!firstcall) {
kpin0 = kpout;
kpout = "000000000";
firstcall = true;
}
kpin1 = kpout;
disp2 = "";
println(neg0);
println(neg1);
mathq = str( int(kpin0) + int(kpin1) );
for(int i = 9 - mathq.length(); i>0; i--) {
disp2 = disp2 + "0";
}
println(kpin0);
disp2 = disp2 + int(mathq);
println(disp2);
break;
case "SUB": // NEXTFUNCT --------------------------
lastfunct = kpoutf;
if(!firstcall) {
kpin0 = kpout;
kpout = "000000000";
firstcall = true;
}
kpin1 = kpout;
disp2 = "";
mathq = str(int(kpin0) - int(kpout) );
for(int i = 9 - mathq.length(); i>0; i--) {
disp2 = disp2 + "0";
}
disp2 = disp2 + int(mathq);
println(disp2);
break;
case "MULT": // NEXTFUNCT --------------------------
lastfunct = kpoutf;
if(!firstcall) {
kpin0 = kpout;
kpout = "000000000";
firstcall = true;
}
kpin1 = kpout;
disp2 = "";
mathq = str(int(kpin0) * int(kpout));
for(int i = 9 - mathq.length(); i>0; i--) {
disp2 = disp2 + "0";
}
disp2 = disp2 + int(mathq);
println(disp2);
break;
case "DIV": // NEXTFUNCT --------------------------
lastfunct = kpoutf;
if(!firstcall) {
kpin0 = kpout;
kpout = "000000000";
firstcall = true;
}
kpin1 = kpout;
disp2 = "";
if( int(kpin0) != 0 && int(kpin1) != 0) {
mathq = str(int(kpin0) / int(kpout));
} else {mathq = "0"; }
for(int i = 9 - mathq.length(); i>0; i--) {
disp2 = disp2 + "0";
}
disp2 = disp2 + int(mathq);
println(disp2);
break;
case "MOD": // NEXTFUNCT --------------------------
lastfunct = kpoutf;
if(!firstcall) {
kpin0 = kpout;
kpout = "000000000";
firstcall = true;
}
kpin1 = kpout;
disp2 = "";
if(int(kpin0) != 0 && int(kpin1) != 0) {
mathq = str(int(kpout) % int(kpin0) );
} else { mathq = "0";}
for(int i = 9 - mathq.length(); i>0; i--) {
disp2 = disp2 + "0";
}
disp2 = disp2 + int(mathq);
println(disp2);
break;
case "FLIP": // NEXTFUNCT --------------------------
 kpout = kpin0;
qswitch = kpin0;
kpin0 = kpin1;
kpin1 = qswitch;
negflip = neg0;
neg0 = neg1;
neg1 = negflip;
kpoutf = lastfunct;
break;
case "%": // NEXTFUNCT --------------------------
lastfunct = kpoutf;
if(!firstcall) {
kpin0 = kpout;
kpout = "000000000";
firstcall = true;
}
kpin1 = kpout;
disp2 = "";
mathq = str(100 / (int(kpin0) + int(kpout)) );
for(int i = 9 - mathq.length(); i>0; i--) {
disp2 = disp2 + "0";
}
disp2 = disp2 + int(mathq);
println(disp2);
break;
case "+/-": // NEXTFUNCT --------------------------
qswitch = "-";
for(int i = 1; i < 9; i++) {
qswitch = qswitch + kpout.charAt(i);

}
kpout = qswitch;
kpoutf = lastfunct;
break;
case "MIN": // NEXTFUNCT --------------------------
min = int(kpout);
kpoutf = lastfunct;
break;
case "MAX": // NEXTFUNCT --------------------------
max = int(kpout);
kpoutf = lastfunct;
break;
case "Σ": // NEXTFUNCT --------------------------
qswitch = "0";
disp2 = "";
hold = 0;
for(int i = min; i <= max; i++) {
  hold = hold + int(kpout);
}
mathq = str(hold);

for(int i = 9 - mathq.length(); i>0; i--) {
disp2 = disp2 + "0";
}
disp2 = disp2 + int(mathq);
println(disp2);
break;
case "MEM#":
memnum = int(kpout) % 1000;
kpoutf = " ";
firstcall = false;
break;
case "STO":
mem[memnum] = disp2;
kpoutf = lastfunct;
break;
case "RCL":
kpout = mem[memnum];
kpoutf = lastfunct;
break;
case "EQ0": // NEXTFUNCT --------------------------
kpin0 = disp2;
firstcall = true;
kpoutf = lastfunct;
break;
case "CLR": // NEXTFUNCT --------------------------
if(kpout != "000000000") {
kpout = "000000000";
} else {disp0 = "000000000"; disp1 = "000000000"; disp2 = "000000000"; kpin0 = "000000000"; lastfunct = " ";}
kpoutf = lastfunct;
//firstcall = false;
break;
case " ": // NEXTFUNCT --------------------------
kpin1 = kpout;
disp2 = kpin1;
break;
}
}


//_________--------------_______________-_____---------------_____-_----_____-____--________






void segments(int x, int y, char num) {
  switch (num) {
  case '0':
  segment(x,y,0);
  segment(x,y,2);
  segment(x,y,3);
  segment(x,y,4);
  segment(x,y,5);
  segment(x,y,6);
    break;
    case '1':
  segment(x,y,5);
  segment(x,y,6);
    break;
    case '2':
    segment(x,y,0);
    segment(x,y,1);
    segment(x,y,2);
    segment(x,y,4);
    segment(x,y,5);
    break;
    case '3':
    segment(x,y,0);
    segment(x,y,1);
    segment(x,y,2);
    segment(x,y,5);
    segment(x,y,6);
    break;
    case '4':
  segment(x,y,3);
  segment(x,y,1);
  segment(x,y,5);
  segment(x,y,6);
    break;
    case '5':
  segment(x,y,0);
  segment(x,y,1);
  segment(x,y,2);
  segment(x,y,3);
  segment(x,y,6);
    break;
    case '6':
  segment(x,y,0);
  segment(x,y,1);
  segment(x,y,2);
  segment(x,y,3);
  segment(x,y,4);
  segment(x,y,6);
    break;
    case '7':
  segment(x,y,0);
  segment(x,y,5);
  segment(x,y,6);
    break;
    case '8':
  segment(x,y,0);
  segment(x,y,1);
  segment(x,y,2);
  segment(x,y,3);
  segment(x,y,4);
  segment(x,y,5);
  segment(x,y,6);
    break;
    case '9':
  segment(x,y,0);
  segment(x,y,1);
  segment(x,y,2);
  segment(x,y,3);
  segment(x,y,5);
  segment(x,y,6);
    break;
    case '-':
  segment(x,y,1);
    break;
  }
}

void segment(int x, int y,int num) {
  switch (num) {
  case 0:
  fill(0);
  line(x,y,x+20,y);
    break;
  case 1:
  fill(0);
  line(x,y+15,x+20,y+15);
    break;
  case 2:
  fill(0);
  line(x,y+30,x+20,y+30);
    break;
  case 3:
  fill(0);
  line(x,y,x,y+15);
    break;
  case 4:
  fill(0);
  line(x,y+15,x,y+30);
    break;
  case 5:
  fill(0);
  line(x+20,y,x+20,y+15);
    break;
  case 6:
  fill(0);
  line(x+20,y+15,x+20,y+30);
    break;
  case 7:
  fill(0);
  strokeWeight(2);
  point(x+24,y+30);
  strokeWeight(1);
    break;
  }
}
