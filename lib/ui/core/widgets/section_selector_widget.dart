import 'package:flutter/material.dart';

class SectionSelectorItem {

  final String label;

  final VoidCallback? onSelect;

  final bool isSelected;

  const SectionSelectorItem({
    required this.label,
    required this.onSelect,
    this.isSelected = false,
  });

}

class SectionSelectorWidget extends StatelessWidget {

  final List<SectionSelectorItem> sections;

  final double spacing;

  const SectionSelectorWidget({
    super.key,
    required this.sections,
    this.spacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final sectionButtons = sections.map((section) => ElevatedButton(
      onPressed: section.onSelect,
      style: ElevatedButton.styleFrom(
        backgroundColor: (section.isSelected
          ? colorScheme.primary
          : colorScheme.surfaceContainer
        ),
        foregroundColor: (section.isSelected
          ? colorScheme.onPrimary
          : colorScheme.onSurface
        ),
        textStyle: textTheme.labelMedium,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8)
      ),
      child: Text(section.label)
    ));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: Row(
          spacing: spacing,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: spacing),
            ...sectionButtons,
            SizedBox(width: spacing),
          ],
        ),
      ),
    );
  }

}
