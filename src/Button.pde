class Button {
  int x, y, wdth, ht, dnum;
  String num, out;
  color stat, hov, prs;
  boolean hover, mr;

  Button(int x, int y, int wdth, int ht, String num, color stat) {
    this.x = x;
    this.y = y;
    this.wdth = wdth;
    this.ht = ht;
    this.num = num;
    this.stat = stat;
    hov = color(255);
    prs = color(100);
  }

  void display() {
    switch (dnum) {
    case 0:
      fill(stat);
      break;
    case 1:
      fill(hov);
      break;
    case 2:
      fill(prs);
      break;
    }
    rectMode(CENTER);
    rect(x+40, y+20, wdth, ht);
    fill(0);
    textAlign(CENTER);
    text(num,x+40, y+20);
  }

  void hover(int mx, int my, boolean mr) {
    //this.mr = mr;
    dnum = int(mx > x-wdth/2 && mx < x+wdth/2 && my > y-ht/2 && my < y+ht/2);
    out = "NaN";
    if (mr == true && dnum == 1) {out = num;}
  }
}
