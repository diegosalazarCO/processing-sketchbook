class Ball {
  PVector location;
  PVector velocity;
  PVector time;
  float radius;
  color c; 
  int id;
  Ball[] others;
  Ball(float posx, float posy, float ballr, int idBall, Ball[] otherBalls, float t1, float t2, color ballColor){
    location = new PVector( posx, posy,0 );
    velocity = new PVector( 0, 0);
    time = new PVector( t1, t2 );
//    println(t1);
//    println(t2);
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
    } 
    // Rebotar con las paredes
    // Bounce with walls
    else if (location.y < radius/2){
      velocity.y *= -1;
      location.y = radius/2;
    } else if (location.x > height - radius/2) {
      velocity.x *= -1;
      location.x = width - radius/2;
    } else if (location.x < radius/2){
      velocity.x *= -1;
      location.x = radius/2;
    }
    // Calcular distancia y ángulo para chocar
    // Calculate distance and angle for collisions
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
  // Aumentar tiempo para usar con Perlin Noise
  // Increase time to use with Perlin Noise
  void increaseTime(){
    time.x += 0.002;
    time.y += 0.002;
  }
  void move(){
    velocity.limit(10);
//    println(velocity.y);
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
