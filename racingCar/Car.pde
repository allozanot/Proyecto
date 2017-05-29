class Car {
  Scene scene;
  InteractiveFrame frame;
  int grabsMouseColor;//color
  int avatarColor;

  // cars
  PShape car, car1, car2, car3, car4, car5, car6, car7;
  float ry, rx, carSize;

  // fields
  PVector pos, vel, acc, ali, coh, sep; // pos, velocity, and acceleration in
  // a vector datatype
  float neighborhoodRadius; // radius in which it looks for fellow boids
  float maxSpeed = 2; // maximum magnitude for the velocity vector

  // constructors
  Car(Scene scn, PVector inPos) {
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
    car = loadShape("car-farara-sport-black.obj");
    car.scale(carSize);
    car.rotateZ(PI);
    car.rotateY(PI);
    car1 = loadShape("car-farara-sport-black.obj");
    car1.scale(carSize);
    car1.rotateZ(PI);
    car1.rotateY(PI);
    car2 = loadShape("car-groupc-1-green.obj");
    car2.scale(carSize);
    car2.rotateZ(PI);
    car2.rotateY(PI);
    car3 = loadShape("car-groupc-2-grey.obj");
    car3.scale(carSize);
    car3.rotateZ(PI);
    car3.rotateY(PI);
    car4 = loadShape("car-kart-orange.obj");
    car4.scale(carSize);
    car4.rotateZ(PI);
    car4.rotateY(PI);
    car5 = loadShape("car-lamba-sport-red.obj");
    car5.scale(carSize);
    car5.rotateZ(PI);
    car5.rotateY(PI);
    car6 = loadShape("car-parsche-sport-violet.obj");
    car6.scale(carSize);
    car6.rotateZ(PI);
    car6.rotateY(PI);
    car7 = loadShape("car-formula-blue.obj");
    car7.scale(carSize);
    car7.rotateZ(PI);
    car7.rotateY(PI);
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
    velocity *= 3;
    
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
    checkBounds();
    frame.setPosition(new Vec(pos.x, pos.y, pos.z));
  }

  void rotateCar(float y) {
    car.rotateY(y);
    car1.rotateY(y);
    car2.rotateY(y);
    car3.rotateY(y);
    car4.rotateY(y);
    car5.rotateY(y);
    car6.rotateY(y);
    car7.rotateY(y);
  }

  void checkBounds() {
    if (pos.x > trackWidth)
      pos.x = trackWidth-15;
    if (pos.x < 0)
      pos.x = 15;
    if (pos.y > trackHeight)
      pos.y = trackHeight-15;
    if (pos.y < 0)
      pos.y = 15;
    if (pos.z > trackDepth)
      pos.z = trackDepth-15;
    if (pos.z < 0)
      pos.z = 15;
  }
  
  // check if this boid's frame is the avatar
  boolean isAvatar() {
    return scene.avatar() == null ? false : scene.avatar().equals(frame) ? true : false;
  }

  void render() {
    pushStyle();
    pushMatrix();
    frame.applyTransformation();
    // setAvatar according to scene.motionAgent().inputGrabber()
    if (frame.grabsInput())       
      if (!isAvatar())
        scene.setAvatar(frame);
    shape(car);
    popMatrix();
    popStyle();
  }
  
  void skin (int i){
    switch(i){
      case 1:
        car = car1;
        break;
      case 2:
        car = car2;
        break;
      case 3:
        car = car3;
        break;
      case 4:
        car = car4;
        break;
      case 5:
        car = car5;
        break;
      case 6:
        car = car6;
        break;
    }
  }
}