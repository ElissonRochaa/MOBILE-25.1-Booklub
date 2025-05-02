import 'package:flutter/material.dart';

class VerticalCardWidget extends StatelessWidget {

  final ImageProvider? imageProvider;

  final Widget? child;

  final VoidCallback? onTap;

  const VerticalCardWidget({
    super.key,
    this.imageProvider,
    this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(100),
      topRight: Radius.circular(100),
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25)
    );

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      elevation: 2,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Builder(builder: _buildCardImage),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }

  Align _buildCardImage(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final decorationImage = imageProvider != null
      ? DecorationImage(
        image: imageProvider!,
        fit: BoxFit.cover,
      )
      : null;

    return Align(
      alignment: Alignment.topCenter,
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          height: constraints.maxWidth,
          decoration: BoxDecoration(
            border: Border.all(
              color: colorScheme.primary,
              width: 3.2
            ),
            color: Colors.white,
            shape: BoxShape.circle,
            image: decorationImage,
          ),
        ),
      ),
    );
  }
  
}
