import 'package:intl/intl.dart';

final fmt = NumberFormat.decimalPattern();
final compactFmt = NumberFormat.compact();

extension IntX on int {
  String get format => fmt.format(this);
  String get compact => compactFmt.format(this);
}
