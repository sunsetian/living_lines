class Particle {
  
  PVector pos;
  PVector originalPos;
  PVector velocity;
  PVector acceleration;
  
  int index;
  int relativeIndex;
  int lineMax;
  
  int activeBehavior;

  float cycle = 0;
  
  boolean isSpace = false;

  Particle(PVector _pos, int _index, int _lineMax ) {
    
    index = _index;
    lineMax = _lineMax;
    pos = _pos;
    originalPos =  new PVector(_pos.x, _pos.y);

    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    
  }
  
  void update(int _relativeIndex){
    
    relativeIndex = _relativeIndex;
    
    PVector tempVel;
    PVector tempAccel;
    float speed;
    
    if(pos.y > -10000 && pos.x > -10000 && pos.y < 10000 && pos.x < 10000){
    
      cycle+=1;
      
      switch(activeBehavior){
        case 1:
           
          break;
        
        case 2:
        
          velocity.add(acceleration);    
          pos.add(velocity);
        
          break;
        
        case 3:
         
          float oscilator =sin(cycle/50);
          //println("oscilator " + oscilator);
          //velocity.mult(oscilator);
          tempVel = new PVector(velocity.x*oscilator*1.0, velocity.y*oscilator*1.0);
          //println("acceleration.x " + acceleration.x );
          //velocity.add(tempAccel);  
          //velocity.mult(oscilator);
          pos.add(tempVel);
        
          break;
         
        case 4:
          pos.x = pos.x*0.97 + originalPos.x*0.03; 
          pos.y = pos.y*0.96 + originalPos.y*0.04; 
  
          break;
          
        case 5:
          float c = TWO_PI*(float(relativeIndex)/float(lineMax));
          velocity = new PVector(cos(c), sin(c));
          pos.add(velocity);
          break;
          
        case 6:
          
          float relativeDelta = float(lineMax-relativeIndex)/float(lineMax);
          speed = relativeDelta*0.1;
          
          tempAccel = new PVector(acceleration.x, acceleration.y);
          
          tempAccel.mult(relativeDelta);
          velocity.add(tempAccel);
          
          tempVel = new PVector(velocity.x, velocity.y);
          tempVel.mult(speed);  
          
          pos.add(tempVel);
        
          break;
      }
    
    
    }
    
    
  }
  
  void reset(PVector _pos, int _index){
    
    index = _index;
    isSpace = false;
    pos = _pos;
    originalPos = new PVector(_pos.x, _pos.y);
    
    setBehavior(activeBehavior, true);
 
  }
  
  void setBehavior(int _activeBehavior, boolean reset){
    
    if(activeBehavior != _activeBehavior || reset){
      activeBehavior = _activeBehavior;
    
      switch(activeBehavior){
        
        case 1:
          velocity = new PVector(0,0);
          acceleration = new PVector(0,0);
          break;
          
        case 2:
          float a = random(TWO_PI);
          float speed = random(0.01,0.1);
          velocity = new PVector(cos(a), sin(a));
          velocity.mult(speed*10);       
          acceleration = new PVector(0,0.005);  
          break;
        
        case 3:
          //velocity = new PVector(0,0);
          float b = random(TWO_PI);
          velocity = new PVector(cos(b), sin(b));
          velocity.mult(0.2);
          break;
          
        case 4:
          //velocity = new PVector(0,0);
          acceleration = new PVector(0,0);
          break;
        
        case 5:
          float c = TWO_PI*(float(index)/float(lineMax));
          velocity = new PVector(cos(c), sin(c));
          velocity.mult(1.2);       
          //acceleration = new PVector(0,0);
          break;
          
        case 6:
          //float d = random(TWO_PI);
          //float speed_d = float(index)/float(lineMax);
          //velocity = new PVector(cos(d), sin(d));
          velocity = new PVector(0, 0);
          //velocity.mult(2.0);       
          acceleration = new PVector(0,-0.5);  
          break;
      }
    }  
  }
  
  void delete(){
    pos = new PVector(-10000, -10000);
    originalPos = new PVector(-10000, -10000);
  }
  
  
}