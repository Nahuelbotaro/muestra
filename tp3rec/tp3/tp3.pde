PImage referencia;

boolean activadoVerde = false;
boolean activadoRojo = false;
boolean activadoNaranja = false;
boolean activadoVioleta = false;

void setup() {
  size(800, 400);
  referencia = loadImage("13.jpg");
}

void draw() {
  background(0);
  image(referencia, 0, 0, 400, 400);
  noStroke();
  
  int columnas = 2;
  int filas = 2;
  float anchoCelda = 400.0 / columnas;
  float altoCelda = 400.0 / filas;
  
  for (int fila = 0; fila < filas; fila++) {
    for (int columna = 0; columna < columnas; columna++) {
      float posX = 400 + columna * anchoCelda + anchoCelda / 2;
      float posY = fila * altoCelda + altoCelda / 2;
      
      color colorOscuro;
      color colorClaro;
      boolean activado;
      
      if (fila == 0 && columna == 0) {
        colorOscuro = color(0, 150, 50);
        colorClaro = color(150, 255, 200);
        if (mousePressed && mousePosicion(mouseX, mouseY, posX, posY, 90)) {
          activadoVerde = true;
        }
        activado = activadoVerde;
        
      } else if (fila == 0 && columna == 1) {
        colorOscuro = color(190, 0, 30);
        colorClaro = color(255, 150, 170);
        if (mousePressed && mousePosicion(mouseX, mouseY, posX, posY, 90)) {
          activadoRojo = true;
        }
        activado = activadoRojo;
        
      } else if (fila == 1 && columna == 0) {
        colorOscuro = color(140, 70, 0);
        colorClaro = color(255, 220, 100);
        if (mousePressed && mousePosicion(mouseX, mouseY, posX, posY, 90)) {
          activadoNaranja = true;
        }
        activado = activadoNaranja;
        
      } else {
        colorOscuro = color(70, 0, 100);
        colorClaro = color(200, 170, 230);
        if (mousePressed && mousePosicion(mouseX, mouseY, posX, posY, 90)) {
          activadoVioleta = true;
        }
        activado = activadoVioleta;
      }
      
      float angulo = 0;
      if (activado) {
        angulo = frameCount * 0.02;
      }
      
      dibujarCuadrados(posX, posY, colorOscuro, colorClaro, angulo);
    }
  }
}

void dibujarCuadrados(float posX, float posY, color colorOscuro, color colorClaro, float angulo) {
  pushMatrix();
  translate(posX, posY);
  rotate(angulo);
  
  rectMode(CENTER);
  int cantidad = 8;
  float tamanoInicial = 200;
  
  for (int i = 0; i < cantidad; i++) {
    float t = map(i, 0, cantidad - 1, 0, 1);
    color colorActual = lerpColor(colorOscuro, colorClaro, t);
    fill(colorActual);
    
    float tamano = tamanoInicial - i * (tamanoInicial / cantidad);
    rect(0, 0, tamano, tamano);
  }
  
  popMatrix();
}

boolean mousePosicion(float mx, float my, float cx, float cy, float radio) {
  float distancia = dist(mx, my, cx, cy);
  return distancia < radio;
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    activadoVerde = false;
    activadoRojo = false;
    activadoNaranja = false;
    activadoVioleta = false;
  }
}
