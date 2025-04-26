import 'package:flutter/material.dart';

class VerticalCardWidget extends StatelessWidget {

  final ImageProvider? imageProvider;

  final Widget? child;

  const VerticalCardWidget({
    super.key,
    this.imageProvider,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final decorationImage = imageProvider != null
      ? DecorationImage(
          image: imageProvider!,
          fit: BoxFit.cover,
        )
      : null;

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(100),
          topRight: Radius.circular(100),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25)
        )
      ),
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
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
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
  
}
