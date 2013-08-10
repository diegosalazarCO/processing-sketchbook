import processing.opengl.*;

int numBalls = 3;
float gravity = 0.1;
boolean gravityOn = false;
// Inicializar arreglo de objetos ( Figura y Bola)
// Initialize array of objects ( Figure and Ball)
Figure[] spheres = new Figure[2];
Ball[] balls = new Ball[numBalls];

void setup(){
  size(600, 600, OPENGL);
  smooth();
  // Crear las esferas y pelotas
  // Create spheres and balls
  for (int i = 0; i < spheres.length; i++){
    spheres[i] = new Figure( random(width), random(height), random(50), random(360), random(50,70), random(100), random(100, 1000), random(5000,10000),color( random(50,100), random(60), random(20,130), 200 ), int(random(4,8)) );
  }
  for (int i = 0; i < balls.length; i++){
    balls[i] = new Ball(random(width), random(height), random(10, 40), i, balls, random(100), random(500, 1000), color( random(200), random(100, 200), random(80, 220), 127 ) );
  }
}

void draw(){
  background( 10);
  for (int i = 0; i < spheres.length; i++){
    spheres[i].rotation();
    spheres[i].increaseTime();
    spheres[i].movement();
    spheres[i].display();
  }
  for ( int i = 0; i < balls.length; i++){
    balls[i].move();
    balls[i].collide();
    balls[i].display();
  }
}

// Cambiar modo gravedad con teclas
// Change gravity mode with keyboard
void keyPressed(){
  if (key == CODED){
    if (keyCode == UP){
      gravityOn = false;
    }
    else if(keyCode == DOWN){
      gravityOn = true;
    }
  }
}
// capturar imagen 
// image screenshot
void keyTyped(){
  if (key == 'c'){
    save("picture1.jpg");
  }
}
// Crear una bola cuando se presiona el mouse
// Create a new ball when mouse is pressed
void mousePressed(){
  Ball b = new Ball( mouseX, mouseY, random(10, 40), numBalls, balls, random(100), random(500, 1000), color( random(200), random(100, 200), random(80, 220), 127 ) );
  balls = (Ball[]) append(balls, b);
  numBalls++;
}
