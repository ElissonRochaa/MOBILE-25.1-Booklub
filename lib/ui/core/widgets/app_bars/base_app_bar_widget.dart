import 'package:booklub/config/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BaseAppBarWidget extends StatelessWidget implements PreferredSizeWidget {

  final double height;

  final bool sliver;

  const BaseAppBarWidget({
    super.key,
    this.height=kToolbarHeight
  }): sliver=false;

  const BaseAppBarWidget.sliver({
    super.key,
    this.height=kToolbarHeight
  }): sliver=true;

  @override
  Widget build(BuildContext context) => sliver
      ? Builder(builder: _buildSliverAppBar)
      : Builder(builder: _buidAppBar);

  Widget _buidAppBar(BuildContext context) => PreferredSize(
    preferredSize: Size.fromHeight(height),
    child: AppBar(
      title: Text('Booklub'),
      actions: _getActions(context),
    ),
  );

  Widget _buildSliverAppBar(BuildContext context) => SliverAppBar(
    floating: true,
    title: Text('Booklub'),
    actions: _getActions(context),
  );

  List<Widget> _getActions(BuildContext context) => [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () => context.push(Routes.explore),
    ),
    IconButton(
      icon: Icon(Icons.add_alert),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {},
    ),
  ];

  @override
  Size get preferredSize => Size.fromHeight(height);
  
}
