import 'package:flutter/material.dart';

class BaseGridWidget extends StatelessWidget {

  final SliverGridDelegate gridDelegate;

  final SliverChildDelegate childrenDelegate;

  final bool isSliver;

  const BaseGridWidget({
    super.key,
    required this.gridDelegate,
    required this.childrenDelegate,
  }): isSliver = false;

  const BaseGridWidget.sliver({
    super.key,
    required this.gridDelegate,
    required this.childrenDelegate,
  }): isSliver = true;

  @override
  Widget build(BuildContext context) => isSliver
    ? Builder(builder: _buildSliverBaseGrid)
    : Builder(builder: _buildBaseGrid);

  Widget _buildBaseGrid(BuildContext context) => GridView.custom(
    gridDelegate: gridDelegate,
    childrenDelegate: childrenDelegate,
  );

  Widget _buildSliverBaseGrid(BuildContext context) => SliverGrid(
    gridDelegate: gridDelegate,
    delegate: childrenDelegate,
  );

}
