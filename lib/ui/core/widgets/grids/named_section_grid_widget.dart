import 'package:booklub/ui/core/widgets/named_section_widget.dart';
import 'package:flutter/material.dart';
import 'base_grid_widget.dart';

class NamedSectionGridWidget extends StatelessWidget {

  final String name;

  final SliverGridDelegate gridDelegate;

  final SliverChildDelegate childrenDelegate;

  final bool showSeeMore;

  final VoidCallback? onSeeMorePressed;

  final bool isSliver;

  const NamedSectionGridWidget({
    super.key,
    required this.name,
    this.showSeeMore=false,
    this.onSeeMorePressed,
    required this.gridDelegate,
    required this.childrenDelegate,
  }): isSliver=false;

  const NamedSectionGridWidget.sliver({
    super.key,
    required this.name,
    this.showSeeMore=false,
    this.onSeeMorePressed,
    required this.gridDelegate,
    required this.childrenDelegate,
  }): isSliver=true;

  @override
  Widget build(BuildContext context) => isSliver
    ? Builder(builder: _buildSliverNamedSectionGrid)
    : Builder(builder: _buildNamedSectionGrid);

  Widget _buildSliverNamedSectionGrid(BuildContext context) {
    return NamedSectionWidget.sliver(
      name: name,
      showSeeMore: showSeeMore,
      onSeeMorePressed: onSeeMorePressed,
      sliver: BaseGridWidget.sliver(
        gridDelegate: gridDelegate,
        childrenDelegate: childrenDelegate,
      ),
    );
  }

  Widget _buildNamedSectionGrid(BuildContext context) {
    return NamedSectionWidget(
      name: name,
      showSeeMore: showSeeMore,
      onSeeMorePressed: onSeeMorePressed,
      child: BaseGridWidget(
        gridDelegate: gridDelegate,
        childrenDelegate: childrenDelegate,
      ),
    );
  }

}
