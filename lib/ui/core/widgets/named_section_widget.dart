import 'package:flutter/material.dart';

class NamedSectionWidget extends StatelessWidget {

  final String name;

  final bool showSeeMore;

  final VoidCallback? onSeeMorePressed;

  const NamedSectionWidget({
    super.key,
    required this.name,
    this.showSeeMore = false,
    this.onSeeMorePressed
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final seeMore = InkWell(
      onTap: onSeeMorePressed?? () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: Icon(
          Icons.add_circle_rounded,
          color: colorScheme.primary,
          size: 32,
        )
      ),
    );

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            name,
            style: textTheme.titleLarge!.copyWith(
              fontFamily: 'Navicula',
              color: colorScheme.primary
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 4,
            color: colorScheme.primary,
          )
        ),
        if (showSeeMore) seeMore,
      ],
    );
  }

}
