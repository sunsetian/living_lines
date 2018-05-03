/*******************************************************
INTERACTIVE VISUAL SOFTWARE BY SEBASTIAN GONZALEZ DIXON
COMMISSIONED BY EVA VON SCHWEINITZ
FOR HER WORK "THE SPACE BETWEEN THE LETTERS"
CODE PRODUCED THANKS TO HARVESTWORKS ARTIST IN RESIDENCE
OPEN SOURCE UNDER MIT LICENCE
NEW YORK, 2018  
*****************************************************/

// Version 0.9

ArrayList<FlyingLine> layers;

int layersNumber = 10;
int activeLayer = 0;
int activeColor = 1;

int bgColor = 0;

int[] lineMaxLength = {50, 200, 200, 200, 200, 200, 300, 500, 600, 900}; /// lenght for each one of the lines

color[] colors = {#158788,  #d34c26, #e2a63d, #cdfee9, #fec0b4, #fd9d27, #fafeaf, #d0dc4d, #ec4958, #6C5B7B}; // color for each line

char[] characterBankKey = {'a', 's', 'd', 'f', 'j'};
int activeCharacterBank = 0;

String renderMode = "lines";

String guiText01 = "1";

PFont guiFont12;
PFont guiFont24;

int drawGui = 1;

boolean holdMode = false;
boolean pressStart = false;
PVector pressStartPos = new PVector(0, 0);

boolean playMode = true;

boolean cursorOn = true;

int scene = 1;
char activeBehavior = 'q';
char activeRenderMode = 'l';

int activeCharacter = 1;

int resetTrigger = 0;
boolean resetafterZActivated = false;
boolean resetafterXActivated = false;
boolean deleteActive = false;
int resetDelay = 45;

int alphaDelete = 255;

String[] charactersScene1 = {"1wp1", "1ep1", "1el1", "0ql1", "1qk1", "1wo1", "5qp5", "9ep9", "4ql4", "3ql3"};  ////  a  // IN PERFORMANCE MODE
String[] charactersScene2 = {"2lq3", "3ql7", "4ql8", "5ql7", "6ql6", "2pw2", "3pw3", "4pw4", "2el2", "2pw2"};  ////  s
String[] charactersScene3 = {"1el1", "0ql0", "1ak1", "1eo1", "1wp1", "1ep1", "5qp5", "6am6", "6ql6", "3ql3"};  ////  d
String[] charactersScene4 = {"0ql0", "1ak1", "1eo1", "1wp1", "1ep1", "1el1", "5qp5", "6am6", "6ql6", "4ql4"};  ////  f
String[] charactersScene5 = {"2ql2", "3ql3", "4ql4", "5ql5", "6ql6", "2pw2", "3pw3", "4pw4", "5pw5", "6pw6"};  ////  j

String activeCharCode;
String deletedCharCode;

void setup(){
  
  noCursor();
  size(1024, 750, P2D);
  background(bgColor);
  
  guiFont12 = createFont("OCRAStd-24.vlw", 12);
  guiFont24 = createFont("OCRAStd-24.vlw", 24);
  textFont(guiFont24);
  
  layers = new ArrayList<FlyingLine>();
  
  for (int i = 0; i < layersNumber; i++) {  
    FlyingLine fl = new FlyingLine(colors[i], lineMaxLength[i], renderMode, i);
    layers.add(fl); 
   }
   
   activeCharacter = 1;
   activeCharCode = charactersScene1[0];
   createCharacter(charactersScene1[0]);
  
}

void draw(){
  
  background(bgColor*255);
  resetAfterZ();
  resetAfterX();

  int tempActiveLayer = activeLayer+1;
  if(activeLayer == 9){
    tempActiveLayer = 0;
  }
  int tempActiveColor = layers.get(activeLayer).lineColorIndex+1;
  if(tempActiveColor == 10){
    tempActiveColor = 0;
  }
  
  activeCharCode = "" + tempActiveLayer + "" + layers.get(activeLayer).behaviorCode + "" + layers.get(activeLayer).renderingCode + "" + tempActiveColor;
  
  if(drawGui == 2){
    fill(layers.get(activeLayer).lineColor);
    rect(5, 5, 80, 30);
    fill(0);
    textFont(guiFont24);

    text(activeCharCode, 12, 30);

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
    text(playModeName, 95, 15);
    text("Press 'v' to hide/show GUI", 95, 30);
    
    //// scene
    fill(255);
    textFont(guiFont12);
    text(("scene " + scene) + (": " + activeCharacter), 10, height-50);
    
  }
  else if(drawGui == 1){
    if(!playMode){
      textFont(guiFont12);
      fill(200);
      
      String activeMode = "Explore >> " + activeCharCode;
      text(activeMode, 12, 16);
    }
    else{
      textFont(guiFont12);
      fill(200);
      String activeMode = "Perform >> '" + characterBankKey[activeCharacterBank] + "': " + activeCharacter + " >> " + activeCharCode;
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
      strokeWeight(1);
      ellipse(mouseX, mouseY, 10,10);
    }
  }
}

void resetAfterX(){
  
  if(resetafterXActivated){
    if(deleteActive){
      FlyingLine flyline = layers.get(activeLayer);
      flyline.lineColor = color(flyline.lineColor, alphaDelete);
      alphaDelete--;
    }
    else{
      for(int i = 0; i < layers.size(); i++){     
         FlyingLine flyline = layers.get(i);
         flyline.lineColor = color(flyline.lineColor, alphaDelete);  
      }
      alphaDelete--;
    }   
  }
  
  if (frameCount > resetTrigger && resetafterXActivated){ 
    alphaDelete = 255;
    resetafterXActivated = false;
    if(deleteActive){     
      FlyingLine flyline = layers.get(activeLayer);
      flyline.lineColor = color(red(flyline.lineColor), green(flyline.lineColor), blue(flyline.lineColor), alphaDelete);
      flyline.deleteLine();
      flyline.lineMode = "lines";
      for(Particle p : flyline.flyLine){
         p.setBehavior(1, false);          
      }
      deleteActive = false;
      createCharacter(deletedCharCode);
    }
    else{
      for(int i = 0; i < layers.size(); i++){
        FlyingLine flyline = layers.get(i);
        flyline.lineColor = color(red(flyline.lineColor), green(flyline.lineColor), blue(flyline.lineColor), alphaDelete);
        flyline.deleteLine();
        flyline.lineMode = "lines";
        for(Particle p : flyline.flyLine){
           p.setBehavior(1, false);          
        }
      }      
    }
  }  
}

void resetAfterZ(){
  
  if(resetafterZActivated){   
   for(int i = 0; i < layers.size(); i++){
     if(i != activeLayer){
       FlyingLine flyline = layers.get(i);
       flyline.lineColor = color(flyline.lineColor, alphaDelete);     
     }  
    }
    alphaDelete--;  
  }
  
  if (frameCount > resetTrigger && resetafterZActivated){ 
    alphaDelete = 255;
    resetafterZActivated = false;
    for(int i = 0; i < layers.size(); i++){
      FlyingLine flyline = layers.get(i);
      flyline.lineColor = color(red(flyline.lineColor), green(flyline.lineColor), blue(flyline.lineColor), alphaDelete);
      for(Particle p : flyline.flyLine){
         p.setBehavior(1, false);
      }
    }    
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
  setLayerColor(Integer.parseInt(""+_character.charAt(0))-1, Integer.parseInt(""+_character.charAt(3))-1);
  
}

void keyPressed(){
  
  char input = key;
  
  int activeLayerTemp = activeLayer;
  
  if(!resetafterZActivated && !resetafterXActivated){
    ////// GLOBAL ACTIONS
    if(input == '='){
      playMode = !playMode;
      //if(!playMode) drawGui = 0;
    }  
    else if(input == 'b'){
      bgColor++;
      bgColor = bgColor%2;
    } 
    else if(input == 'c'){ 
      cursorOn = !cursorOn;
    }
    else if(input == 'x'){
      FlyingLine fl = layers.get(activeLayer);
      fl.lineMode = "particles";
      for(Particle p : fl.flyLine){
         p.setBehavior(8, false);
      }
      deleteActive = true;
      resetTrigger = frameCount + resetDelay;
      resetafterXActivated = true;
      deletedCharCode = activeCharCode;
    }
    else if(input == 'X'){
      for(FlyingLine flyline : layers){
        flyline.lineMode = "particles";
        for(Particle p : flyline.flyLine){
           p.setBehavior(8, false);
        }
      } 
      resetTrigger = frameCount + resetDelay;
      resetafterXActivated = true; 
      deletedCharCode = activeCharCode;
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
      if(playMode){
        drawGui++;
        drawGui = drawGui%2;
      }
      else{
        if(drawGui == 0 || drawGui == 1) drawGui = 2;
        else if(drawGui == 2) drawGui = 0;
      }
    }
    else if(input == 'V'){ 
      drawGui = 2;
    }
    else if(input == 'h'){ 
      holdMode = !holdMode;
    }
    else if(input == ']'){ 
      FlyingLine flyline = layers.get(activeLayer);
      int newColorIndex = flyline.lineColorIndex+1;
      if(newColorIndex >= colors.length) newColorIndex = 0; 
      setLayerColor(activeLayer, newColorIndex);
    }
    else if(input == '['){ 
      FlyingLine flyline = layers.get(activeLayer);
      int newColorIndex = flyline.lineColorIndex-1;
      if(newColorIndex < 0) newColorIndex = colors.length-1;
      setLayerColor(activeLayer, newColorIndex);
    }
  
    if(playMode){
      if(input == characterBankKey[0]){
        scene = 1;
        activeCharacter = 1;
        activeCharacterBank = 0;
        createCharacter(charactersScene1[0]);
      }
      else if(input == characterBankKey[1]){
        scene = 2;
        activeCharacter = 1;
        activeCharacterBank = 1;
        createCharacter(charactersScene2[0]);
      }
      else if(input == characterBankKey[2]){
        scene = 3;
        activeCharacter = 1;
        activeCharacterBank = 2;
        createCharacter(charactersScene3[0]);
      }
      else if(input == characterBankKey[3]){
        scene = 4;
        activeCharacter = 1;
        activeCharacterBank = 3;
        createCharacter(charactersScene4[0]);
      }
      else if(input == characterBankKey[4]){
        scene = 5;
        activeCharacter = 1;
        activeCharacterBank = 4;
        createCharacter(charactersScene5[0]);
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
  
  if(activeLayer != activeLayerTemp){
    FlyingLine fl = layers.get(activeLayerTemp);
    if(fl.particleIndex != 0){
      fl.flyLine.get(fl.particleIndex - 1).isSpace = true;
    }
    else{
      fl.flyLine.get(fl.lineMax-1).isSpace = true;
    }
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
  
void setLayerColor(int _layer, int _colorIndex){
  
  if(_layer == -1) _layer = 9;
  if(_colorIndex == -1) _colorIndex = 9;
  FlyingLine fl = layers.get(_layer);
  fl.lineColor = colors[_colorIndex];
  fl.lineColorIndex = _colorIndex; 
  activeColor = _colorIndex;
  
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
    fl.behaviorCode = _input;
    for(Particle p : fl.flyLine){
       p.setBehavior(1, false);
    }
  }
  else if(_input == 'w'){
    activeBehavior = _input;
    fl.behaviorCode = _input;
    for(Particle p : fl.flyLine){
       p.setBehavior(2, false);
    }
  }
  else if(_input == 'e'){
    activeBehavior = _input;
    fl.behaviorCode = _input;
    for(Particle p : fl.flyLine){
       p.setBehavior(3, false);
    }
  }
  else if(_input == 'r'){
    activeBehavior = _input;
    fl.behaviorCode = _input;
    for(Particle p : fl.flyLine){
       p.setBehavior(4, false);
    }
  }
  else if(_input == 'a'){
    activeBehavior = _input;
    fl.behaviorCode = _input;
    for(Particle p : fl.flyLine){
       p.setBehavior(5, false);
    }
  }
  else if(_input == 's'){
    activeBehavior = _input;
    fl.behaviorCode = _input;
    for(Particle p : fl.flyLine){
       p.setBehavior(6, false);
    }
  }
   
  ///// BEHAVIORS MULTIPLE SELECT
  
  if(_input == 'Q'){
    activeBehavior = _input;   
    for(FlyingLine flyline : layers){
      flyline.behaviorCode = 'q';
      for(Particle p : flyline.flyLine){
         p.setBehavior(1, false);
      }
    }
  }
  else if(_input == 'W'){
    activeBehavior = _input;
    fl.behaviorCode = _input;
    for(FlyingLine flyline : layers){
      flyline.behaviorCode = 'w';
      for(Particle p : flyline.flyLine){
         p.setBehavior(2, false);
      }
    }
  }
  else if(_input == 'E'){
    activeBehavior = _input;
    for(FlyingLine flyline : layers){
      flyline.behaviorCode = 'e';
      for(Particle p : flyline.flyLine){
         p.setBehavior(3, false);
      }
    }
  }
  else if(_input == 'R'){
    activeBehavior = _input;
    for(FlyingLine flyline : layers){
      flyline.behaviorCode = 'r';
      for(Particle p : flyline.flyLine){
         p.setBehavior(4, false);
      }
    }
  }
  else if(_input == 'A'){
    activeBehavior = _input;
    for(FlyingLine flyline : layers){
      flyline.behaviorCode = 'a';
      for(Particle p : flyline.flyLine){
         p.setBehavior(5, false);
      }
    }
  }
  else if(_input == 'S'){
    activeBehavior = _input;
    for(FlyingLine flyline : layers){
      flyline.behaviorCode = 's';
      for(Particle p : flyline.flyLine){
         p.setBehavior(6, false);
      }
    }
  }
 
  ////// RENDERING MODES
  
  if(_input == 'p'){
    activeRenderMode = _input;
    fl.renderingCode = _input;
    renderMode = "particles";
    fl.lineMode = renderMode;
  }
  else if(_input == 'l'){
    activeRenderMode = _input;
    fl.renderingCode = _input;
    renderMode = "lines";
    fl.lineMode = renderMode;
  }
  else if(_input == 'k'){
    activeRenderMode = _input;
    fl.renderingCode = _input;
    renderMode = "fatLines";
    fl.lineMode = renderMode;
  }
  else if(_input == 'm'){
    activeRenderMode = _input;
    fl.renderingCode = _input;
    renderMode = "megaLines";
    fl.lineMode = renderMode;
  }
  else if(_input == 'n'){
    activeRenderMode = _input;
    fl.renderingCode = _input;
    renderMode = "letters";
    fl.lineMode = renderMode;
  }
  else if(_input == 'o'){
    activeRenderMode = _input;
    fl.renderingCode = _input;
    renderMode = "circles";
    fl.lineMode = renderMode;
  }
  
  ////// RENDERING MULTIPLE MODES
  
  if(_input == 'P'){
    activeRenderMode = _input;
    for(FlyingLine flyline : layers){
      flyline.renderingCode = 'p';
      renderMode = "particles";
      flyline.lineMode = renderMode;
    }
  }
  else if(_input == 'L'){
    activeRenderMode = _input;
    for(FlyingLine flyline : layers){
      flyline.renderingCode = 'l';
      renderMode = "lines";
      flyline.lineMode = renderMode;
    }
  }
  else if(_input == 'K'){
    activeRenderMode = _input;
    for(FlyingLine flyline : layers){
      flyline.renderingCode = 'k';
      renderMode = "fatLines";
      flyline.lineMode = renderMode;
    }
  }
  else if(_input == 'M'){
    activeRenderMode = _input;
    for(FlyingLine flyline : layers){
      flyline.renderingCode = 'm';
      renderMode = "megaLines";
      flyline.lineMode = renderMode;
    }
  }
  else if(_input == 'N'){
    activeRenderMode = _input;
    for(FlyingLine flyline : layers){
      flyline.renderingCode = 'n';
      renderMode = "letters";
      flyline.lineMode = renderMode;
    }
  }
  else if(_input == 'O'){
    activeRenderMode = _input;
    for(FlyingLine flyline : layers){
      flyline.renderingCode = 'o';
      renderMode = "circles";
      flyline.lineMode = renderMode;
    }
  } 
}