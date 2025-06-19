import 'package:booklub/config/routing/routes.dart';
import 'package:booklub/ui/core/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
      icon: Icon(Icons.notifications_rounded),
      onPressed: () => context.push(Routes.notifications),
    ),
    PopupMenuButton(
      icon: Icon(Icons.more_vert),
      onSelected: (value) {
        switch (value) {
          case 'logout':
            context.read<AuthViewModel>().logout();
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'logout',
          child: Text('Logout'),
        ),
      ],
    ),
  ];

  @override
  Size get preferredSize => Size.fromHeight(height);
  
}
