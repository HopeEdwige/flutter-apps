class CountdownShade {
  final dynamic background;
  final dynamic labelBackground;
  final dynamic durationBackground;

  const CountdownShade({
    this.background,
    this.labelBackground,
    this.durationBackground,
  })  : assert(background != null),
        assert(labelBackground != null),
        assert(durationBackground != null);
}
