class FlyingLine {

  ArrayList<Particle> flyLine;
  
  int behavior = 1;
  
  int lineMax = 300;
  
  int particleIndex = 0;
  
  color lineColor = color(random(100, 255), random(100, 255), random(100, 255));
  
  String lineMode = "lines";
  
  boolean debugMode = false;
  
  PFont f;
  
  char[] letterSet = {'A', 'B', 'C', 'D','E', 
                        'F', 'G', 'H', 'I', 'J',
                         'K', 'L', 'M', 'N', 'O', 
                          'P', 'Q', 'R', 'S', 'T',
                           'U', 'V', 'W', 'X', 'Y',
                            'Z', 'a', 'b', 'c','d',
                            'e', 'f', 'g', 'h', 'i',
                             'j', 'k', 'l', 'm', 'n',
                              'o', 'p', 'q', 'r', 's',
                               't', 'u', 'v', 'w', 'x',
                                'y', 'z'};
  
  FlyingLine(int _lineColor, int _lineMax, String _lineMode){
    
    lineColor = _lineColor;
    lineMax = _lineMax;
    lineMode = _lineMode;
    
    f = createFont("AvenirNextCondensed-Bold-48.vlw", 12);
    textFont(f);
    
    flyLine = new ArrayList<Particle>();
  
    for (int i = 0; i < lineMax; i++) {
      Particle p = new Particle(new PVector(-10000, -10000), i, lineMax);
      flyLine.add(p);
   
     }
    
  }

  
   void updateLine(){ 
   
    /// VERIFY IF MOUSE POSITION CHANGED TO UPDATE PARTICLE VALUE. THIS IS EVALUATED OVER THE PARTICLE INDEX COUNTER
    if(mousePressed){
      
      if(particleIndex != 0){
      
        if(mouseX != int(flyLine.get(particleIndex-1).pos.x) || mouseY != int(flyLine.get(particleIndex-1).pos.y)){
          
          Particle refParticle = flyLine.get(particleIndex);      
          refParticle.reset(new PVector(mouseX, mouseY), particleIndex);
         
          particleIndex ++;
          particleIndex = particleIndex % lineMax;
          
        }
      }
      else{
        if(mouseX != int(flyLine.get(lineMax-1).pos.x) || mouseY != int(flyLine.get(lineMax-1).pos.y)){
          
          Particle refParticle = flyLine.get(particleIndex);      
          refParticle.reset(new PVector(mouseX, mouseY), particleIndex);
         
          particleIndex ++;
          particleIndex = particleIndex % lineMax;
          
        }
      }
    }
  }
    
  void drawLine(){
    //// DRAW THE LINE CONSIDERING PARTICLE INDEX AS THE BEGINING OF IT, NOT THE ZERO POSITION OF THE ARRAY
    
    int relativeIndex;
    
    if(lineMode == "curves"){ //// STILL BUGGY
      noFill();
      strokeWeight(4);
      beginShape(); 
      for(int i = 0; i < flyLine.size(); i++){
        if(i != particleIndex && !flyLine.get(i).isSpace){
          if(i >= particleIndex){
            relativeIndex = i-particleIndex;
          }
          else{
            relativeIndex = lineMax+i-particleIndex;
          }  
          stroke(lineColor, (255*float(relativeIndex)*1/float(lineMax)));
        }
        else{
         stroke(lineColor,0);
         
         curveVertex(flyLine.get(i).pos.x, flyLine.get(i).pos.y);
         flyLine.get(i).update(i);
         i++;
         if(i >= lineMax) break;
         curveVertex(flyLine.get(i).pos.x, flyLine.get(i).pos.y);
         flyLine.get(i).update(i);
         i++;
         if(i >= lineMax) break;
        }
  
        curveVertex(flyLine.get(i).pos.x, flyLine.get(i).pos.y);
  
        
        flyLine.get(i).update(i);
      }
      
      endShape();
      
      if(debugMode){
        noStroke();
        fill(255,0,0);
        ellipse(flyLine.get(0).pos.x, flyLine.get(0).pos.y, 8, 8);
        fill(0, 255,0);
        ellipse(flyLine.get(lineMax-1).pos.x, flyLine.get(lineMax-1).pos.y, 8, 8);
        fill(0, 0, 255);
        ellipse(flyLine.get(particleIndex).pos.x, flyLine.get(particleIndex).pos.y, 8, 8);
        if(particleIndex != 0){
          fill(255, 255, 0);
          ellipse(flyLine.get(particleIndex-1).pos.x, flyLine.get(particleIndex-1).pos.y, 8, 8);      
        }
        for(int i = 0; i < flyLine.size()-1; i++){
          if(flyLine.get(i).isSpace){
            fill(0, 255, 255);
            ellipse(flyLine.get(i).pos.x, flyLine.get(i).pos.y, 8, 8);
          }
        }
      }
    }
    else if(lineMode == "lines"){
      //ORIGINAL LINE DRAWING
      noFill();
      strokeWeight(4);
      //strokeCap(SQUARE);
      for(int i = 0; i < flyLine.size(); i++){
        
        if(i >= particleIndex){
          relativeIndex = i-particleIndex;
        }
        else{
          relativeIndex = lineMax+i-particleIndex;
        }  
        stroke(lineColor, (255*float(relativeIndex)*1/float(lineMax)));
          
        if(flyLine.get(i).pos.x > -100 && flyLine.get(i).pos.y > -100 && flyLine.get(i).pos.x < width + 100 && flyLine.get(i).pos.y < height + 100){ /// Bounderies for deleted lines
          
          
         if(i != particleIndex-1 && !flyLine.get(i).isSpace){
           if(i != flyLine.size()-1){
            line(flyLine.get(i).pos.x, flyLine.get(i).pos.y, flyLine.get(i+1).pos.x, flyLine.get(i+1).pos.y);
           }
           else if(particleIndex != 0){
             line(flyLine.get(i).pos.x, flyLine.get(i).pos.y, flyLine.get(0).pos.x, flyLine.get(0).pos.y);
           }      
         }
        }
        
         flyLine.get(i).update(relativeIndex);
      }
    
    }
    else if(lineMode == "megaLines"){
      //ORIGINAL LINE DRAWING
      noFill();
      strokeWeight(20);
      //strokeCap(SQUARE);
      for(int i = 0; i < flyLine.size(); i++){
        
        if(i >= particleIndex){
          relativeIndex = i-particleIndex;
        }
        else{
          relativeIndex = lineMax+i-particleIndex;
        }  
        stroke(lineColor, 255);
          
        if(flyLine.get(i).pos.x > -100 && flyLine.get(i).pos.y > -100 && flyLine.get(i).pos.x < width + 100 && flyLine.get(i).pos.y < height + 100){ /// Bounderies for deleted lines
          
          
         if(i != particleIndex-1 && !flyLine.get(i).isSpace){
           if(i != flyLine.size()-1){
            line(flyLine.get(i).pos.x, flyLine.get(i).pos.y, flyLine.get(i+1).pos.x, flyLine.get(i+1).pos.y);
           }
           else if(particleIndex != 0){
             line(flyLine.get(i).pos.x, flyLine.get(i).pos.y, flyLine.get(0).pos.x, flyLine.get(0).pos.y);
           }      
         }
        }
        
         flyLine.get(i).update(relativeIndex);
      }
    
    }
    else if(lineMode == "fatLines"){
      //ORIGINAL LINE DRAWING
      noFill();
      //strokeWeight(4);
      //strokeCap(SQUARE);
      for(int i = 0; i < flyLine.size(); i++){
        
        if(i >= particleIndex){
          relativeIndex = i-particleIndex;
        }
        else{
          relativeIndex = lineMax+i-particleIndex;
        }  
        stroke(lineColor, 255);
        //println("(60*float(relativeIndex)/float(lineMax)) " + (60*float(relativeIndex)/float(lineMax)));
        
        if(relativeIndex > lineMax/2){
          strokeWeight((60*float(lineMax-relativeIndex)/float(lineMax)));
        }
        else{
            strokeWeight((60*float(relativeIndex)/float(lineMax)));
        }
          
        if(flyLine.get(i).pos.x > -100 && flyLine.get(i).pos.y > -100 && flyLine.get(i).pos.x < width + 100 && flyLine.get(i).pos.y < height + 100){ /// Bounderies for deleted lines
          
          
         if(i != particleIndex-1 && !flyLine.get(i).isSpace){
           if(i != flyLine.size()-1){
            line(flyLine.get(i).pos.x, flyLine.get(i).pos.y, flyLine.get(i+1).pos.x, flyLine.get(i+1).pos.y);
           }
           else if(particleIndex != 0){
             line(flyLine.get(i).pos.x, flyLine.get(i).pos.y, flyLine.get(0).pos.x, flyLine.get(0).pos.y);
           }      
         }
        }
        
         flyLine.get(i).update(relativeIndex);
      }
    
    }
    else if(lineMode == "particles"){
      //ORIGINAL LINE DRAWING
      noStroke();
      strokeWeight(4);
      //strokeCap(SQUARE);
      for(int i = 0; i < flyLine.size(); i++){
        
        if(i >= particleIndex){
          relativeIndex = i-particleIndex;
        }
        else{
          relativeIndex = lineMax+i-particleIndex;
        }  
        fill(lineColor, (255*float(relativeIndex)*1/float(lineMax)));
          
        if(flyLine.get(i).pos.x > -100 && flyLine.get(i).pos.y > -100 && flyLine.get(i).pos.x < width + 100 && flyLine.get(i).pos.y < height + 100){ /// Bounderies for deleted lines
          
          
         //if(i != particleIndex-1 && !flyLine.get(i).isSpace){
           //if(i != flyLine.size()-1){
            ellipse(flyLine.get(i).pos.x, flyLine.get(i).pos.y, 3, 3);
           //}
           //else if(particleIndex != 0){
             //line(flyLine.get(i).pos.x, flyLine.get(i).pos.y, flyLine.get(0).pos.x, flyLine.get(0).pos.y);
           //}      
         //}
        }
        
         flyLine.get(i).update(relativeIndex);
      }
    
    }
    else if(lineMode == "circles"){
      //ORIGINAL LINE DRAWING
      noStroke();
      //strokeWeight(4);
      //strokeCap(SQUARE);
      for(int i = 0; i < flyLine.size(); i++){
        
        if(i >= particleIndex){
          relativeIndex = i-particleIndex;
        }
        else{
          relativeIndex = lineMax+i-particleIndex;
        }  
        fill(lineColor, (255*float(relativeIndex)*0.8/float(lineMax)));
          
        if(flyLine.get(i).pos.x > -100 && flyLine.get(i).pos.y > -100 && flyLine.get(i).pos.x < width + 100 && flyLine.get(i).pos.y < height + 100){ /// Bounderies for deleted lines
          
          
         //if(i != particleIndex-1 && !flyLine.get(i).isSpace){
           //if(i != flyLine.size()-1){
            ellipse(flyLine.get(i).pos.x, flyLine.get(i).pos.y, 1+60*(float(lineMax-relativeIndex)/float(lineMax)), 1+60*(float(lineMax-relativeIndex)/float(lineMax)));
           //}
           //else if(particleIndex != 0){
             //line(flyLine.get(i).pos.x, flyLine.get(i).pos.y, flyLine.get(0).pos.x, flyLine.get(0).pos.y);
           //}      
         //}
        }
        
         flyLine.get(i).update(relativeIndex);
      }
    
    }
    else if(lineMode == "letters"){
      //ORIGINAL LINE DRAWING
      noStroke();
      strokeWeight(4);
      //strokeCap(SQUARE);
      
      for(int i = 0; i < flyLine.size(); i++){
        
        if(i >= particleIndex){
          relativeIndex = i-particleIndex;
        }
        else{
          relativeIndex = lineMax+i-particleIndex;
        }  
        fill(lineColor, (255*float(relativeIndex)*1/float(lineMax)));
          
        if(flyLine.get(i).pos.x > -100 && flyLine.get(i).pos.y > -100 && flyLine.get(i).pos.x < width + 100 && flyLine.get(i).pos.y < height + 100){ /// Bounderies for deleted lines
          
          
         //if(i != particleIndex-1 && !flyLine.get(i).isSpace){
           //if(i != flyLine.size()-1){
             
            char c = letterSet[int(i%(letterSet.length))];
            text(c, flyLine.get(i).pos.x, flyLine.get(i).pos.y);
           //}
           //else if(particleIndex != 0){
             //line(flyLine.get(i).pos.x, flyLine.get(i).pos.y, flyLine.get(0).pos.x, flyLine.get(0).pos.y);
           //}      
         //}
        }
        
         flyLine.get(i).update(relativeIndex);
      }
    
    }
  
  }
  
  void deleteLine(){
    for(Particle p : flyLine){
      
      p.delete();
    }
  }
  
  

}