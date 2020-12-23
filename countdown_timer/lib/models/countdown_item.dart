import 'countdown_shade.dart';
import 'package:countdown_timer/util/countdown_utils.dart';

class CountdownItem {
  final int endDate;
  final String kind;
  final String label;
  final CountdownShade shadeCard;

  CountdownItem(this.label, this.kind, this.endDate)
      : shadeCard = generateShade(),
        assert(kind != null),
        assert(label != null),
        assert(endDate != null);
}
