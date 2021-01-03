List<double> range(start, end, {step = 1}) {
  var len = ((end - start) / step).floor() + 1;
  return List<double>.generate(len, (index) => start + (index * step));
}
