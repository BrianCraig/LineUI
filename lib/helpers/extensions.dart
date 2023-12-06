extension DurationExtensions on Duration {
  double divide(Duration otherDuration) {
    return inMicroseconds / otherDuration.inMicroseconds;
  }

  double get inSecondsDouble {
    return inMicroseconds * .000001;
  }
}

extension Fractional on double {
  double fractional() {
    return this - floor();
  }
}
