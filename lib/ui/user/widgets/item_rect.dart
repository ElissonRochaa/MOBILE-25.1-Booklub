import 'package:flutter/material.dart';

class ItemRectangle extends StatelessWidget {
  final String imageUrl;
  final String? titulo;
  final VoidCallback? onTap;

  const ItemRectangle({
    super.key,
    required this.imageUrl,
    this.onTap,
    this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 140,
        decoration: BoxDecoration(
          // bordas suavemente arredondadas
          image: DecorationImage(image: NetworkImage(imageUrl)),
        ),
      ),
    );
  }
}
