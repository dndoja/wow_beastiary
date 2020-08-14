import 'package:flutter/cupertino.dart';

typedef void WidgetDataCallback(WidgetData widgetData);

class HeightReporter extends StatelessWidget {

  final Widget child;
  final WidgetDataCallback onTap;

  HeightReporter({this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: child,
      onTap: () {
        if (onTap != null) {
          final width = context.size.width;
          final height = context.size.height;
          RenderBox box = context.findRenderObject();
          Offset position = box.localToGlobal(Offset.zero);
          onTap(WidgetData(position.dy, position.dx, width, height));
        }
      },
    );
  }
}

class WidgetData {
  final double xPos;
  final double yPos;
  final double width;
  final double height;

  WidgetData(this.yPos, this.xPos, this.width, this.height);
}