import 'package:booklub/ui/core/widgets/named_section_widget.dart';
import 'package:flutter/material.dart';

class NamedSectionCarousel extends StatelessWidget {

  final String name;

  final bool showSeeMore;

  final VoidCallback? onSeeMorePressed;

  final double height;

  final double aspectRatio;

  final bool isSliver;

  final Widget Function(BuildContext, int) itemBuilder;

  final int? itemCount;

  const NamedSectionCarousel({
    super.key,
    required this.name,
    required this.height,
    this.aspectRatio = 1,
    this.showSeeMore = false,
    this.onSeeMorePressed,
    required this.itemBuilder,
    this.itemCount
  }): isSliver=false;

  const NamedSectionCarousel.sliver({
    super.key,
    required this.name,
    required this.height,
    this.aspectRatio = 1,
    this.showSeeMore = false,
    this.onSeeMorePressed,
    required this.itemBuilder,
    this.itemCount
  }): isSliver=true;

  @override
  Widget build(BuildContext context) => isSliver
      ? Builder(builder: _buildSliverNamedSectionCarousel)
      : Builder(builder: _buildNamedSectionCarousel);

  Widget _buildSliverNamedSectionCarousel(
      BuildContext context
  ) => NamedSectionWidget.sliver(
    name: name,
    showSeeMore: showSeeMore,
    onSeeMorePressed: onSeeMorePressed,
    sliver: SliverToBoxAdapter(
      child: Builder(builder: _buildCarousel),
    ),
  );

  Widget _buildNamedSectionCarousel(
      BuildContext context
  ) => NamedSectionWidget(
    name: name,
    showSeeMore: showSeeMore,
    onSeeMorePressed: onSeeMorePressed,
    child: Builder(builder: _buildCarousel),
  );

  Widget _buildCarousel(BuildContext context) {
    final viewPortWidth = MediaQuery.of(context).size.width;

    final controller = PageController(
      initialPage: 0,
      viewportFraction: (height * aspectRatio) / viewPortWidth,
    );

    return SizedBox(
      height: height,
      child: PageView.builder(
        padEnds: false,
        controller: controller,
        itemBuilder: itemBuilder,
        scrollDirection: Axis.horizontal,
        physics: ClampingScrollPhysics(),
        itemCount: itemCount,
      ),
    );
  }

}
