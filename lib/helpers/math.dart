// Linear interpolation (lerp) function
double lerp(double a, double b, double t) {
  return a + (b - a) * t;
}

// Inverse linear interpolation (inverseLerp) function
double inverseLerp(double a, double b, double value) {
  return (value - a) / (b - a);
}

// Clamped linear interpolation (clampedLerp) function
double clampedLerp(double a, double b, double t) {
  t = t.clamp(0.0, 1.0); // Clamp t between 0 and 1
  return a + (b - a) * t;
}

// Inverse clamped linear interpolation (inverseClampedLerp) function
double inverseClampedLerp(num a, num b, num value) {
  return ((value - a) / (b - a)).clamp(0.0, 1.0);
}

int lerpInt(int a, int b, double t) {
  return (a + (b - a) * t).toInt();
}
