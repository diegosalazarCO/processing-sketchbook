class Figure { 
  PVector location;
  PVector time;
  PVector velocity;
  color c;
  float radius , R;
  float theta;
  int detailS;
  
  Figure( float posX, float posY, float posZ, float angle, float sphereR, float t1, float t2, float t3, color sphereColor, int detail ){
  location = new PVector( posX, posY, posZ );
  time = new PVector( t1, t2, t3 );
  velocity = PVector.random3D();
  c = sphereColor;
  radius = sphereR;
  theta = radians(angle);
  detailS = detail;
  }
  void rotation(){
    theta += 0.03;
  }
  
  void increaseTime(){
    time.x += 0.003;
    time.y += 0.004;
    time.z += 0.004;
    
  }
  
  void movement(){
    if (!gravityOn){
    location.x = map(noise(time.x), 0, 1, 0, width);
    location.y = map(noise(time.y), 0, 1, 0, height);
    location.z = map(noise(time.z), 0, 1, -100, 100);
    R = map(noise(time.x, time.y, time.z), 0, 1, 20, radius);
    } else {
      location.add(velocity);
      velocity.y += gravity;
      velocity.limit(15);
      if (location.x > width - R || location.x < R) {
        velocity.x*=-1;
      }
      if (location.y > height - R || location.y < R) {
        velocity.y*=-1;
      }
      if (location.z > 100 || location.z < -100) {
        velocity.z*=-1;
      }      
    }
//      location.set(map(noise(time.x), 0, 1, 0, width),map(noise(time.y), 0, 1, 0, height),map(noise(time.z), 0, 1, -50, 100) );
  }
  
  void display(){
    pushMatrix();
    translate( location.x, location.y, location.z);
    rotateZ(theta*radius/200);
    rotateX(theta*radius/mouseX*0.01);
    rotateY(theta*radius/mouseY*0.01);
    lights();
    fill(c);
    sphereDetail(detailS);
    sphere(R);
    popMatrix();
  }
  
}
