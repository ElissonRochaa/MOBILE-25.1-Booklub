import 'package:flutter/material.dart';

class PhotoPickerBox extends StatelessWidget {
  const PhotoPickerBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Foto', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: const Icon(Icons.image, color: Colors.grey),
        ),
      ],
    );
  }
}
