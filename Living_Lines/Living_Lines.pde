/*******************************************************
INTERACTIVE VISUAL SOFTWARE BY SEBASTIAN GONZALEZ DIXON
COMMISSIONED BY EVA VON SCHWEINITZ
FOR HER WORK "THE SPACE BETWEEN THE LETTERS"
PRODUCED WITH THE HELP OF HARVESTWORKS RESIDENCE
NEW YORK, 2018  
*****************************************************/

// Version 0.6

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

boolean playMode = false;

String[] characters = {"1wp", "1ep", "5qp", "8ql", "3el", "6ql"}; 

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
    String playModeName = "";
    if(playMode) playModeName = "press '=' to change keyboard interaface: Characters";
    else playModeName = "Press '=' to change keyboard interaface: Explorer ";
    text(playModeName, 50, 15);
    text("Press 'g' to hide/show GUI", 50, 30);
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

void createCharacter(String _character){
  
  setCharacterOption(_character.charAt(0));
  setCharacterOption(_character.charAt(1));
  setCharacterOption(_character.charAt(2));

  
}

void keyPressed(){
  
  char input = key;
  
  if (key == CODED) {
    if (keyCode == RIGHT) {
      activeLayer++;
      activeLayer=activeLayer%10;
    }
    if (keyCode == LEFT) {
      activeLayer--;
      if(activeLayer<0) activeLayer =9;
      
    }
  }
  else{ 
    if(input == '='){
      playMode = !playMode;
    }
    ////// GLOBAL ACTIONS
  
    if(input == 'b'){
      bgColor++;
      bgColor = bgColor%2;
    }
    
    if(input == 'x'){
      layers.get(activeLayer).deleteLine();   
    }
    
    if(input == 'X'){
      for(FlyingLine flyline : layers){
        flyline.deleteLine();
      }
    }
    
    if(input == 'g'){
     
      drawGui = !drawGui;
    }
  
    if(playMode){
      setCharacter(input);
    }
    else{
      setCharacterOption(input);
    }
  }
  
}

void setCharacter(char _input){
  
  if(_input == '1'){
    createCharacter(characters[0]);
  }
  if(_input == '2'){
    createCharacter(characters[1]);
  }
  if(_input == '3'){
    createCharacter(characters[2]);
  }
  if(_input == '4'){
    createCharacter(characters[3]);
  }
  if(_input == '5'){
    createCharacter(characters[4]);
  }
  if(_input == '6'){
    createCharacter(characters[5]);
  }
  
}
  
void setCharacterOption(char _input){
  
  ////// LAYER SELECT
  
  if(_input == '1'){
    activeLayer = 0;
  }
  if(_input == '2'){
    activeLayer = 1;
  }
  if(_input == '3'){
    activeLayer = 2;
  }
  if(_input == '4'){
    activeLayer = 3;
  }
  if(_input == '5'){
    activeLayer = 4;
  }
  if(_input == '6'){
    activeLayer = 5;
  }
  if(_input == '7'){
    activeLayer = 6;
  }
  if(_input == '8'){
    activeLayer = 7;
  }
  if(_input == '9'){
    activeLayer = 8;
  }
  if(_input == '0'){
    activeLayer = 9;
  }
  
  
  FlyingLine fl = layers.get(activeLayer);
  
  
  ///// BEHAVIORS SELECT
  
  if(_input == 'q'){
    for(Particle p : fl.flyLine){
       p.setBehavior(1, false);
    }
  }
  if(_input == 'w'){
    for(Particle p : fl.flyLine){
       p.setBehavior(2, false);
    }
  }
  if(_input == 'e'){
    for(Particle p : fl.flyLine){
       p.setBehavior(3, false);
    }
  }
  if(_input == 'r'){
    for(Particle p : fl.flyLine){
       p.setBehavior(4, false);
    }
  }
  if(_input == 'a'){
    for(Particle p : fl.flyLine){
       p.setBehavior(5, false);
    }
  }
  if(_input == 's'){
    for(Particle p : fl.flyLine){
       p.setBehavior(6, false);
    }
  }
  
  ///// BEHAVIORS MULTIPLE SELECT
  
  if(_input == 'Q'){
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(1, false);
      }
    }
  }
  if(_input == 'W'){
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(2, false);
      }
    }
  }
  if(_input == 'E'){
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(3, false);
      }
    }
  }
  if(_input == 'R'){
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(4, false);
      }
    }
  }
  if(_input == 'A'){
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(5, false);
      }
    }
  }
  if(_input == 'S'){
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(6, false);
      }
    }
  }
  
  
  ////// RENDERING MODES
  
  if(_input == 'p'){
    renderMode = "particles";
    fl.lineMode = renderMode;
  }
  if(_input == 'l'){
    renderMode = "lines";
    fl.lineMode = renderMode;
  }
  if(_input == 'k'){
    renderMode = "fatLines";
    fl.lineMode = renderMode;
  }
  if(_input == 'm'){
    renderMode = "megaLines";
    fl.lineMode = renderMode;
  }
  if(_input == 'n'){
    renderMode = "letters";
    fl.lineMode = renderMode;
  }
  if(_input == 'o'){
    renderMode = "circles";
    fl.lineMode = renderMode;
  }
  
  ////// RENDERING MULTIPLE MODES
  
  if(_input == 'P'){
    for(FlyingLine flyline : layers){
      renderMode = "particles";
      flyline.lineMode = renderMode;
    }
  }
  if(_input == 'L'){
    for(FlyingLine flyline : layers){
      renderMode = "lines";
      flyline.lineMode = renderMode;
    }
  }
  if(_input == 'K'){
    for(FlyingLine flyline : layers){
      renderMode = "fatLines";
      flyline.lineMode = renderMode;
    }
  }
  if(_input == 'M'){
    for(FlyingLine flyline : layers){
      renderMode = "megaLines";
      flyline.lineMode = renderMode;
    }
  }
  if(_input == 'N'){
    for(FlyingLine flyline : layers){
      renderMode = "letters";
      flyline.lineMode = renderMode;
    }
  }
  if(_input == 'O'){
    for(FlyingLine flyline : layers){
      renderMode = "circles";
      flyline.lineMode = renderMode;
    }
  }
  
  
}