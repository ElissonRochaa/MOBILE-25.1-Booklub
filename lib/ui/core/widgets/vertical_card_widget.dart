import 'package:flutter/material.dart';

class VerticalCardWidget extends StatelessWidget {
  
  const VerticalCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle
            ),
            constraints: BoxConstraints(
              minHeight: 80,
              maxWidth: 80
            ),
          ),
          Text('Marvel')
        ],
      ),
    );
  }
  
}
