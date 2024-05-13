void setup() {
  size(800, 600);
  background(255);
  noLoop();
}

void draw() {
  PImage imgOriginal = loadImage("imgOriginal.jpeg");
  PImage groundTruthOriginal = loadImage("groundTruthOriginal.jpeg");
  PImage groundTruthGerado = loadImage("groundTruthGerado.jpeg");
  PImage imgSegmentada = loadImage("imgSegmentada.jpeg");

  image(imgOriginal, 0, 0, width/4, height/4);
  image(groundTruthOriginal, width/4, 0, width/4, height/4);
  image(groundTruthGerado, width/2, 0, width/4, height/4);
  image(imgSegmentada, 3*width/4, 0, width/4, height/4);

  // Calcular e exibir os falsos positivos e falsos negativos
  int falsosPositivos = calcularFalsosPositivos(groundTruthOriginal, groundTruthGerado, imgSegmentada);
  int falsosNegativos = calcularFalsosNegativos(groundTruthOriginal, groundTruthGerado, imgSegmentada);

  fill(0);
  textAlign(CENTER);
  text("Falsos Positivos: " + falsosPositivos, width/4, height/4 + 20);
  text("Falsos Negativos: " + falsosNegativos, width/2, height/4 + 20);
}

int calcularFalsosPositivos(PImage original, PImage groundTruth, PImage segmentada) {
  int falsosPositivos = 0;
  original.loadPixels();
  groundTruth.loadPixels();
  segmentada.loadPixels();

  for (int i = 0; i < original.pixels.length; i++) {
    if (segmentada.pixels[i] != color(255, 255, 255) && groundTruth.pixels[i] == color(255, 255, 255)) {
      falsosPositivos++;
    }
  }

  return falsosPositivos;
}

int calcularFalsosNegativos(PImage original, PImage groundTruth, PImage segmentada) {
  int falsosNegativos = 0;
  original.loadPixels();
  groundTruth.loadPixels();
  segmentada.loadPixels();

  for (int i = 0; i < original.pixels.length; i++) {
    if (segmentada.pixels[i] == color(255, 255, 255) && groundTruth.pixels[i] != color(255, 255, 255)) {
      falsosNegativos++;
    }
  }

  return falsosNegativos;
}
