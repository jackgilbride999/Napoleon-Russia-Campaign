DataType1[] dataGroup1;
DataType2[] dataGroup2;
DataType3[] dataGroup3;

void settings(){
  final int width = displayWidth/4*3;
  final int height = displayHeight/4*3;
  size(width, height);
}

void setup(){

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
  pushMatrix();
  // flip the y axis
  scale(1, -1);
  translate(0, -height);
  
  pushMatrix();
  scale(width/20);
  translate(-20, -50);
  for(int i=0; i<dataGroup3.length-1; i++){
    strokeWeight(0.000001 * dataGroup3[i].surv);
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
