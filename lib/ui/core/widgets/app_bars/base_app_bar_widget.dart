import 'package:booklub/config/routing/routes.dart';
import 'package:booklub/config/theme/theme_context.dart';
import 'package:booklub/ui/core/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BaseAppBarWidget extends StatelessWidget implements PreferredSizeWidget {

  final double height;

  final String label;

  final bool hideShadow;

  final bool sliver;

  const BaseAppBarWidget({
    super.key,
    this.height = kToolbarHeight,
    this.label = 'Booklub',
    this.hideShadow = false,
  }): sliver=false;

  const BaseAppBarWidget.sliver({
    super.key,
    this.height = kToolbarHeight,
    this.label = 'Booklub',
    this.hideShadow = false,
  }): sliver=true;

  @override
  Widget build(BuildContext context) => sliver
      ? Builder(builder: _buildSliverAppBar)
      : Builder(builder: _buidAppBar);

  Widget _buidAppBar(BuildContext context) => PreferredSize(
    preferredSize: Size.fromHeight(height),
    child: AppBar(
      title: Text(label),
      actions: _getActions(context),
      shadowColor: hideShadow ? Colors.transparent : null,
    ),
  );

  Widget _buildSliverAppBar(BuildContext context) => SliverAppBar(
    floating: true,
    title: Text(label),
    actions: _getActions(context),
    forceElevated: true,
    shadowColor: hideShadow ? Colors.transparent : null,
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
          case 'light':
            context.read<ThemeContext>().setLightTheme(save: true);
            break;
          case 'dark':
            context.read<ThemeContext>().setDarkTheme(save: true);
            break;
          case 'system':
            context.read<ThemeContext>().setSystemTheme(save: true);
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'light',
          child: Text('Theme: Light')
        ),
        PopupMenuItem(
          value: 'dark',
          child: Text('Theme: Dark')
        ),
        PopupMenuItem(
          value: 'system',
          child: Text('Theme: System')
        ),
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
