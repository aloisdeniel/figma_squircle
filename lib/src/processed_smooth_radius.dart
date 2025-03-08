import 'dart:math' as math;

import 'smooth_radius.dart';

// The article from figma's blog
// https://www.figma.com/blog/desperately-seeking-squircles/
//
// The original code
// https://github.com/MartinRGB/Figma_Squircles_Approximation/blob/bf29714aab58c54329f3ca130ffa16d39a2ff08c/js/rounded-corners.js#L64
class ProcessedSmoothRadius {
  const ProcessedSmoothRadius._({
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.p,
    required this.width,
    required this.height,
    required this.radius,
    required this.circularSectionLength,
  });

  /// Since the operations are expensive, and the radius values pretty recurrent, we cache the results.
  static final Map<(SmoothRadius, double, double), ProcessedSmoothRadius>
      _cache = {};

  /// Creates a [ProcessedSmoothRadius] from a [SmoothRadius].
  ///
  /// If [useCache] is true, the result will be cached.
  factory ProcessedSmoothRadius(
    SmoothRadius radius, {
    required double width,
    required double height,
    bool useCache = true,
  }) {
    if (useCache) {
      final cached = _cache[(radius, width, height)];
      if (cached != null) {
        return cached;
      }
    }

    final cornerSmoothing = radius.cornerSmoothing;
    var cornerRadius = radius.cornerRadius;

    final maxRadius = math.min(width, height) / 2;
    cornerRadius = math.min(cornerRadius, maxRadius);

    // 12.2 from the article
    final p = math.min((1 + cornerSmoothing) * cornerRadius, maxRadius);

    final double angleAlpha, angleBeta;

    if (cornerRadius <= maxRadius / 2) {
      angleBeta = 90 * (1 - cornerSmoothing);
      angleAlpha = 45 * cornerSmoothing;
    } else {
      // When `cornerRadius` is larger and `maxRadius / 2`,
      // these angles also depend on `cornerRadius` and `maxRadius / 2`
      //
      // I did a few tests in Figma and this code generated similar but not identical results
      // `diffRatio` was called `change_percentage` in the orignal code
      final diffRatio = (cornerRadius - maxRadius / 2) / (maxRadius / 2);

      angleBeta = 90 * (1 - cornerSmoothing * (1 - diffRatio));
      angleAlpha = 45 * cornerSmoothing * (1 - diffRatio);
    }

    final angleTheta = (90 - angleBeta) / 2;

    // This was called `h_longest` in the original code
    // In the article this is the distance between 2 control points: P3 and P4
    final p3ToP4Distance = cornerRadius * math.tan(_radians(angleTheta / 2));

    // This was called `l` in the original code
    final circularSectionLength =
        math.sin(_radians(angleBeta / 2)) * cornerRadius * math.sqrt(2);

    // a, b, c and d are from 11.1 in the article
    final c = p3ToP4Distance * math.cos(_radians(angleAlpha));
    final d = c * math.tan(_radians(angleAlpha));
    final b = (p - circularSectionLength - c - d) / 3;
    final a = 2 * b;

    final result = ProcessedSmoothRadius._(
      a: a,
      b: b,
      c: c,
      d: d,
      p: p,
      width: width,
      height: height,
      radius: SmoothRadius(
        cornerRadius: cornerRadius,
        cornerSmoothing: radius.cornerSmoothing,
      ),
      circularSectionLength: circularSectionLength,
    );
    if (useCache) {
      _cache[(radius, width, height)] = result;
    }
    return result;
  }

  final SmoothRadius radius;
  final double a;
  final double b;
  final double c;
  final double d;
  final double p;
  final double circularSectionLength;
  final double width;
  final double height;
  double get cornerRadius => radius.cornerRadius;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    if (other is SmoothRadius) {
      return other == radius;
    }
    if (other is ProcessedSmoothRadius) {
      return other.radius == radius;
    }

    return false;
  }

  @override
  int get hashCode => radius.hashCode;

  @override
  String toString() {
    return 'ProcessedSmoothRadius('
        'radius: $radius,'
        'a: ${a.toStringAsFixed(2)},'
        'b: ${b.toStringAsFixed(2)},'
        'c: ${c.toStringAsFixed(2)},'
        'd: ${d.toStringAsFixed(2)},'
        'p: ${p.toStringAsFixed(2)},'
        'width: ${width.toStringAsFixed(2)},'
        'height: ${height.toStringAsFixed(2)},'
        ')';
  }
}

/// Convert [degrees] to radians.
double _radians(double degrees) => degrees * _degrees2Radians;

/// Constant factor to convert and angle from degrees to radians.
const double _degrees2Radians = math.pi / 180.0;
