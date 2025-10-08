// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';

mixin HoverStateMixin<T extends StatefulWidget> on State<T> {
  bool isHovered = false;
  void updateHoverState([bool? value]) {
    return setState(() {
      isHovered = (value ?? !isHovered);
    });
  }
}

class _HoverableWidget extends StatefulWidget {
  const _HoverableWidget({
    super.key,
    required this.child,
    double? hoverElevation,
    this.borderRadius,
  }) : hoverElevation = hoverElevation ?? 10;
  final Widget child;
  final double hoverElevation;
  final BorderRadiusGeometry? borderRadius;
  @override
  State<_HoverableWidget> createState() => __HoverableWidgetState();
}

class __HoverableWidgetState extends State<_HoverableWidget>
    with HoverStateMixin {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => updateHoverState(true),
      onExit: (_) => updateHoverState(false),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: isHovered ? widget.hoverElevation : 0,
        shape: RoundedRectangleBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
        ),
        child: widget.child,
      ),
    );
  }
}

extension WidgetHoverHelperExtension on Widget {
  Widget hover({
    double? elevation,
    BorderRadiusGeometry? borderRadius,
  }) {
    return _HoverableWidget(
      hoverElevation: elevation,
      borderRadius: borderRadius,
      child: this,
    );
  }
}
