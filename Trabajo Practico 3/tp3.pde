PImage imgRef;

color[][] paletaColores = {
  {color(144, 238, 80),  color(0, 120, 30)},
  {color(255, 180, 180), color(180, 0, 30)},
  {color(255, 200, 50),  color(120, 50, 10)},
  {color(220, 200, 240), color(80, 30, 130)}
};

int numCapas = 7;
float anguloRotacion = 0;
boolean rotando = false;
float ajusteTamano = 0;

void setup() {
  size(800, 400);
  imgRef = loadImage("13.jpg");
}

void draw() {
  background(30);
  image(imgRef, 0, 0, 400, 400);

  for (int f = 0; f < 2; f++) {
    for (int c = 0; c < 2; c++) {
      int idx = f * 2 + c;
      float centroX = 400 + c * 200 + 100;
      float centroY = f * 200 + 100;

      pushMatrix();
      translate(centroX, centroY);
      rotate(anguloRotacion);
      dibujarCapas(paletaColores[idx][0], paletaColores[idx][1], 170 + ajusteTamano, numCapas);
      popMatrix();
    }
  }

  if (rotando) {
    anguloRotacion += 0.01;
  }
}

// dibuja los cuadrados concéntricos de cada cuadrante
void dibujarCapas(color colorCentro, color colorBorde, float tamano, int cantidadCapas) {
  noStroke();
  rectMode(CENTER);

  for (int i = cantidadCapas - 1; i >= 0; i--) {
    float t = map(i, 0, cantidadCapas - 1, 0, 1);
    color colorActual = lerpColor(colorCentro, colorBorde, t);
    fill(colorActual);

    float lado = map(i, 0, cantidadCapas - 1, tamano / cantidadCapas, tamano);
    rect(0, 0, lado, lado);
  }
}

// determina cuántas capas dibujar según la distancia del mouse al centro
int obtenerCapasPorDistancia(float posX, float posY) {
  float distancia = dist(posX, posY, 600, 200);
  return (int) map(distancia, 0, 280, 12, 3);
}

// al mover el mouse, si está del lado derecho, se actualiza la cantidad de capas
void mouseMoved() {
  if (mouseX > 400) {
    numCapas = obtenerCapasPorDistancia(mouseX, mouseY);
  }
}

// al hacer click se activa/desactiva la rotación
void mousePressed() {
  rotando = !rotando;
}

// teclas + y - controlan el tamaño extra de los cuadrantes
void keyPressed() {
  if (key == '+') {
    ajusteTamano = constrain(ajusteTamano + 10, -60, 60);
  }
  if (key == '-') {
    ajusteTamano = constrain(ajusteTamano - 10, -60, 60);
  }

  // tecla R también activa/desactiva la rotación
  if (key == 'r' || key == 'R') {
    rotando = !rotando;
  }

  // barra espaciadora reinicia los valores
  if (key == ' ') {
    resetearValores();
  }
}

void resetearValores() {
  numCapas = 7;
  anguloRotacion = 0;
  rotando = false;
  ajusteTamano = 0;
}
