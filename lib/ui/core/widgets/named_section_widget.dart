import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class NamedSectionWidget extends StatelessWidget {

  final String name;

  final bool showSeeMore;

  final VoidCallback? onSeeMorePressed;

  final Widget child;

  final bool isSliver;

  const NamedSectionWidget({
    super.key,
    required this.name,
    this.showSeeMore = false,
    this.onSeeMorePressed,
    required this.child
  }): isSliver=false;

  const NamedSectionWidget.sliver({
    super.key,
    required this.name,
    this.showSeeMore = false,
    this.onSeeMorePressed,
    required Widget sliver,
  }): isSliver=true, child=sliver;

  @override
  Widget build(BuildContext context) => isSliver
    ? Builder(builder: _buildSliverNamedSectionWidget)
    : Builder(builder: _buildNamedSectionWidget);


  Widget _buildNamedSectionWidget(BuildContext context) => Column(
    children: [
      Builder(builder: _buildHeader),
      child
    ]
  );

  Widget _buildSliverNamedSectionWidget(BuildContext context) => MultiSliver(
    children: [
      Builder(builder: _buildHeader),
      child
    ],
  );

  Widget _buildHeader(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            name,
            style: textTheme.titleLarge!.copyWith(
              fontFamily: 'Navicula',
              color: colorScheme.primary
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 4,
              color: colorScheme.primary,
            )
          ),
          if (showSeeMore) _getSeeMore(colorScheme),
        ],
      ),
    );
  }

  Widget _getSeeMore(ColorScheme colorScheme) => InkWell(
    onTap: onSeeMorePressed?? () {},
    child: Icon(
      Icons.add_circle_rounded,
      color: colorScheme.primary,
      size: 32,
    )
  );

}
