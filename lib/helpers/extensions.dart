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

extension InterpolateExtension<T> on Iterable<T> {
  Iterable<T> intercalate(T element) sync* {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return;

    yield iterator.current;
    while (iterator.moveNext()) {
      yield element;
      yield iterator.current;
    }
  }
}
