/*******************************************************
INTERACTIVE VISUAL SOFTWARE BY SEBASTIAN GONZALEZ DIXON
COMMITIONED BY EVA VON SCHWEINITZ
FOR HER WORK "THE SPACE BETWEEN LETTERS"
PRODUCES WITH THE HELP OF HARVESTWORKS RECIDENCE
NEW YORK, 2018 
*****************************************************/

// Version 0.5 / April-10-2018

ArrayList<FlyingLine> layers;

int layersNumber = 10;
int activeLayer = 0;

int bgColor = 0;

int[] lineMaxLenght = {50, 100, 100, 100, 300, 300, 300, 600, 700, 800}; /// lenght for each one of the lines

color[] colors = {#158788, #d34c26, #e2a63d, #cdfee9, #fec0b4, #fd9d27, #fafeaf, #60c5bf, #d0dc4d, #ec4958}; // color for each line

String renderMode = "lines";

String guiText01 = "1";

PFont guiFont12;
PFont guiFont24;

boolean drawGui = true;

void setup(){
  
  noCursor();
  //size(1440, 900, P2D); Full Screen
  size(960, 640, P2D);
  background(bgColor);
  //colorMode(HSB, 100);
  
  guiFont12 = createFont("OCRAStd-24.vlw", 12);
  guiFont24 = createFont("OCRAStd-24.vlw", 24);
  textFont(guiFont24);
  
  layers = new ArrayList<FlyingLine>();
  
  for (int i = 0; i < layersNumber; i++) {
    
    //color newColor = color((i/layersNumber)*100, 80, 100);
    
    FlyingLine fl = new FlyingLine(colors[i], lineMaxLenght[i], renderMode);
    layers.add(fl);
 
   }
  
}

void draw(){
  

  background(bgColor*255);
  
  if(drawGui){
    fill(colors[activeLayer]);
    rect(5, 5, 30, 30);
    fill(0);
    textFont(guiFont24);
    
    
    int tempActiveLayer = activeLayer+1;
    if(activeLayer == 9){
      tempActiveLayer = 0;
    }
    text(tempActiveLayer, 12, 30);
    
    for(int i = 0; i < layers.size(); i++){
      fill(colors[i]);
      textFont(guiFont12);
      if(i != 9){
        text(i+1, 10, 50+15*i);
      }
      else{
        text(0, 10, 50+15*i);
      }
    }
  }
  
  for(FlyingLine fl : layers){

    fl.drawLine();
  }
  
  FlyingLine fl = layers.get(activeLayer);
  fl.updateLine();
  
   fill(layers.get(activeLayer).lineColor);
   noStroke();
   ellipse(mouseX, mouseY, 5,5);
  
  //println("activeLayer " + activeLayer);
  
}

void mouseReleased(){
  
  FlyingLine fl = layers.get(activeLayer);
  if(fl.particleIndex != 0){
    fl.flyLine.get(fl.particleIndex - 1).isSpace = true;
  }
  else{
    fl.flyLine.get(fl.lineMax-1).isSpace = true;
  }
  //activeLayer++;
  //activeLayer = activeLayer% layersNumber;
  
  
}


void keyPressed(){
  
  ////// LAYER SELECT
  
  if(key == '1'){
    activeLayer = 0;
  }
  if(key == '2'){
    activeLayer = 1;
  }
  if(key == '3'){
    activeLayer = 2;
  }
  if(key == '4'){
    activeLayer = 3;
  }
  if(key == '5'){
    activeLayer = 4;
  }
  if(key == '6'){
    activeLayer = 5;
  }
  if(key == '7'){
    activeLayer = 6;
  }
  if(key == '8'){
    activeLayer = 7;
  }
  if(key == '9'){
    activeLayer = 8;
  }
  if(key == '0'){
    activeLayer = 9;
  }
  
  
  FlyingLine fl = layers.get(activeLayer);
  
  
  ///// BEHAVIORS SELECT
  
  if(key == 'q'){
    for(Particle p : fl.flyLine){
       p.setBehavior(1, false);
    }
  }
  if(key == 'w'){
    for(Particle p : fl.flyLine){
       p.setBehavior(2, false);
    }
  }
  if(key == 'e'){
    for(Particle p : fl.flyLine){
       p.setBehavior(3, false);
    }
  }
  if(key == 'r'){
    for(Particle p : fl.flyLine){
       p.setBehavior(4, false);
    }
  }
  if(key == 'a'){
    for(Particle p : fl.flyLine){
       p.setBehavior(5, false);
    }
  }
  if(key == 's'){
    for(Particle p : fl.flyLine){
       p.setBehavior(6, false);
    }
  }
  
  ///// BEHAVIORS MULTIPLE SELECT
  
  if(key == 'Q'){
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(1, false);
      }
    }
  }
  if(key == 'W'){
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(2, false);
      }
    }
  }
  if(key == 'E'){
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(3, false);
      }
    }
  }
  if(key == 'R'){
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(4, false);
      }
    }
  }
  if(key == 'A'){
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(5, false);
      }
    }
  }
  if(key == 'S'){
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(6, false);
      }
    }
  }
  
  
  ////// RENDERING MODES
  
  if(key == 'p'){
    renderMode = "particles";
    fl.lineMode = renderMode;
  }
  if(key == 'l'){
    renderMode = "lines";
    fl.lineMode = renderMode;
  }
  if(key == 'k'){
    renderMode = "fatLines";
    fl.lineMode = renderMode;
  }
  if(key == 'm'){
    renderMode = "megaLines";
    fl.lineMode = renderMode;
  }
  if(key == 'n'){
    renderMode = "letters";
    fl.lineMode = renderMode;
  }
  if(key == 'o'){
    renderMode = "circles";
    fl.lineMode = renderMode;
  }
  
  ////// RENDERING MULTIPLE MODES
  
  if(key == 'P'){
    for(FlyingLine flyline : layers){
      renderMode = "particles";
      flyline.lineMode = renderMode;
    }
  }
  if(key == 'L'){
    for(FlyingLine flyline : layers){
      renderMode = "lines";
      flyline.lineMode = renderMode;
    }
  }
  if(key == 'K'){
    for(FlyingLine flyline : layers){
      renderMode = "fatLines";
      flyline.lineMode = renderMode;
    }
  }
  if(key == 'M'){
    for(FlyingLine flyline : layers){
      renderMode = "megaLines";
      flyline.lineMode = renderMode;
    }
  }
  if(key == 'N'){
    for(FlyingLine flyline : layers){
      renderMode = "letters";
      flyline.lineMode = renderMode;
    }
  }
  if(key == 'O'){
    for(FlyingLine flyline : layers){
      renderMode = "circles";
      flyline.lineMode = renderMode;
    }
  }
  
  ////// GLOBAL ACTIONS
  
  if(key == 'b'){
    bgColor++;
    bgColor = bgColor%2;
  }
  
  if(key == 'x'){
    layers.get(activeLayer).deleteLine();   
  }
  
  if(key == 'X'){
    for(FlyingLine flyline : layers){
      flyline.deleteLine();
    }
  }
  
  if(key == 'g'){
    
    drawGui = !drawGui;
  }
}
