PImage img;
PShape model;

float velocidadRotacion = 0.07;

float rotaX, rotaY, rotaZ = 0;

int cols, rows;
int scl = 20;
int w = 1600;
int h = 800;
float flying = 0;
float[][] terrain;

boolean grillaOn = true;

void setup(){
  size(800, 600, P3D);
  frameRate(30);
  
  model = loadShape("dice.obj");
  shapeMode(CORNERS);
  
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
    
}

void dibujarGrilla(int espacio){
  stroke(96,96,0);
  //la grilla se activa y desactiva segun el void keyReleased()
  if (grillaOn == true){
     for(int i = 0; i < width/espacio; i++ ) {
       line(i*espacio, 0, i*espacio, height);
       line(0, i*espacio, width, i*espacio);
     }
   }
}

void terreno3D(){
 
  flying -= 0.1;

  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 50);
      xoff += 0.2;
    }
    yoff += 0.2;
  }

  stroke(255);
  noFill();
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
  translate(w/2, h/2);
  rotateX(-PI/3);

}

void draw(){
  background(0);
    
  if (grillaOn) {
    translate(0, -50,150);
    dibujarGrilla(20);
    translate(0,50,-150);
  }

  terreno3D();
  
  lights();
  
  translate(0,-50,150);
  
  if (keyPressed) {
    if (key == 'W' || key == 'w') {
      rotaX = velocidadRotacion;
      model.rotateX(rotaX);
    }
    if (key == 'S' || key == 's') {
      rotaX = -velocidadRotacion;
      model.rotateX(rotaX);
    }
    if (key == 'A' || key == 'a') {
      rotaY = velocidadRotacion;
      model.rotateY(rotaY);
    }
    if (key == 'D' || key == 'd') {
      rotaY = -velocidadRotacion;
      model.rotateY(rotaY);
    }
    if (key == 'Q' || key == 'q') {
      rotaZ = velocidadRotacion;
      model.rotateZ(rotaZ);
    }
    if (key == 'E' || key == 'e') {
      rotaZ = -velocidadRotacion;
      model.rotateZ(rotaZ);
    }
  }
  
  // *** COMPLETAR ACÁ ***
  // Acá hay que aplicar las rotaciones en función de los ejes datos por las variables que guardan los ángulos
  // OJO con el orden de rotación
  // *** FIN ***
 
  
  stroke(0,255,0);
  line(0, -100, 0, 0, 100, 0);
  
  scale(10);
  shape(model);
  
}

void keyReleased(){
  if (key == 'G' || key == 'g') {
      grillaOn =  !(grillaOn);
    }
   
}
