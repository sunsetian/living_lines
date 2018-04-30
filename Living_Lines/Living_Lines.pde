/*******************************************************
INTERACTIVE VISUAL SOFTWARE BY SEBASTIAN GONZALEZ DIXON
COMMISSIONED BY EVA VON SCHWEINITZ
FOR HER WORK "THE SPACE BETWEEN THE LETTERS"
PRODUCED WITH THE HELP OF HARVESTWORKS RESIDENCE
MIT LICENCE
NEW YORK, 2018  
*****************************************************/

// Version 0.72

ArrayList<FlyingLine> layers;

int layersNumber = 10;
int activeLayer = 0;

int bgColor = 0;

int[] lineMaxLength = {50, 200, 200, 200, 200, 200, 300, 500, 600, 900}; /// lenght for each one of the lines

color[] colors = {#158788,  #d34c26, #e2a63d, #cdfee9, #fec0b4, #fd9d27, #fafeaf, #d0dc4d, #ec4958, #158788}; // color for each line

String renderMode = "lines";

String guiText01 = "1";

PFont guiFont12;
PFont guiFont24;

int drawGui = 1;

boolean holdMode = false;
boolean pressStart = false;
PVector pressStartPos = new PVector(0, 0);

boolean playMode = false;

boolean cursorOn = true;

int scene = 1;
char activeBehavior = 'q';
char activeRenderMode = 'l';

int activeCharacter = 1;

int resetTrigger = 0;
boolean resetafterZActivated = false;
int resetDelay = 200;

String[] charactersScene1 = {"1wp", "1ep", "1el", "0ql", "1qk", "1wo", "5qp", "9ep", "4ql", "3ql"};  ////  a  // IN PERFORMANCE MODE
String[] charactersScene2 = {"3lq", "7qm", "8ql", "7ql", "6ql", "2pw", "3pw", "4pw", "2el", "2pw"};  ////  s
String[] charactersScene3 = {"1el", "0ql", "1ak", "1eo", "1wp", "1ep", "5qp", "6am", "6ql", "3ql"};  ////  d
String[] charactersScene4 = {"0ql", "1ak", "1eo", "1wp", "1ep", "1el", "5qp", "6am", "6ql", "4ql"};  ////  f
String[] charactersScene5 = {"2ql", "3ql", "4ql", "5ql", "6ql", "2pw", "3pw", "4pw", "5pw", "6pw"};  ////  j

void setup(){
  
  noCursor();
  //size(1440, 900, P2D); Full Screen
  size(1024, 750, P2D);
  background(bgColor);
  //colorMode(HSB, 100);
  
  guiFont12 = createFont("OCRAStd-24.vlw", 12);
  guiFont24 = createFont("OCRAStd-24.vlw", 24);
  textFont(guiFont24);
  
  layers = new ArrayList<FlyingLine>();
  
  for (int i = 0; i < layersNumber; i++) {
    
    //color newColor = color((i/layersNumber)*100, 80, 100);
    
    FlyingLine fl = new FlyingLine(colors[i], lineMaxLength[i], renderMode);
    layers.add(fl);
 
   }
  
}

void draw(){
  
  background(bgColor*255);
  resetAfterZ();
  
  if(drawGui == 2){
    fill(colors[activeLayer]);
    rect(5, 5, 60, 30);
    fill(0);
    textFont(guiFont24);
       
    int tempActiveLayer = activeLayer+1;
    if(activeLayer == 9){
      tempActiveLayer = 0;
    }
    
    String activeMode = "" + tempActiveLayer + "" + activeBehavior + "" + activeRenderMode;
    
    text(activeMode, 12, 30);
    //text(activeBehavior, 30, 30);
    //text(activeRenderMode, 46, 30);
    
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
    if(playMode) playModeName = "Press '=' to change mode: Performance";
    else playModeName = "Press '=' to change mode: Explorer ";
    text(playModeName, 75, 15);
    text("Press 'v' to hide/show GUI", 75, 30);
    
    //// scene
    fill(255);
    textFont(guiFont12);
    text(("scene " + scene) + (": " + activeCharacter), 10, height-50);
    
  }
  else if(drawGui == 1){
    if(!playMode){
      textFont(guiFont12);
      fill(200);
         
      int tempActiveLayer = activeLayer+1;
      if(activeLayer == 9){
        tempActiveLayer = 0;
      }
      
      String activeMode = "Explore: " + tempActiveLayer + "" + activeBehavior + "" + activeRenderMode;
      text(activeMode, 12, 16);
    }
    else{
      textFont(guiFont12);
      fill(200);
      String activeMode = "Perform: " + scene + ": " + activeCharacter;
      text(activeMode, 12, 16);
    }
  }
  
  
    for(FlyingLine fl : layers){
  
      fl.drawLine();
    }
  if(!holdMode){  
    FlyingLine fl = layers.get(activeLayer);
    fl.updateLine();
  }
  
  if(holdMode && pressStart){
    //println("hold and press");
    
    FlyingLine fl = layers.get(activeLayer);
    for(int i = 0; i < fl.flyLine.size(); i++){
      fl.flyLine.get(i).pos.x = fl.flyLine.get(i).originalPos.x + (mouseX - pressStartPos.x);
      fl.flyLine.get(i).pos.y = fl.flyLine.get(i).originalPos.y + (mouseY - pressStartPos.y);
    }
    
  }
  
  /// draw cursor
  
  fill(layers.get(activeLayer).lineColor);
  noStroke();
  
  if(cursorOn == true){ 
    if(!holdMode){
      ellipse(mouseX, mouseY, 5,5);
    }
    else{
      noFill();
      stroke(layers.get(activeLayer).lineColor);
      rect(mouseX, mouseY, 10,10);
    }
  }
  
  //println("activeLayer " + activeLayer);
  
}

void resetAfterZ(){
  
  if (frameCount > resetTrigger && resetafterZActivated){   
    for(int i = 0; i < layers.size(); i++){
        if(i != activeLayer){
          FlyingLine flyline = layers.get(i);
          for(Particle p : flyline.flyLine){
             p.setBehavior(1, false);
          }
        }  
      }
      resetafterZActivated = false;
  }
  
}

void mousePressed(){
  
  if(!pressStart){
    pressStart = true;
    pressStartPos.x = mouseX;
    pressStartPos.y = mouseY;
 
  }  
}

void mouseReleased(){
  
  if(pressStart){
    pressStart = false;
    
    FlyingLine fl = layers.get(activeLayer);
    for(int i = 0; i < fl.flyLine.size(); i++){
      fl.flyLine.get(i).originalPos.x = fl.flyLine.get(i).pos.x;
      fl.flyLine.get(i).originalPos.y = fl.flyLine.get(i).pos.y;
    }
  }
  
  FlyingLine fl = layers.get(activeLayer);
  if(fl.particleIndex != 0){
    fl.flyLine.get(fl.particleIndex - 1).isSpace = true;
  }
  else{
    fl.flyLine.get(fl.lineMax-1).isSpace = true;
  }
  
}

void createCharacter(String _character){
  
  setCharacterOption(_character.charAt(0));
  setCharacterOption(_character.charAt(1));
  setCharacterOption(_character.charAt(2));
  
}

void keyPressed(){
  
  char input = key;
  
  ////// GLOBAL ACTIONS
  if(input == '='){
    playMode = !playMode;
  }  
  else if(input == 'b'){
    bgColor++;
    bgColor = bgColor%2;
  } 
  else if(input == 'c'){ 
    cursorOn = !cursorOn;
  } 
  else if(input == 'x'){
    layers.get(activeLayer).deleteLine();   
  }
  else if(input == 'X'){
    for(FlyingLine flyline : layers){
      flyline.deleteLine();
    }
  }
  else if(input == 'z'){
    for(int i = 0; i < layers.size(); i++){
      if(i != activeLayer){
        FlyingLine flyline = layers.get(i);
        for(Particle p : flyline.flyLine){
           p.setBehavior(7, false);
        }
      }  
    }
    resetTrigger = frameCount + resetDelay;
    resetafterZActivated = true;
  } 
  else if(input == 'v'){ 
    drawGui++;
    drawGui = drawGui%2;
  }
  else if(input == 'V'){ 
    drawGui = 2;
  }
  else if(input == 'h'){ 
    holdMode = !holdMode;
  }

  if(playMode){
    if(input == 'a'){
      scene = 1;
      activeCharacter = 1;
    }
    else if(input == 's'){
      scene = 2;
      activeCharacter = 1;
    }
    else if(input == 'd'){
      scene = 3;
      activeCharacter = 1;
    }
    else if(input == 'f'){
      scene = 4;
      activeCharacter = 1;
    }
    else if(input == 'j'){
      scene = 5;
      activeCharacter = 1;
    }
    
    if (key == CODED) {
      if (keyCode == RIGHT) {
        activeCharacter++;
        activeCharacter=activeCharacter%10;
      }
      else if (keyCode == LEFT) {
        activeCharacter--;
        if(activeCharacter<0) activeCharacter = 9;      
      }
      String stringInput = str(activeCharacter);
      char charInput = stringInput.charAt(0);
      println("charInput " + charInput);
      setCharacter(charInput, scene);
    }
    else
    {
      setCharacter(input, scene);    
    }  
  }
  else{
    if (key == CODED) {
      if (keyCode == RIGHT) {
        activeLayer++;
        activeLayer=activeLayer%10;
      }
      else if (keyCode == LEFT) {
        activeLayer--;
        if(activeLayer<0) activeLayer =9;
        
      }
    }
    setCharacterOption(input);
  }  
}

void setCharacter(char _input, int _scene){
  
  if(_scene == 1){
    if(_input == '1'){
      activeCharacter = 1;
      createCharacter(charactersScene1[0]);
    }
    else if(_input == '2'){
      activeCharacter = 2;
      createCharacter(charactersScene1[1]);
    }
    else if(_input == '3'){
      activeCharacter = 3;
      createCharacter(charactersScene1[2]);
    }
    else if(_input == '4'){
      activeCharacter = 4;
      createCharacter(charactersScene1[3]);
    }
    else if(_input == '5'){
      activeCharacter = 5;
      createCharacter(charactersScene1[4]);
    }
    else if(_input == '6'){
      activeCharacter = 6;
      createCharacter(charactersScene1[5]);
    }
    else if(_input == '7'){
      activeCharacter = 7;
      createCharacter(charactersScene1[6]);
    }
    else if(_input == '8'){
      activeCharacter = 8;
      createCharacter(charactersScene1[7]);
    }
    else if(_input == '9'){
      activeCharacter = 9;
      createCharacter(charactersScene1[8]);
    }
    else if(_input == '0'){
      activeCharacter = 0;
      createCharacter(charactersScene1[9]);
    }
  }
  else if(_scene == 2){
    if(_input == '1'){
      activeCharacter = 1;
      createCharacter(charactersScene2[0]);
    }
    else if(_input == '2'){
      activeCharacter = 2;
      createCharacter(charactersScene2[1]);
    }
    else if(_input == '3'){
      activeCharacter = 3;
      createCharacter(charactersScene2[2]);
    }
    else if(_input == '4'){
      activeCharacter = 4;
      createCharacter(charactersScene2[3]);
    }
    else if(_input == '5'){
      activeCharacter = 5;
      createCharacter(charactersScene2[4]);
    }
    else if(_input == '6'){
      activeCharacter = 6;
      createCharacter(charactersScene2[5]);
    }
    else if(_input == '7'){
      activeCharacter = 7;
      createCharacter(charactersScene2[6]);
    }
    else if(_input == '8'){
      activeCharacter = 8;
      createCharacter(charactersScene2[7]);
    }
    else if(_input == '9'){
      activeCharacter = 9;
      createCharacter(charactersScene2[8]);
    }
    else if(_input == '0'){
      activeCharacter = 0;
      createCharacter(charactersScene2[9]);
    }
  }
  else if(_scene == 3){
    if(_input == '1'){
      activeCharacter = 1;
      createCharacter(charactersScene3[0]);
    }
    else if(_input == '2'){
      activeCharacter = 2;
      createCharacter(charactersScene3[1]);
    }
    else if(_input == '3'){
      activeCharacter = 3;
      createCharacter(charactersScene3[2]);
    }
    else if(_input == '4'){
      activeCharacter = 4;
      createCharacter(charactersScene3[3]);
    }
    else if(_input == '5'){
      activeCharacter = 5;
      createCharacter(charactersScene3[4]);
    }
    else if(_input == '6'){
      activeCharacter = 6;
      createCharacter(charactersScene3[5]);
    }
    else if(_input == '7'){
      activeCharacter = 7;
      createCharacter(charactersScene3[6]);
    }
    else if(_input == '8'){
      activeCharacter = 8;
      createCharacter(charactersScene3[7]);
    }
    else if(_input == '9'){
      activeCharacter = 9;
      createCharacter(charactersScene3[8]);
    }
    else if(_input == '0'){
      activeCharacter = 0;
      createCharacter(charactersScene3[9]);
    }
  }
  else if(_scene == 4){
    if(_input == '1'){
      activeCharacter = 1;
      createCharacter(charactersScene4[0]);
    }
    else if(_input == '2'){
      activeCharacter = 2;
      createCharacter(charactersScene4[1]);
    }
    else if(_input == '3'){
      activeCharacter = 3;
      createCharacter(charactersScene4[2]);
    }
    else if(_input == '4'){
      activeCharacter = 4;
      createCharacter(charactersScene4[3]);
    }
    else if(_input == '5'){
      activeCharacter = 5;
      createCharacter(charactersScene4[4]);
    }
    else if(_input == '6'){
      activeCharacter = 6;
      createCharacter(charactersScene4[5]);
    }
    else if(_input == '7'){
      activeCharacter = 7;
      createCharacter(charactersScene4[6]);
    }
    else if(_input == '8'){
      activeCharacter = 8;
      createCharacter(charactersScene4[7]);
    }
    else if(_input == '9'){
      activeCharacter = 9;
      createCharacter(charactersScene4[8]);
    }
    else if(_input == '0'){
      activeCharacter = 0;
      createCharacter(charactersScene4[9]);
    }
  }
  else if(_scene == 5){
    if(_input == '1'){
      activeCharacter = 1;
      createCharacter(charactersScene5[0]);
    }
    else if(_input == '2'){
      activeCharacter = 2;
      createCharacter(charactersScene5[1]);
    }
    else if(_input == '3'){
      activeCharacter = 3;
      createCharacter(charactersScene5[2]);
    }
    else if(_input == '4'){
      activeCharacter = 4;
      createCharacter(charactersScene5[3]);
    }
    else if(_input == '5'){
      activeCharacter = 5;
      createCharacter(charactersScene5[4]);
    }
    else if(_input == '6'){
      activeCharacter = 6;
      createCharacter(charactersScene5[5]);
    }
    else if(_input == '7'){
      activeCharacter = 7;
      createCharacter(charactersScene5[6]);
    }
    else if(_input == '8'){
      activeCharacter = 8;
      createCharacter(charactersScene5[7]);
    }
    else if(_input == '9'){
      activeCharacter = 9;
      createCharacter(charactersScene5[8]);
    }
    else if(_input == '0'){
      activeCharacter = 0;
      createCharacter(charactersScene5[9]);
    }
  }
  
  
}
  
void setCharacterOption(char _input){
  
  ////// LAYER SELECT
  
  if(_input == '1'){
    activeLayer = 0;
  }
  else if(_input == '2'){
    activeLayer = 1;
  }
  else if(_input == '3'){
    activeLayer = 2;
  }
  else if(_input == '4'){
    activeLayer = 3;
  }
  else if(_input == '5'){
    activeLayer = 4;
  }
  else if(_input == '6'){
    activeLayer = 5;
  }
  else if(_input == '7'){
    activeLayer = 6;
  }
  else if(_input == '8'){
    activeLayer = 7;
  }
  else if(_input == '9'){
    activeLayer = 8;
  }
  else if(_input == '0'){
    activeLayer = 9;
  }
  
  
  FlyingLine fl = layers.get(activeLayer);
  
  
  ///// BEHAVIORS SELECT
  
  
  
  if(_input == 'q'){
    activeBehavior = _input;
    for(Particle p : fl.flyLine){
       p.setBehavior(1, false);
    }
  }
  else if(_input == 'w'){
    activeBehavior = _input;
    for(Particle p : fl.flyLine){
       p.setBehavior(2, false);
    }
  }
  else if(_input == 'e'){
    activeBehavior = _input;
    for(Particle p : fl.flyLine){
       p.setBehavior(3, false);
    }
  }
  else if(_input == 'r'){
    activeBehavior = _input;
    for(Particle p : fl.flyLine){
       p.setBehavior(4, false);
    }
  }
  else if(_input == 'a'){
    activeBehavior = _input;
    for(Particle p : fl.flyLine){
       p.setBehavior(5, false);
    }
  }
  else if(_input == 's'){
    activeBehavior = _input;
    for(Particle p : fl.flyLine){
       p.setBehavior(6, false);
    }
  }
 
  ///// BEHAVIORS MULTIPLE SELECT
  
  if(_input == 'Q'){
    activeBehavior = _input;
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(1, false);
      }
    }
  }
  else if(_input == 'W'){
    activeBehavior = _input;
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(2, false);
      }
    }
  }
  else if(_input == 'E'){
    activeBehavior = _input;
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(3, false);
      }
    }
  }
  else if(_input == 'R'){
    activeBehavior = _input;
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(4, false);
      }
    }
  }
  else if(_input == 'A'){
    activeBehavior = _input;
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(5, false);
      }
    }
  }
  else if(_input == 'S'){
    activeBehavior = _input;
    for(FlyingLine flyline : layers){
      for(Particle p : flyline.flyLine){
         p.setBehavior(6, false);
      }
    }
  }
  
  
  ////// RENDERING MODES
  
  if(_input == 'p'){
    activeRenderMode = _input;
    renderMode = "particles";
    fl.lineMode = renderMode;
  }
  else if(_input == 'l'){
    activeRenderMode = _input;
    renderMode = "lines";
    fl.lineMode = renderMode;
  }
  else if(_input == 'k'){
    activeRenderMode = _input;
    renderMode = "fatLines";
    fl.lineMode = renderMode;
  }
  else if(_input == 'm'){
    activeRenderMode = _input;
    renderMode = "megaLines";
    fl.lineMode = renderMode;
  }
  else if(_input == 'n'){
    activeRenderMode = _input;
    renderMode = "letters";
    fl.lineMode = renderMode;
  }
  else if(_input == 'o'){
    activeRenderMode = _input;
    renderMode = "circles";
    fl.lineMode = renderMode;
  }
  
  ////// RENDERING MULTIPLE MODES
  
  if(_input == 'P'){
    activeRenderMode = _input;
    for(FlyingLine flyline : layers){
      renderMode = "particles";
      flyline.lineMode = renderMode;
    }
  }
  else if(_input == 'L'){
    activeRenderMode = _input;
    for(FlyingLine flyline : layers){
      renderMode = "lines";
      flyline.lineMode = renderMode;
    }
  }
  else if(_input == 'K'){
    activeRenderMode = _input;
    for(FlyingLine flyline : layers){
      renderMode = "fatLines";
      flyline.lineMode = renderMode;
    }
  }
  else if(_input == 'M'){
    activeRenderMode = _input;
    for(FlyingLine flyline : layers){
      renderMode = "megaLines";
      flyline.lineMode = renderMode;
    }
  }
  else if(_input == 'N'){
    activeRenderMode = _input;
    for(FlyingLine flyline : layers){
      renderMode = "letters";
      flyline.lineMode = renderMode;
    }
  }
  else if(_input == 'O'){
    activeRenderMode = _input;
    for(FlyingLine flyline : layers){
      renderMode = "circles";
      flyline.lineMode = renderMode;
    }
  }
  
  
}