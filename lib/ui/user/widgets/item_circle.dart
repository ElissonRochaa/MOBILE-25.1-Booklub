import 'package:flutter/material.dart';

class ItemCircle extends StatelessWidget {
  final String imageUrl;
  final String? titulo;
  final VoidCallback?
  onTap; // Callback function to handle tap events (qlqr uma que for passada por parametro ou null se não for passada)

  const ItemCircle({
    super.key,
    required this.imageUrl,
    this.onTap,
    this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //detecta o toque na imagem e executa a funcao ontap passada por parametro
      onTap: onTap, //funcao passada por parametro, não faz nada se for null
      child: CircleAvatar(
        radius: 51,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
