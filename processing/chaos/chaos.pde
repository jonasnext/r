//
// untitled.java
// processing
//

static class XYZTransformer {
  static float map(float v, float a, float b, float x, float y) {
    return x+(v-a)*(y-x)/(b-a);
  }

  // scale (= aspect ratio)

  static void scale(float[] x, float[] y, float w, float h) {
    float minx = min(x);
    float maxx = max(x);
    float miny = min(y);
    float maxy = max(y);

    float rx = maxx - minx;
    float ry = maxy - miny;

    float zminx = -w;
    float zmaxx = w;
    float zminy = -h;
    float zmaxy = h;

    float zrx = (zmaxx - zminx);
    float zry = (zmaxy - zminy);

    float scalex = zrx / rx;
    float scaley = zry / ry;

    if (scalex < scaley) {
      assert(rx > ry);
      minx = minx + (ry-rx)/2;
      maxx = maxx - (ry-rx)/2;
    } else {
      assert(rx < ry);
      miny = miny + (ry-rx)/2;
      maxy = maxy - (ry-rx)/2;
    }

    assert(x.length == y.length);

    for (int i = 0; i < x.length; i++) {
      x[i] = map(x[i], minx, maxx, zminx, zmaxx);
      y[i] = map(y[i], miny, maxy, zminy, zmaxy);
    }
  }
}

static class Chaos {

  // pdj

  static void transform(float[] x, float[] y) {
    float x0 = 0;
    float y0 = 0;

    x[0] = x0;
    y[0] = y0;

    float a = -2.0;
    float b = 0.5;
    float c = -0.8;
    float d = -2.2;

    for (int i = 1; i < x.length; i++) {
      float _x = 0;
      float _y = 0;

      _x = sin(a*y[i-1])-cos(b*x[i-1]);
      _y = sin(c*x[i-1])-cos(d*y[i-1]);

      x[i] = _x;
      y[i] = _y;
    }
  }
}

int c = 1000000;
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

  Chaos.transform(x, y);
  XYZTransformer.scale(x, y, width/4, height/4);

  // colors -> alpha

  for (int i = 0; i < colors.length; i++) {
    color cc = colors[i];
    colors[i] = color(cc >> 16 & 0xFF, cc >> 8 & 0xFF, cc & 0xFF, 20);
  }

  background(#f4f4f4);

  noLoop();
}

void draw() {
  translate(width/2, height/2);
  strokeWeight(1);
  stroke(colors[0]);

  for (int i = 0; i < x.length; i++) {
    point(x[i], y[i]);
  }
}
