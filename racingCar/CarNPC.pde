class CarNPC {
  Scene scene;
  InteractiveFrame frame;
  int grabsMouseColor;//color
  int avatarColor;

  // cars
  PShape car;
  float ry, rx, carSize;

  // fields
  PVector pos, vel, acc, ali, coh, sep; // pos, velocity, and acceleration in
  // a vector datatype
  float neighborhoodRadius; // radius in which it looks for fellow boids
  float maxSpeed = 2; // maximum magnitude for the velocity vector

  // constructors
  CarNPC(Scene scn, PVector inPos) {
    scene = scn;
    grabsMouseColor = color(0, 0, 255);
    avatarColor = color(255, 0, 0);    
    pos = new PVector();
    pos.set(inPos);
    frame = new InteractiveFrame(scene);  
    frame.setPosition(new Vec(pos.x, pos.y, pos.z));   
    frame.setTrackingEyeAzimuth(-PApplet.PI*(-1.0));
    frame.setTrackingEyeInclination(PApplet.PI*(0.8));
    frame.setTrackingEyeDistance(scene.radius()/4);
    vel = new PVector(random(-1, 1), random(-1, 1), random(1, -1));
    acc = new PVector(0, 0, 0);
    neighborhoodRadius = 100;
    carSize = 25.0;
    car = loadShape("car-farara-sport-yellow.obj");
    car.scale(carSize);
    car.rotateZ(PI);
    car.rotateY(PI);
  }

  void scatter() {
  }

  // //------------------------------------

  void move() {
    vel.add(acc); // add acceleration to velocity
    vel.limit(maxSpeed); // make sure the velocity vector magnitude does not
    // exceed maxSpeed
    pos.add(vel); // add velocity to position
    frame.setPosition(new Vec(pos.x, pos.y, pos.z));
    acc.mult(0); // reset acceleration
  }

  void moveCar(int velocity, int state){
    float x = 0.0;
    float y = 0.0;
    float z = 0.0;
    velocity *= 2;
    switch (state){
      case 0:
        acc = new PVector(0, 0, -velocity);
        break;
      case 1:
        acc = new PVector(0.6, 0, -velocity);
        break;
      case 2:
        acc = new PVector(1.2, 0, -velocity);
        break;
      case 3:
        acc = new PVector(2, 0, -velocity);
        break;
      case 4:
        acc = new PVector(velocity, 0, 0);
        break;
      case 5:
        acc = new PVector(2, 0, velocity);
        break;
      case 6:
        acc = new PVector(1.2, 0, velocity);
        break;
      case 7:
        acc = new PVector(0.6, 0, velocity);
        break;
      case 8:
        acc = new PVector(0, 0, velocity);
        break;
      case 9:
        acc = new PVector(-0.6, 0, velocity);
        break;
      case 10:
        acc = new PVector(-1.2, 0, velocity);
        break;
      case 11:
        acc = new PVector(-2.0, 0, velocity);
        break;
      case 12:
        acc = new PVector(-velocity, 0, 0);
        break;
      case 13:
        acc = new PVector(-2.0, 0, -velocity);
        break;
      case 14:
        acc = new PVector(-1.2, 0, -velocity);
        break;
      case 15:
        acc = new PVector(-0.6, 0, -velocity);
        break;
    }
    pos.add(acc);
    frame.setPosition(new Vec(pos.x, pos.y, pos.z));
  }

  void rotateCar(float y) {
    car.rotateY(y);
  }

  void checkBounds() {
    if (pos.x > trackWidth)
      pos.x = 0;
    if (pos.x < 0)
      pos.x = trackWidth;
    if (pos.y > trackHeight)
      pos.y = 0;
    if (pos.y < 0)
      pos.y = trackHeight;
    if (pos.z > trackDepth)
      pos.z = 0;
    if (pos.z < 0)
      pos.z = trackDepth;
  }

  // check if this boid's frame is the avatar
  boolean isAvatar() {
    return scene.avatar() == null ? false : scene.avatar().equals(frame) ? true : false;
  }

  void render(KeyFrameInterpolator kfi) {
    pushStyle();

    pushMatrix();
    //frame.applyTransformation();
    scene.applyTransformation(kfi.frame());
    // setAvatar according to scene.motionAgent().inputGrabber()
    if (frame.grabsInput())       
      if (!isAvatar())
        scene.setAvatar(frame);
    shape(car);
    popMatrix();
    popStyle();
  }
}