class Track {
  Scene scene;
  InteractiveFrame frame;

  // pieze of track
  PShape t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15;

  float ry, rx, trackSize;

  // fields
  PVector pos, vel, acc, ali, coh, sep; // pos, velocity, and acceleration in
  // a vector datatype

  // constructors
  Track(Scene scn, PVector inPos) {
    scene = scn;
    pos = new PVector();
    pos.set(inPos);
    frame = new InteractiveFrame(scene);  
    frame.setPosition(new Vec(pos.x, pos.y, pos.z));    
    trackSize = 20.0;
    t1 = loadShape("track-checkpoint.obj");
    t1.scale(trackSize);
    t2 = loadShape("track-corner-large.obj");
    t2.scale(trackSize);
    t3 = loadShape("track-corner-small.obj");
    t3.scale(trackSize);
    t4 = loadShape("track-left-right-large.obj");
    t4.scale(trackSize);
    t5 = loadShape("track-pit-entrylane-small.obj");
    t5.scale(trackSize);
    t6 = loadShape("track-pit-entry-large.obj");
    t6.scale(trackSize);
    t7 = loadShape("track-pit-exitlane-small.obj");
    t7.scale(trackSize);
    t8 = loadShape("track-pit-exit-large.obj");
    t8.scale(trackSize);
    t9 = loadShape("track-right-left-large.obj");
    t9.scale(trackSize);
    t10 = loadShape("track-start-finish.obj");
    t10.scale(trackSize);
    t11 = loadShape("track-straight-small.obj");
    t11.scale(trackSize);
    t12 = loadShape("track-tire.obj");
    t12.scale(trackSize);
    t13 = loadShape("terrain-grass.obj");
    t13.scale(trackSize);
    t14 = loadShape("building-pitlane.obj");
    t14.scale(trackSize);
    t15 = loadShape("building-tribune.obj");
    t15.scale(trackSize);
  }

  // check if this boid's frame is the avatar
  boolean isAvatar() {
    return scene.avatar() == null ? false : scene.avatar().equals(frame) ? true : false;
  }

  void render() {
    rotateZ(PI);
    rotateY(-PI/2);
    pushMatrix();
    translate(1380,-500, 260);
    pushMatrix();
    shape(t1);
    translate(0,0,160);
    shape(t13);
    translate(0,0,160);
    shape(t13);
    translate(-160,0,0);
    shape(t13);
    translate(0,0,-160);
    shape(t13);
    translate(-160,0,0);
    shape(t13);
    translate(0,0,160);
    shape(t13);
    translate(-160,0,0);
    shape(t13);
    translate(0,0,-160);
    shape(t13);
    translate(-160,0,0);
    shape(t13);
    translate(0,0,160);
    shape(t13);
    translate(-160,0,0);
    shape(t13);
    translate(0,0,-160);
    shape(t13);
    translate(-160,0,0);
    shape(t13);
    translate(0,0,160);
    shape(t13);
    translate(-160,0,0);
    shape(t13);
    translate(-160,0,320);
    shape(t13);
    translate(480,0,0);
    shape(t13);
    translate(160,0,0);
    shape(t13);
    translate(640,0,0);
    shape(t13);
    translate(160,0,0);
    shape(t13);
    translate(160,0,0);
    shape(t13);
    popMatrix();
    pushMatrix();
    translate(240,0,80);
    shape(t2);
    translate(80,0,-240);
    shape(t13);
    translate(-160,0,0);
    shape(t13);
    translate(-160,0,0);
    shape(t13);
    translate(-160,0,0);
    shape(t13);
    translate(-160,0,0);
    shape(t15);
    translate(-160,0,0);
    shape(t15);
    translate(-160,0,0);
    shape(t13);
    translate(-160,0,0);
    shape(t13);
    translate(-160,0,0);
    shape(t13);
    translate(-160,0,0);
    shape(t13);
    translate(-160,0,0);
    shape(t13);
    
    popMatrix();
    pushMatrix();
    translate(240,0,400);
    rotateY(-PI/2);
    shape(t2);
    popMatrix();
    pushMatrix();
    translate(-160,0,0);
    rotateY(PI/2);
    shape(t11);
    translate(0,0,-160);
    shape(t11);
    translate(0,0,-160);
    shape(t11);
    translate(0,0,-160);
    rotateY(PI/2);
    shape(t10);
    translate(160,0,0);
    rotateY(PI/2);
    shape(t11);
    translate(0,0,160);
    shape(t11);
    translate(80,0,240);
    rotateY(PI);
    shape(t2);
    translate(-240,0,-80);
    rotateY(PI/2);
    shape(t11);
    translate(0,0,-160);
    shape(t3);
    translate(-160,0,0);
    rotateY(PI);
    shape(t3);
    translate(0,0,160);
    rotateY(PI);
    shape(t3);
    translate(-160,0,0);
    rotateY(PI/2);
    shape(t3);
    translate(-160,0,0);
    rotateY(PI);
    shape(t3);
    translate(0,0,160);
    rotateY(PI/2);
    shape(t12);
    translate(-160,0,0);
    rotateY(PI/2);
    shape(t11);
    translate(80,0,-240);
    rotateY(PI/2);
    shape(t4);
    translate(240,0,80);
    rotateY(-PI/2);
    shape(t3);
    translate(-160,0,0);
    rotateY(PI);
    shape(t3);
    translate(0,0,160);
    rotateY(PI/2);
    shape(t12);
    popMatrix();
    popMatrix();
  }
}