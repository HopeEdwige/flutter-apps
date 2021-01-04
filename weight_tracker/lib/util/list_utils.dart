import 'dart:math';

List<double> range(start, end, {step = 1}) {
  var len = ((end - start) / step).floor() + 1;
  return List<double>.generate(len, (index) => dp(start + (index * step), 2));
}

double dp(double val, int places) {
  double mod = pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}
