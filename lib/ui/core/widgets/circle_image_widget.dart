import 'package:flutter/material.dart';

class CircleImageWidget extends StatelessWidget {

  final bool isExpanded;

  final DecorationImage? decorationImage;

  final Color backgroundColor;

  final Color? borderColor;

  final double borderWidth;

  final double radius;

  const CircleImageWidget({
    super.key,
    required this.radius,
    this.decorationImage,
    this.backgroundColor = Colors.transparent,
    this.borderColor,
    this.borderWidth = 0,
  }): isExpanded = false;

  const CircleImageWidget.expanded({
    super.key,
    this.decorationImage,
    this.backgroundColor = Colors.transparent,
    this.borderColor,
    this.borderWidth = 0,
  }): isExpanded = true, radius=0;

  @override
  Widget build(BuildContext context) => isExpanded
    ? Builder(builder: _buildExpandedImage)
    : Builder(builder: _buildImage);

  Widget _buildImage(BuildContext context) {
    final border = (borderColor != null
      ? Border.all(color: borderColor!, width: borderWidth)
      : null
    );

    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        border: border,
        shape: BoxShape.circle,
        color: backgroundColor,
        image: decorationImage,
      ),
    );
  }

  Widget _buildExpandedImage(BuildContext context) {
    final border = (borderColor != null
      ? Border.all(color: borderColor!, width: borderWidth)
      : null
    );

    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
            maxHeight: constraints.maxHeight,
          ),
          decoration: BoxDecoration(
            border: border,
            shape: BoxShape.circle,
            color: backgroundColor,
            image: decorationImage,
          ),
        )
      ),
    );
  }

}
