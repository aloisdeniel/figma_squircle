import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'smooth_border_radius.dart';

class SmoothRectangleBorder extends OutlinedBorder {
  const SmoothRectangleBorder({
    BorderSide side = BorderSide.none,
    this.borderRadius = SmoothBorderRadius.zero,
  }) : super(side: side);

  /// The radius for each corner.
  ///
  /// Negative radius values are clamped to 0.0 by [getInnerPath] and
  /// [getOuterPath].
  final SmoothBorderRadius borderRadius;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  ShapeBorder scale(double t) {
    return SmoothRectangleBorder(
      side: side.scale(t),
      borderRadius: borderRadius * t,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is SmoothRectangleBorder) {
      return SmoothRectangleBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius: SmoothBorderRadius.lerp(a.borderRadius, borderRadius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is SmoothRectangleBorder) {
      return SmoothRectangleBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius: SmoothBorderRadius.lerp(borderRadius, b.borderRadius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final innerRect = rect.deflate(side.width);
    return borderRadius.toPath(innerRect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return borderRadius.toPath(rect);
  }

  @override
  SmoothRectangleBorder copyWith(
      {BorderSide? side, SmoothBorderRadius? borderRadius}) {
    return SmoothRectangleBorder(
      side: side ?? this.side,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (rect.isEmpty) return;
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final Path path = getOuterPath(rect, textDirection: textDirection);
        final Paint paint = side.toPaint();
        canvas.drawPath(path, paint);
        break;
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is SmoothRectangleBorder &&
        other.side == side &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => hashValues(side, borderRadius);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'SmoothRectangleBorder')}($side, $borderRadius)';
  }
}
