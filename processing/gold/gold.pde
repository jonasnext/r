//
// untitled.java
// processing
//

int c = 100;
float[] x = new float[c];
float[] y = new float[c];
float[] z = new float[c];

void setup() {
  size(800, 800, P2D);
  frameRate(120);
  smooth(8);

  for (int i = 0; i < x.length; i++) {
    float t = i * PI*(3-sqrt(5));

    float a = sin(t)*i*8;
    float b = cos(t)*i*8;

    x[i] = a;
    y[i] = b;
  }

  background(#ffffff);
}

void draw() {
  translate(width/2, height/2);
  strokeWeight(16);
  stroke(color(0, 0, 0, 80));

  int i = min(x.length - 1, frameCount - 1);
  point(x[i], y[i]);
}
