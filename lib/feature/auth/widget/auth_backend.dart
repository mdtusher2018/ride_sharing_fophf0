import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class AuthBackgroundRenderObject extends RenderProxyBox {
  Color _backgroundColor;
  double _curve;
  double _topPadding;

  AuthBackgroundRenderObject({
    required Color backgroundColor,
    required double curve,
    required double topPadding,
  }) : _backgroundColor = backgroundColor,
       _curve = curve,
       _topPadding = topPadding;

  // setters
  set backgroundColor(Color value) {
    if (_backgroundColor == value) return;
    _backgroundColor = value;
    markNeedsPaint();
  }

  set curve(double value) {
    if (_curve == value) return;
    _curve = value;
    markNeedsPaint();
  }

  set topPadding(double value) {
    if (_topPadding == value) return;
    _topPadding = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    final Size size = this.size;

    final Paint paint = Paint()
      ..color = _backgroundColor
      ..style = PaintingStyle.fill;

    final double startY = offset.dy + _topPadding;

    final Path path = Path();

    // 🔹 Top curve
    path.moveTo(offset.dx, startY + 100);
    path.quadraticBezierTo(
      offset.dx + size.width / 2,
      startY,
      offset.dx + size.width,
      startY + 100,
    );

    // 🔹 Right side down (fixed curve distance from bottom)
    path.lineTo(
      offset.dx + size.width,
      startY + _curve * 0.25 + (_curve * 1.5),
    );

    // 🔹 Bottom curve (mirror of top curve, fixed size)
    path.quadraticBezierTo(
      offset.dx + size.width / 2,
      startY + _curve * 0.15 + (_curve * 1.5),
      offset.dx,
      startY + _curve * 0.25 + (_curve * 1.5),
    );

    // 🔹 Close path back to start
    path.close();

    canvas.drawPath(path, paint);

    // Paint child on top
    super.paint(context, offset);
  }
}

class AuthBackground extends SingleChildRenderObjectWidget {
  final Color backgroundColor;
  final double curve;
  final double topPadding;

  const AuthBackground({
    super.key,
    required Widget child,
    this.backgroundColor = const Color(0xFFF2F2F2),
    this.curve = 800,
    this.topPadding = 0,
  }) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return AuthBackgroundRenderObject(
      backgroundColor: backgroundColor,
      curve: curve,
      topPadding: topPadding,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant AuthBackgroundRenderObject renderObject,
  ) {
    renderObject
      ..backgroundColor = backgroundColor
      ..curve = curve
      ..topPadding = topPadding;
  }
}
