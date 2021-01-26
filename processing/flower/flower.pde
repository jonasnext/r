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

enum FlowerType {
  // h, e
  i, o
}

static class Flower {

  static void transform(float[] x, float[] y, FlowerType t) {

    float R = 16;
    float r = 4;
    float d = 4;

    float x0 = 0;
    float y0 = 0;

    // int c = int(2*PI*r/0.01);

    for (int i = 0; i < x.length; i++) {
      float _x = 0;
      float _y = 0;

      float rho = (2*PI*r)*(float(i)/(x.length-1));

      if (t == FlowerType.i) {
        _x = x0+(R-r)*cos(rho)+d*cos(rho*(R-r)/r);
        _y = y0+(R-r)*sin(rho)-d*sin(rho*(R-r)/r);
      } else {
        _x = x0+(R+r)*cos(rho)-d*cos(rho*(R+r)/r);
        _y = y0+(R+r)*sin(rho)-d*sin(rho*(R+r)/r);
      }

      x[i] = _x;
      y[i] = _y;
    }
  }
}

int c = 4000;
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

  Flower.transform(x, y, FlowerType.i);
  XYZTransformer.scale(x, y, width/4, height/4);

  // colors -> alpha

  for (int i = 0; i < colors.length; i++) {
    color cc = colors[i];
    colors[i] = color(cc >> 16 & 0xFF, cc >> 8 & 0xFF, cc & 0xFF, 200);
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
