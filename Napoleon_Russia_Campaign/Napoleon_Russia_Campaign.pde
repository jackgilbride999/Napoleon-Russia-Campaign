DataType1[] dataGroup1;
DataType2[] dataGroup2;
DataType3[] dataGroup3;
PFont font;
PImage image;
int maxTemp, minTemp;
float minTempY, maxTempY, minTempX, maxTempX;

void settings() {
  final int width = displayWidth/6*5;
  final int height = displayHeight/6*5;
  minTempY = height - height/15;
  maxTempY = height - height/4;
  minTempX = width/5;
  maxTempX = width - width/20;

  size(width, height);
}

void setup() {

  font = createFont("ProcessingSansPro-Semibold-15.vlw", 14);
  image = loadImage("russia_1812.jpg");

  Table table1, table2, table3;
  table1 = loadTable("../data/minard-data-1.csv", "header");
  table2 = loadTable("../data/minard-data-2.csv", "header");
  table3 = loadTable("../data/minard-data-3.csv", "header");

  int N;
  N = table1.getRowCount();
  dataGroup1 = new DataType1[N];
  for (int i=0; i<N; i++) {
    TableRow row = table1.getRow(i);
    dataGroup1[i] = new DataType1(row.getFloat("LONC"), row.getFloat("LATC"), row.getString("CITY"));
  }

  N = table2.getRowCount();
  dataGroup2 = new DataType2[N];
  for (int i=0; i<N; i++) {
    TableRow row = table2.getRow(i);
    dataGroup2[i] = new DataType2(row.getFloat("LONT"), row.getInt("TEMP"), row.getInt("DAYS"), row.getString("MON"), row.getInt("DAY"));
    if (row.getInt("TEMP") < minTemp) {
      minTemp = row.getInt("TEMP");
    }
    if (row.getInt("TEMP") > maxTemp) {
      maxTemp = row.getInt("TEMP");
    }
  }


  N = table3.getRowCount();
  dataGroup3 = new DataType3[N];
  for (int i=0; i<N; i++) {
    TableRow row = table3.getRow(i);
    dataGroup3[i] = new DataType3(row.getFloat("LONP"), row.getFloat("LATP"), row.getInt("SURV"), row.getString("DIR").charAt(0), row.getInt("DIV"));
  }
}

void draw() {
  fill(255, 255, 255);
  rect(0, 0, width, height);
  // image(image, 0,0);
  float scaleX = (width/18);
  float scaleY = (width/12);

  float translateX = -21;
  float translateY = -51;
  drawDataGroup2(scaleX, scaleY, translateX, translateY);
  drawDataGroup3(scaleX, scaleY, translateX, translateY);
  drawDataGroup1(scaleX, scaleY, translateX, translateY);
}

void drawDataGroup3(float scaleX, float scaleY, float translateX, float translateY) {
 
  for (int i=0; i<dataGroup3.length-1; i++) {
    strokeWeight(0.0002 * dataGroup3[i].surv);
    if (dataGroup3[i].dir == 'A') {
      stroke(255, 100, 0);
    } else {
      stroke(150, 150, 150);
    }
    if (dataGroup3[i].div == dataGroup3[i+1].div) {
      float x1 = (dataGroup3[i].lonp + translateX) * (scaleX);
      float y1 = (dataGroup3[i].latp + translateY) * (scaleY);
      y1 = -(y1 - height);
      float x2 = (dataGroup3[i+1].lonp + translateX) * (scaleX);
      float y2 = (dataGroup3[i+1].latp + translateY) * (scaleY);
      y2 = -(y2 - height);
      line(x1,y1,x2,y2);
    }
  }
}

void drawDataGroup1(float scaleX, float scaleY, float translateX, float translateY) {
  // we can't flip the y axis and apply the general transformations like in drawDataGroup3(), as this messes up the text (flips it and scales it)
  // therefore we manually calculate the x and y of the points using the same mathematics of these transformations
  for (int j=0; j<dataGroup1.length; j++) {
    float x = (dataGroup1[j].lonc + translateX) * (scaleX);
    float y = (dataGroup1[j].latc + translateY) * (scaleY);
    y = -(y - height);

    fill(0, 0, 0);
    circle(x, y, 10);
    textFont(font);
    textAlign(CENTER);
    text(dataGroup1[j].city, x, y + 20);
  }
}

void drawDataGroup2(float scaleX, float scaleY, float translateX, float translateY) {
  stroke(0, 0, 0);
  fill(0, 0, 0);
  strokeWeight(1);
  float tempRange = maxTemp - minTemp;

  stroke(220, 220, 220);
  for (int i = maxTemp - 5; i < abs(minTemp) + 10; i+=5) {
    float y = maxTempY + (i/tempRange*((minTempY-maxTempY)));
    line(minTempX, y, maxTempX, y);
    text((-i) + "°C", maxTempX + width / 60, y);
  }
  stroke(0, 0, 0);

  float x0 = (dataGroup2[0].lont + translateX) * (scaleX);
  float y0 = maxTempY + (abs(dataGroup2[0].temp)/tempRange*((minTempY-maxTempY)));
  float textY = maxTempY + (abs(dataGroup2[0].temp - 5)/tempRange*((minTempY-maxTempY)));
  circle(x0, y0, 5);
  textLeading(20);
  text(dataGroup2[0].temp + "\n" + dataGroup2[0].day + " " + dataGroup2[0].mon, x0, textY);


  for (int k=1; k<dataGroup2.length; k++) {
    x0 = (dataGroup2[k-1].lont + translateX) * (scaleX);
    float x1 = (dataGroup2[k].lont + translateX) * (scaleX);

    // this calculation works because the maxTemp is 0
    y0 = maxTempY + (abs(dataGroup2[k-1].temp)/tempRange*((minTempY-maxTempY)));
    float y1 = maxTempY + (abs(dataGroup2[k].temp)/tempRange*((minTempY-maxTempY)));


    strokeWeight(5);
    circle(x1, y1, 5);
    line(x0, y0, x1, y1);

    textFont(font);
    textAlign(CENTER);
    textY = maxTempY + (abs(dataGroup2[k].temp - 5)/tempRange*((minTempY-maxTempY)));
    textLeading(20);
    text(dataGroup2[k].temp + "°" + (boolean(dataGroup2[k].day) ? "\n" + dataGroup2[k].day + " " + dataGroup2[k].mon : ""), x1, textY);
  }
}

class DataType1 {
  float lonc;
  float latc;
  String city;

  DataType1(float lonc, float latc, String city) {
    this.lonc = lonc;
    this.latc = latc;
    this.city = city;
  }
}

class DataType2 {
  float lont;
  int temp;
  int days;
  String mon;
  int day;

  DataType2(float lont, int temp, int days, String mon, int day) {
    this.lont = lont;
    this.temp = temp;
    this.days = days;
    this.mon = mon;
    this.day = day;
  }
}

class DataType3 {
  float lonp;
  float latp;
  int surv;
  char dir;
  int div;

  DataType3(float lonp, float latp, int surv, char dir, int div) {
    this.lonp = lonp;
    this.latp = latp;
    this.surv = surv;
    this.dir = dir;
    this.div = div;
  }
}
