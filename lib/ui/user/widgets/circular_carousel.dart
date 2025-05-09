import 'package:flutter/material.dart';

class HorizontalCarousel extends StatelessWidget {
  final List<Widget> items;

  const HorizontalCarousel({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(top: 16),
      child: ListView.separated(
        //separador entre os itens pra n ter quer usar o sizedbox manual
        scrollDirection: Axis.horizontal,
        itemCount: items.length, //quantidade de itens na lista
        padding: const EdgeInsets.symmetric(horizontal: 8),
        separatorBuilder:
            (_, __) => const SizedBox(width: 30), //espaçamento entre os itens
        itemBuilder: (context, index) => items[index],
      ),
    );
  }
}
