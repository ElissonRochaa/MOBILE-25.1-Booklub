import 'package:flutter/material.dart';

class CircleConstraint {

  final double minRadius;

  final double maxRadius;

  const CircleConstraint({
    this.minRadius = 0,
    this.maxRadius = double.infinity,
  });

}

class CircleImageWidget extends StatelessWidget {

  final bool isExpanded;

  final DecorationImage? decorationImage;

  final Color backgroundColor;

  final Color? borderColor;

  final double borderWidth;

  final double? radius;

  final CircleConstraint? constraint;

  const CircleImageWidget({
    super.key,
    this.radius,
    this.constraint,
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
  }): isExpanded = true, radius=null, constraint=null;

  @override
  Widget build(BuildContext context) => isExpanded
    ? Builder(builder: _buildExpandedImage)
    : Builder(builder: _buildImage);

  Widget _buildImage(BuildContext context) {
    final border = (borderColor != null
      ? Border.all(color: borderColor!, width: borderWidth)
      : null
    );

    final boxConstraint = (constraint != null
      ? BoxConstraints(
          minWidth: constraint!.minRadius,
          maxWidth: constraint!.maxRadius,
          minHeight: constraint!.minRadius,
          maxHeight: constraint!.maxRadius,
        )
      : null
    );

    return Container(
      constraints: boxConstraint,
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
