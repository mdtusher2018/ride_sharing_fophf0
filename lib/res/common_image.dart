import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ImageSourceType { asset, network }

class CommonImage extends StatelessWidget {
  final String path;
  final ImageSourceType sourceType;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final Widget? errorWidget;
  final bool isSvg;

  const CommonImage({
    super.key,
    required this.path,
    this.sourceType = ImageSourceType.asset,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
    this.errorWidget,
    this.isSvg = false,
  });

  @override
  Widget build(BuildContext context) {
    final double? w = width?.w;
    final double? h = height?.h;

    if (isSvg) {
      return _buildSvg(w, h);
    } else {
      return _buildRaster(w, h);
    }
  }

  /// SVG handler
  Widget _buildSvg(double? w, double? h) {
    if (sourceType == ImageSourceType.network) {
      return SvgPicture.network(
        path,
        width: w,
        height: h,
        fit: fit,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
        placeholderBuilder: (_) => _loader(w, h),
        errorBuilder: (_, error, __) {
          debugPrint('Network SVG Error: $error');
          return errorWidget ?? _error(w, h);
        },
      );
    } else {
      return SvgPicture.asset(
        path,
        width: w,
        height: h,
        fit: fit,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
        placeholderBuilder: (_) => _loader(w, h),
        errorBuilder: (_, error, __) {
          debugPrint('Asset SVG Error: $error');
          return errorWidget ?? _error(w, h);
        },
      );
    }
  }

  /// PNG / JPG handler
  Widget _buildRaster(double? w, double? h) {
    if (sourceType == ImageSourceType.network) {
      return Image.network(
        path,
        width: w,
        height: h,
        fit: fit,
        color: color,
        loadingBuilder: (_, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _loader(w, h);
        },
        errorBuilder: (_, error, __) {
          debugPrint('Network Image Error: $error');
          return errorWidget ?? _error(w, h);
        },
      );
    } else {
      return Image.asset(
        path,
        width: w,
        height: h,
        fit: fit,
        color: color,
        errorBuilder: (_, error, __) {
          debugPrint('Asset Image Error: $error');
          return errorWidget ?? _error(w, h);
        },
      );
    }
  }

  /// Loader
  Widget _loader(double? w, double? h) {
    return SizedBox(
      width: w,
      height: h,
      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }

  /// Error fallback
  Widget _error(double? w, double? h) {
    return SizedBox(
      width: w,
      height: h,
      child: const Icon(Icons.broken_image, color: Colors.grey),
    );
  }
}
