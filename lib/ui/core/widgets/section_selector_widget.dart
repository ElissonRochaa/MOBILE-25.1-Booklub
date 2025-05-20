import 'package:booklub/config/theme/theme_config.dart';
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

class SectionSelector extends StatelessWidget {

  final List<SectionSelectorItem> sections;

  const SectionSelector({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final sectionButtons = sections.map((section) => ElevatedButton(
      onPressed: section.onSelect,
      style: ElevatedButton.styleFrom(
        backgroundColor: (section.isSelected
          ? colorScheme.primary
          : colorScheme.darkWhite
        ),
        foregroundColor: (section.isSelected
          ? colorScheme.onPrimary
          : colorScheme.black
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
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(width: 12),
            ...sectionButtons,
            SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

}
