import 'package:vpn/core/constants.dart';

extension TryParse on int {
  int tryParseInt() {
    return int.tryParse(toString()) ?? 0;
  }
}

extension ParseStringToInt on String {
  int safeParseToInt() {
    return int.tryParse(this) ?? 0;
  }

  String fixDouble() {
    if (isEmpty) return "";
    double d = double.tryParse(this) ?? 0.0;
    if (d == d.truncateToDouble()) {
      return d.toInt().toString();
    } else {
      final numberOfDecimal = getNumberOfDecimalDigits(d);

      return d.toStringAsFixed(numberOfDecimal);
    }
  }
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <dynamic>{};
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
