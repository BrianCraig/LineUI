extension DurationDivider on Duration {
  double divide(Duration otherDuration) {
    return inMilliseconds / otherDuration.inMilliseconds;
  }
}

extension Fractional on double {
  double fractional() {
    return this - floor();
  }
}
