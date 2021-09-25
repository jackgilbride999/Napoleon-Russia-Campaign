DataType1[] dataGroup1;
DataType2[] dataGroup2;
DataType3[] dataGroup3;
PFont font;
PImage image;

void settings(){
  final int width = displayWidth/6*5;
  final int height = displayHeight/6*5;
  size(width, height);
}

void setup(){

  font = createFont("ProcessingSansPro-Semibold-15.vlw", 14);
  image = loadImage("russia_1812.jpg");
  
  Table table1, table2, table3;
  table1 = loadTable("../data/minard-data-1.csv", "header");
  table2 = loadTable("../data/minard-data-2.csv", "header");
  table3 = loadTable("../data/minard-data-3.csv", "header");

  int N;
  N = table1.getRowCount();
  dataGroup1 = new DataType1[N];
  for(int i=0; i<N; i++) {
    TableRow row = table1.getRow(i);
    dataGroup1[i] = new DataType1(row.getFloat("LONC"), row.getFloat("LATC"), row.getString("CITY"));
  }
  
  N = table2.getRowCount();
  dataGroup2 = new DataType2[N];
  for(int i=0; i<N; i++) {
    TableRow row = table2.getRow(i);
    dataGroup2[i] = new DataType2(row.getFloat("LONT"), row.getInt("TEMP"), row.getInt("DAYS"), row.getString("MON"), row.getInt("DAY"));
  }
  
    
  N = table3.getRowCount();
  dataGroup3 = new DataType3[N];
  for(int i=0; i<N; i++) {
    TableRow row = table3.getRow(i);
    dataGroup3[i] = new DataType3(row.getFloat("LONP"), row.getFloat("LATP"), row.getInt("SURV"), row.getString("DIR").charAt(0), row.getInt("DIV"));
  }
}

void draw(){
  fill(255,255,255);
  rect(0,0,width,height);
 // image(image, 0,0);
  float scale = (width/20);
  float translateX = -20;
  float translateY = -50;
  drawDataGroup2(scale, translateX, translateY);
  drawDataGroup3(scale, translateX, translateY);
  drawDataGroup1(scale, translateX, translateY);
}

void drawDataGroup3(float scale, float translateX, float translateY){
  pushMatrix();
  // flip the y axis so we can work with the lattitude, which increases upwards, while the y axis traditionally increases downwards 
  scale(1, -1);
  translate(0, -height);
  
  pushMatrix();
  // scale and translate the points to better fit on the screen
  scale(scale);
  translate(translateX, translateY);
  
  
  for(int i=0; i<dataGroup3.length-1; i++){
    strokeWeight(0.000002 * dataGroup3[i].surv);
    if(dataGroup3[i].dir == 'A'){
       stroke(255, 0, 0);
    } else {
       stroke(0, 255, 0); 
    }
    line(dataGroup3[i].lonp, dataGroup3[i].latp, dataGroup3[i+1].lonp, dataGroup3[i+1].latp);
  }
  
  popMatrix();
  popMatrix();  
}

void drawDataGroup1(float scale, float translateX, float translateY){
  // we can't flip the y axis and apply the general transformations like in drawDataGroup3(), as this messes up the text (flips it and scales it)
  // therefore we manually calculate the x and y of the points using the same mathematics of these transformations
  for(int j=0; j<dataGroup1.length; j++){
    float x = (dataGroup1[j].lonc + translateX) * (scale);
    float y = (dataGroup1[j].latc + translateY) * (scale);
    y = -(y - height);
    
    fill(0, 0, 0);
    circle(x, y, 10);
    textFont(font);
    textAlign(CENTER);
    text(dataGroup1[j].city, x, y + 15); 
  }  
}

void drawDataGroup2(float scale, float translateX, float translateY){
     stroke(0,0,0);
      fill(0, 0, 0);
     strokeWeight(1);
    for(int k=0; k<dataGroup2.length; k++){
      float x = (dataGroup2[k].lont + translateX) * (scale);
      line(x, 0, x, height);
      textFont(font);
      textAlign(CENTER);
      text(dataGroup2[k].temp + ", " + dataGroup2[k].day + " " + dataGroup2[k].mon, x, height - 200);
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
 
 DataType2(float lont, int temp, int days, String mon, int day){
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
  
  DataType3(float lonp, float latp, int surv, char dir, int div){
     this.lonp = lonp;
     this.latp = latp;
     this.surv = surv;
     this.dir = dir;
     this.div = div;
  }
}
