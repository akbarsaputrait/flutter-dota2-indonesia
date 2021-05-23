import 'package:flutter/widgets.dart';

class WidgetChooser extends StatelessWidget {
  final bool condition;
  final Widget trueChild;
  final Widget falseChild;

  WidgetChooser(
      {@required this.condition,
      @required this.trueChild,
      @required this.falseChild});

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return trueChild;
    } else {
      return falseChild;
    }
  }
}
