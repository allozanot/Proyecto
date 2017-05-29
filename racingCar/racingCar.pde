/**

 - Library:
   * ProScene 3.0.0. Credit Jean Pierre Charalambos.
 - Resources:
   * Racing Assets v2. License (CC0), you can use these graphics in personal and commercial projects. Credit eracoon or www.racoon-media.nl.
   * Street Light (Lamp) 3D Model, license commercial use. Credit tyrosmith (https://free3d.com).
 - Controls: 
   * Press 'o' to activate NPC o user car.
   * Press 'i' to accelerate the car.
   * Press 'j' to turn left the car.
   * Press 'l' to turn right the car.
   * Press 'k' to desaccelerate/stop the car.
   * Press '1-6' to change model of the car.
   * Press '8-9-0' to change light of the world (day, sunset, night).
   * Press ' ' to restore view to the world.
   * Press 'p' to turn on/off lights.
   * Press click on car to change thirdPerson view.
*/

import remixlab.proscene.*;
import remixlab.dandelion.geom.*;
import remixlab.dandelion.core.*;

Scene scene;
InteractiveFrame keyFrame[];
KeyFrameInterpolator kfi;
int nbKeyFrames;

Trackable lastAvatar;
int trackWidth = 1000;  
int trackHeight = 500;  
int trackDepth = 1800;  
int skin;
boolean avoidWalls = true;
boolean triggered;
boolean inThirdPerson;
float hue = 255;
Car user, npc;
ArrayList<CarNPC> racing;
ArrayList<Track> circuit;
int ambient = 1;
boolean enabledLights = false;
PShape streetLight;
boolean turnRight = false;
boolean turnLeft = false;
boolean ghostPilot = true;
int countgiro = 0;
int velocity = 0;

public void setup() {
  size(600, 800, P3D);
  skin = 1;
  nbKeyFrames = 16;
  scene = new Scene(this);
  scene.mouseAgent().setPickingMode(MouseAgent.PickingMode.CLICK);
  scene.setAxesVisualHint(false);
  scene.setGridVisualHint(false);
  scene.setBoundingBox(new Vec(0, 0, 0), new Vec(trackWidth, trackHeight, trackDepth));
  scene.showAll();
  streetLight = loadShape("StreetLamp.obj");
  streetLight.scale(5.0);
  streetLight.rotateZ(PI);
  circuit = new ArrayList();
  circuit.add(new Track(scene, new PVector(-trackWidth, trackHeight, trackDepth)));
  racing = new ArrayList();
  racing.add(new CarNPC(scene, new PVector(trackWidth/4, trackHeight-20, (trackDepth/2)+20)));

  user = new Car(scene, new PVector(trackWidth/4, trackHeight-20, (trackDepth/2)+20));
  kfi = new KeyFrameInterpolator(scene);
  kfi.setLoopInterpolation();
  keyFrame = new InteractiveFrame[nbKeyFrames];
  
  keyFrame[0] = new InteractiveFrame(scene);
  keyFrame[0].setPosition(trackWidth/4, trackHeight-20,(trackDepth/2)+20);
  kfi.addKeyFrame(keyFrame[0]);  //<>//
  keyFrame[1] = new InteractiveFrame(scene);
  keyFrame[1].setPosition(270, 480, 270); 
  kfi.addKeyFrame(keyFrame[1]);
  keyFrame[2] = new InteractiveFrame(scene);
  keyFrame[2].setPosition(380, 480, 130); 
  kfi.addKeyFrame(keyFrame[2]); 
  keyFrame[3] = new InteractiveFrame(scene);
  keyFrame[3].setPosition(650, 480, 120); 
  kfi.addKeyFrame(keyFrame[3]); 
  keyFrame[4] = new InteractiveFrame(scene);
  keyFrame[4].setPosition(800, 480, 270); 
  kfi.addKeyFrame(keyFrame[4]); 
  keyFrame[5] = new InteractiveFrame(scene);
  keyFrame[5].setPosition(880, 480, 320); 
  kfi.addKeyFrame(keyFrame[5]); 
  keyFrame[6] = new InteractiveFrame(scene);
  keyFrame[6].setPosition(740, 480, 450); 
  kfi.addKeyFrame(keyFrame[6]); 
  keyFrame[7] = new InteractiveFrame(scene);
  keyFrame[7].setPosition(740, 480, 880); 
  kfi.addKeyFrame(keyFrame[7]); 
  keyFrame[8] = new InteractiveFrame(scene);
  keyFrame[8].setPosition(880, 480, 1100); 
  kfi.addKeyFrame(keyFrame[8]); 
  keyFrame[9] = new InteractiveFrame(scene);
  keyFrame[9].setPosition(740, 480, 1300); 
  kfi.addKeyFrame(keyFrame[9]); 
  keyFrame[10] = new InteractiveFrame(scene);
  keyFrame[10].setPosition(740, 480, 1500); 
  kfi.addKeyFrame(keyFrame[10]); 
  keyFrame[11] = new InteractiveFrame(scene);
  keyFrame[11].setPosition(640, 480, 1620); 
  kfi.addKeyFrame(keyFrame[11]); 
  keyFrame[12] = new InteractiveFrame(scene);
  keyFrame[12].setPosition(500, 480, 1700); 
  kfi.addKeyFrame(keyFrame[12]); 
  keyFrame[13] = new InteractiveFrame(scene);
  keyFrame[13].setPosition(300, 480, 1600); 
  kfi.addKeyFrame(keyFrame[13]); 
  keyFrame[14] = new InteractiveFrame(scene);
  keyFrame[14].setPosition(270, 480, 1500); 
  kfi.addKeyFrame(keyFrame[14]); 
  keyFrame[15] = new InteractiveFrame(scene);
  keyFrame[15].setPosition(250, 480, 920); 
  kfi.addKeyFrame(keyFrame[15]); 
  kfi.startInterpolation();  
  scene.startAnimation();

}

public void draw() {
  if (inThirdPerson && scene.avatar()==null) {
    inThirdPerson = false;
    adjustFrameRate();
  } else if (!inThirdPerson && scene.avatar()!=null) {
    inThirdPerson = true;
    adjustFrameRate();
  }

  switch(ambient){
    case 1:
      background(54, 198, 242);
      ambientLight(255, 255, 255);
      break;
    case 2:
      background(239, 155, 90);
      ambientLight(242, 210, 54);
      break;
    case 3:
      background(38, 66, 156);
      ambientLight(0, 0, 0);
      break;
  }
  directionalLight(255, 255, 255, 200, 200, 50);
  if (enabledLights){
    pushMatrix();
    translate(width/2, (height/2 - 200), 500);
    spotLight(200,200,200, 200, 200, 300, -10, 0, 0, PI/5, 1);
    spotLight(200,200,200, 200, 200, 1000, -10, 0, 0, PI/5, 1);
    spotLight(200,200,200, 700, 200, 300, -10, 0, 0, PI/5, 1);
    spotLight(200,200,200, 700, 200, 1000, -10, 0, 0, PI/5, 1);
    popMatrix();
  }
  pushMatrix();
  translate((width/2)+80, height-310, 850);
  shape(streetLight);
  translate(450,0,0);
  shape(streetLight);
  translate(0,0,600);
  shape(streetLight);
  translate(-450,0,0);
  shape(streetLight);
  popMatrix();
  noFill();
  stroke(150);
  line(0, 0, 0, 0, trackHeight, 0);
  line(0, 0, trackDepth, 0, trackHeight, trackDepth);
  line(0, 0, 0, trackWidth, 0, 0);
  line(0, 0, trackDepth, trackWidth, 0, trackDepth);

  line(trackWidth, 0, 0, trackWidth, trackHeight, 0);
  line(trackWidth, 0, trackDepth, trackWidth, trackHeight, trackDepth);
  line(0, trackHeight, 0, trackWidth, trackHeight, 0);
  line(0, trackHeight, trackDepth, trackWidth, trackHeight, trackDepth);

  line(0, 0, 0, 0, 0, trackDepth);
  line(0, trackHeight, 0, 0, trackHeight, trackDepth);
  line(trackWidth, 0, 0, trackWidth, 0, trackDepth);
  line(trackWidth, trackHeight, 0, trackWidth, trackHeight, trackDepth);

  triggered = scene.timer().trigggered();
  if (ghostPilot){
    for (CarNPC carNPC : racing) {
      carNPC.render(kfi);
    }
  } else {
    user.skin(skin);
    user.render();
  }

  if (turnRight){
    countgiro++;
    if (countgiro > 15){
      countgiro -= 16; 
    }
    pushMatrix();
    user.rotateCar(-0.2);
    popMatrix();
    turnRight = false;
  }
  if (turnLeft){
    countgiro--;
    if (countgiro < 0){
      countgiro += 16;
    }
    if (countgiro > 15){
      countgiro -= 16; 
    }
    pushMatrix();
    user.rotateCar(0.2);
    popMatrix();
    turnLeft = false;
  }
  if (velocity != 0){
    user.moveCar(velocity, countgiro);
  }

  for (Track track : circuit) {
    track.render();
  }
}

void adjustFrameRate() {
  if (scene.avatar() != null)
    frameRate(1000/scene.animationPeriod());
  else
    frameRate(60);
  if (scene.animationStarted())
    scene.restartAnimation();
}

void keyPressed() {
  switch(key){
    case '1':
      skin = 1;
      break;
    case '2':
      skin = 2;
      break;
    case '3':
      skin = 3;
      break;
    case '4':
      skin = 4;
      break;
    case '5':
      skin = 5;
      break;
    case '6':
      skin = 6;
      break;
    case '8':
      ambient = 1;
      break;
    case '9':
      ambient = 2;
      break;
    case '0':
      ambient = 3;
      break;
    case 'p':
      enabledLights = !enabledLights;
      break;
    case ' ':
      if ( scene.avatar() == null && lastAvatar != null)
        scene.setAvatar(lastAvatar);
      else
        lastAvatar = scene.resetAvatar();
      break;
    case 'i':
      velocity += 1;
      if (velocity > 3){
        velocity = 3;
      }
      break;
    case 'j':
      turnLeft = !turnLeft;
      break;
    case 'k':
      velocity -= 1;
      if (velocity < 0){
        velocity = 0;
      }
      break;
    case 'l':
      turnRight = !turnRight;
      break;
    case 'o':
      ghostPilot = !ghostPilot;
      break;
  }
  if ((key == ENTER) || (key == RETURN))
    kfi.toggleInterpolation();
  if (key == 'v')
    kfi.setInterpolationSpeed(kfi.interpolationSpeed()-0.25f);
  if (key == 'b')
    kfi.setInterpolationSpeed(kfi.interpolationSpeed()+0.25f);
}