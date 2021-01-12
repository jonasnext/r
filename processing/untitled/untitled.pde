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
  frameRate(60);
  smooth(8);

  float r = width * 0.2;

  // map sequence

  for (int i = 0; i < x.length; i++) {
    float t = float(i)/(x.length-1);
    t *= TAU;

    x[i] = cos(t) * r;
    y[i] = sin(t) * r;
  }

  background(#ffffff);
}

void draw() {
  translate(width/2, height/2);
  strokeWeight(2);
  stroke(#000000);

  int i = min(x.length - 1, frameCount - 1);
  point(x[i], y[i]);
}
