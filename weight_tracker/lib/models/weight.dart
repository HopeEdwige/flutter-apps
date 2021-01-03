enum WeightDifferenceType { DECREASED, INCREASED, SAME }

class Weight {
  final double value;
  final int timestamp;
  final double difference;
  final WeightDifferenceType differenceType;

  const Weight({this.value, this.timestamp, this.difference, this.differenceType});
}
