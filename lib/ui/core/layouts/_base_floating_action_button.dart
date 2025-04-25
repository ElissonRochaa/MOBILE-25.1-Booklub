import 'package:flutter/material.dart';

class BaseFloatingActionButton extends StatelessWidget {

  const BaseFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      shape: CircleBorder(),
      child: const Icon(Icons.add),
    );
  }

}
