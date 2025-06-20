import 'package:booklub/config/theme/theme_config.dart';
import 'package:flutter/material.dart';

class ClubProfileInfoListItem {

  final String label;

  final int number;

  final bool selected;

  final VoidCallback? onTap;

  const ClubProfileInfoListItem({
    required this.label,
    required this.number,
    required this.selected,
    this.onTap,
  });

}

class ClubProfileInfoListWidget extends StatelessWidget {

  final List<ClubProfileInfoListItem> infoItems;

  const ClubProfileInfoListWidget({
    super.key,
    required this.infoItems
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final infoCards = infoItems.map((infoItem) => _ProfileInfoCardWidget(
      label: infoItem.label,
      number: infoItem.number,
      onTap: infoItem.onTap,
      selected: infoItem.selected,
    ));

    final profileInfo = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      spacing: 8,
      children: [
        SizedBox(width: 12),
        ...infoCards,
        SizedBox(width: 12),
      ],
    );

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        color: colorScheme.surfaceContainerHighest,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: profileInfo,
          ),
        ),
      ),
    );
  }
}

class _ProfileInfoCardWidget extends StatelessWidget {

  final String label;

  final int number;

  final bool selected;

  final VoidCallback? onTap;

  const _ProfileInfoCardWidget({
    required this.label,
    required this.number,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final cardNumber = Text(
      number.toString(),
      style: textTheme.labelLarge!.copyWith(
        color: selected ? colorScheme.onPrimary : colorScheme.onSurface,
      ),
    );

    final cardLabel = Text(
      label,
      style: textTheme.labelSmall!.copyWith(
        color: selected ? colorScheme.onPrimary : colorScheme.onSurface,
      )
    );

    final cardContent = Column(
      children: [
        cardNumber,
        cardLabel
      ],
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Card(
        color: selected ? colorScheme.primary : colorScheme.surfaceContainer,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: cardContent,
        ),
      ),
    );
  }

}
