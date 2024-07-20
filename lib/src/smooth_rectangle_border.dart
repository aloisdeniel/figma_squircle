import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'smooth_border_radius.dart';

enum BorderAlign {
  inside,
  center,
  outside,
}

class SmoothRectangleBorder extends OutlinedBorder {
  const SmoothRectangleBorder({
    BorderSide side = BorderSide.none,
    this.borderRadius = SmoothBorderRadius.zero,
    this.borderAlign = BorderAlign.inside,
  }) : super(side: side);

  /// The radius for each corner.
  ///
  /// Negative radius values are clamped to 0.0 by [getInnerPath] and
  /// [getOuterPath].
  final SmoothBorderRadius borderRadius;
  final BorderAlign borderAlign;

  @override
  EdgeInsetsGeometry get dimensions {
    switch (borderAlign) {
      case BorderAlign.inside:
        return EdgeInsets.all(side.width);
      case BorderAlign.center:
        return EdgeInsets.all(side.width / 2);
      case BorderAlign.outside:
        return EdgeInsets.zero;
    }
  }

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
    final innerRect = () {
      switch (borderAlign) {
        case BorderAlign.inside:
          return rect.deflate(side.width);
        case BorderAlign.center:
          return rect.deflate(side.width / 2);
        case BorderAlign.outside:
          return rect;
      }
    }();
    final radius = () {
      switch (borderAlign) {
        case BorderAlign.inside:
          return borderRadius -
              SmoothBorderRadius.all(
                SmoothRadius(
                  cornerRadius: side.width,
                  cornerSmoothing: 1.0,
                ),
              );
        case BorderAlign.center:
          return borderRadius -
              SmoothBorderRadius.all(
                SmoothRadius(
                  cornerRadius: side.width / 2,
                  cornerSmoothing: 1.0,
                ),
              );
        case BorderAlign.outside:
          return borderRadius;
      }
    }();

    if ([radius.bottomLeft, radius.bottomRight, radius.topLeft, radius.topRight]
        .every((x) => x.cornerSmoothing == 0.0)) {
      return Path()..addRRect(radius.resolve(textDirection).toRRect(innerRect));
    }

    return radius.toPath(innerRect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect, borderRadius, textDirection: textDirection);
  }

  Path _getPath(
    Rect rect,
    SmoothBorderRadius radius, {
    TextDirection? textDirection,
  }) {
    if ([radius.bottomLeft, radius.bottomRight, radius.topLeft, radius.topRight]
        .every((x) => x.cornerSmoothing == 0.0)) {
      return Path()..addRRect(radius.resolve(textDirection).toRRect(rect));
    }

    return radius.toPath(rect);
  }

  @override
  SmoothRectangleBorder copyWith({
    BorderSide? side,
    SmoothBorderRadius? borderRadius,
    BorderAlign? borderAlign,
  }) {
    return SmoothRectangleBorder(
      side: side ?? this.side,
      borderRadius: borderRadius ?? this.borderRadius,
      borderAlign: borderAlign ?? this.borderAlign,
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (rect.isEmpty) return;
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        // Since the stroke is painted at the center, we need to adjust the rect
        // according to the [borderAlign].
        final adjustedRect = () {
          switch (borderAlign) {
            case BorderAlign.inside:
              return rect.deflate(side.width / 2);
            case BorderAlign.center:
              return rect;
            case BorderAlign.outside:
              return rect.inflate(side.width / 2);
          }
        }();
        final adjustedBorderRadius = () {
          switch (borderAlign) {
            case BorderAlign.inside:
              return borderRadius -
                  SmoothBorderRadius.all(
                    SmoothRadius(
                      cornerRadius: side.width / 2,
                      cornerSmoothing: 1.0,
                    ),
                  );
            case BorderAlign.center:
              return borderRadius;
            case BorderAlign.outside:
              return borderRadius +
                  SmoothBorderRadius.all(
                    SmoothRadius(
                      cornerRadius: side.width / 2,
                      cornerSmoothing: 1.0,
                    ),
                  );
          }
        }();

        final outerPath = _getPath(
          adjustedRect,
          adjustedBorderRadius,
          textDirection: textDirection,
        );

        canvas.drawPath(
          outerPath,
          side.toPaint(),
        );

        break;
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is SmoothRectangleBorder &&
        other.side == side &&
        other.borderRadius == borderRadius &&
        other.borderAlign == borderAlign;
  }

  @override
  int get hashCode => Object.hash(side, borderRadius, borderAlign);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'SmoothRectangleBorder')}($side, $borderRadius, $borderAlign)';
  }
}
