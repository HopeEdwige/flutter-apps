import 'package:weight_tracker/util/list_utils.dart';

enum WeightDifferenceType { DECREASED, INCREASED, SAME }

class Weight {
  int id;
  int userId;
  double value;
  int timestamp;

  WeightDifference diff;

  Weight({
    this.value,
    this.timestamp,
    this.userId,
  });

  Weight.fromMap(dynamic obj) {
    this.id = obj["id"];
    this.userId = obj["userId"];
    this.value = obj["value"];
    this.timestamp = obj["timestamp"];
    this.diff = WeightDifference(
      value: obj['difference'],
      type: WeightDifferenceType.values[obj['differenceType']],
    );
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this.id != null) {
      map["id"] = this.id;
    }

    map["value"] = this.value;
    map["userId"] = this.userId;
    map["timestamp"] = this.timestamp;
    map["difference"] = this.diff.value;
    map["differenceType"] = this.diff.type.index;
    return map;
  }

  WeightDifference calculateDiff(Weight previous) {
    if (previous == null) {
      return WeightDifference(value: 0, type: WeightDifferenceType.SAME);
    }

    double diff = previous.value - value;
    return WeightDifference(
      value: dp(diff.abs(), 2),
      type: diff.isNegative ? WeightDifferenceType.INCREASED : WeightDifferenceType.DECREASED,
    );
  }

  void setDiff(Weight previous) {
    this.diff = calculateDiff(previous);
  }

  void setUserId(value) {
    this.userId = value;
  }
}

class WeightDifference {
  final double value;
  final WeightDifferenceType type;

  const WeightDifference({
    this.value,
    this.type,
  });
}
