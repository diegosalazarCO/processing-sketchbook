import processing.opengl.*;

int numBalls = 0;
boolean gravityOn = true;
// Inicializar arreglo de objetos
// Initialize array of objects ( Box and Ball)
Figure[] cubes = new Figure[2];
Ball[] balls = new Ball[numBalls];

void setup(){
  size(500, 500, OPENGL);
  smooth();
  // Crear el cubo
  // Create the cube in array
  for (int i = 0; i < cubes.length; i++){
    cubes[i] = new Figure( random(width), random(height), random(50), random(360), random(50,70), random(100), random(100, 1000), random(5000,10000),color( random(70), random(10), random(130), 200 ), int(random(4,8)) );
  }
}

void draw(){
  background( 80);
  for (int i = 0; i < cubes.length; i++){
    cubes[i].rotation();
    cubes[i].increaseTime();
    cubes[i].movement();
    cubes[i].display();
  }
  for ( int i = 0; i < balls.length; i++){
//    if ( gravityOn){
//      balls[i].gravity();
//    } else{
//      balls[i].gravityZero();
//    }
    balls[i].move();
    balls[i].collide();
    balls[i].display();
  }
}
// Crear una bola cuando se presiona el mouse
// Create a new ball when mouse is pressed

void keyPressed(){
  if (key == CODED){
    if (keyCode == DOWN){
      gravityOn = false;
    }
    else if(keyCode == UP){
      gravityOn = true;
    }
  }
}
void mousePressed(){
  Ball b = new Ball( mouseX, mouseY, random(10, 40), numBalls, balls, random(100), random(500, 1000), color( random(255), random(255), random(255), 127 ) );
  balls = (Ball[]) append(balls, b);
  numBalls++;
}
class Ball {
  PVector location;
  PVector velocity;
  PVector time;
  float radius;
  color c; 
  float gravity = 0.1;
  int id;
  Ball[] others;
  Ball(float posx, float posy, float ballr, int idBall, Ball[] otherBalls, float t1, float t2, color ballColor){
    location = new PVector( posx, posy,0 );
    velocity = new PVector( 0, 0);
    time = new PVector( t1, t2 );
    println(t1);
    println(t2);
    radius = ballr;
    println("Radio: " + radius);
    c = ballColor;
    id = idBall;
    others = otherBalls;
  }
  
  // Rebotar y disminuir la velocidad 
  // Bounce and reduce speed
  void collide(){
    // Walls // Muros
    if (location.y > height - radius/2){
      velocity.y *= -0.9;
      location.y = height - radius/2;
    } else if (location.y < radius/2){
      velocity.y *= -1;
      location.y = radius/2;
    } else if (location.x > height - radius/2) {
      velocity.x *= -1;
      location.x = width - radius/2;
    } else if (location.x < radius/2){
      velocity.x *= -1;
      location.x = radius/2;
    }
    for (int i = 0; i < id; i++){
//      float dis = dist( others[i].location.x, others[i].location.y, location.x, location.y);
    float dx = others[i].location.x - location.x;
//    println("dx: " + dx);
    float dy = others[i].location.y - location.y;
//    println("dy: " + dy);
    float dis = sqrt(dx*dx + dy*dy);
//      println("Distancia: " + dis);
    float minDist = others[i].radius + radius;
//      println("Min Dis: " + minDist);
    if ( dis < minDist){
//      println("golpe!");
      float angle = atan2(dy, dx);
      float targetX = location.x + cos(angle) * minDist;
      float targetY = location.y + sin(angle) * minDist;
      float ax = (targetX - others[i].location.x) * 0.05;
      float ay = (targetY - others[i].location.y) * 0.05;
      velocity.x -= ax;
      velocity.y -= ay;
      others[i].velocity.x += ax;
      others[i].velocity.y += ay;        
      }
    } 
  }
  void increaseTime(){
    time.x += 0.002;
    time.y += 0.002;
  }
  void move(){
    if (gravityOn){
      location.add(velocity);
      velocity.y += gravity;
    } else {
      increaseTime();
      location.x = map(noise(time.x), 0, 1, 0, width);
      location.y = map(noise(time.y), 0, 1, 0, height);
    }
  }
  
  void display(){
    fill(c);
    stroke(0);
    ellipse( location.x, location.y, radius, radius);
  }
}
class Figure { 
  PVector location;
  PVector time;
  color c;
  float radius , R;
  float theta;
  int detailS;
  
  Figure( float posX, float posY, float posZ, float angle, float balloonR, float t1, float t2, float t3, color cubeColor, int detail ){
  location = new PVector( posX, posY, posZ );
  time = new PVector( t1, t2, t3 );
  c = cubeColor;
  radius = balloonR;
  theta = radians(angle);
  detailS = detail;
  }
  void rotation(){
    theta += 0.01;
  }
  
  void increaseTime(){
    time.x += 0.003;
    time.y += 0.004;
    time.z += 0.004;
    
  }
  
  void movement(){
    location.x = map(noise(time.x), 0, 1, 0, width);
    location.y = map(noise(time.y), 0, 1, 0, height);
    location.z = map(noise(time.z), 0, 1, -100, 100);
    R = map(noise(time.x, time.y, time.z), 0, 1, 20, radius);
//      location.set(map(noise(time.x), 0, 1, 0, width),map(noise(time.y), 0, 1, 0, height),map(noise(time.z), 0, 1, -50, 100) );
  }
  
  void display(){
    pushMatrix();
    translate( location.x, location.y, location.z);
    rotateZ(theta*radius/200);
    rotateX(theta*radius/mouseX*0.1);
    rotateY(theta*radius/mouseY*0.1);
    lights();
    fill(c);
    sphereDetail(detailS);
    sphere(R);
    popMatrix();
  }
  
}

