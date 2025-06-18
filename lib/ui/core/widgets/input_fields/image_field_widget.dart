import 'package:flutter/material.dart';

class ImageFieldWidget extends StatelessWidget {

  final VoidCallback imagePicker;

  final BoxConstraints? constraints;

  final double? height;

  final double? width;

  final BoxShape shape;

  final Border? border;

  final BorderRadius? borderRadius;
  
  final DecorationImage? image;

  const ImageFieldWidget({
    super.key,
    required this.imagePicker,
    this.constraints,
    this.height,
    this.width,
    this.border,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
    this.image
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final defaultBorder = Border.all(
      color: colorScheme.primary,
      width: 2,
    );

    const defaultImage = DecorationImage(
      image: NetworkImage('https://trustbpo.com.br/wp-content/uploads/2023/07/empty-1.jpeg'),
      fit: BoxFit.cover
    );

    final defaultBorderRadius = (shape == BoxShape.rectangle
      ? BorderRadius.all(Radius.circular(24))
      : null
    );

    final content = Container(
      height: height,
      width: width,
      constraints: constraints,
      decoration: BoxDecoration(
        shape: shape,
        borderRadius: borderRadius ?? defaultBorderRadius,
        border: border ?? defaultBorder,
        image: image ?? defaultImage,
      ),
    );

    return InkWell(
      onTap: imagePicker,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: content,
    );
  }

}
