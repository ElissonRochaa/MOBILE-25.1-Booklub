import 'package:flutter/material.dart';

class BaseFloatingActionButtonWidget extends StatelessWidget {

  const BaseFloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      shape: CircleBorder(),
      child: const Icon(Icons.add),
    );
  }

}
