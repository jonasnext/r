//
// untitled.java
// processing
//

int c = 100;
float[] x = new float[c];
float[] y = new float[c];
float[] z = new float[c];

color slate = color(56, 56, 54);
color darktitanium = color(85, 78, 64);
color lighttitanium = color(194, 173, 149);
color gold = color(187, 144, 97);
color rosegold = color(236, 165, 132);
color yellowgold = color(212, 166, 124);
color mango = color(255, 187, 84);

color[] colors = {
  slate,
  darktitanium,
  lighttitanium,
  gold,
  rosegold,
  yellowgold,
  mango
};

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

  int cIndex = int(random(colors.length-1));
  stroke(colors[cIndex]);

  int i = min(x.length - 1, frameCount - 1);
  point(x[i], y[i]);
}
