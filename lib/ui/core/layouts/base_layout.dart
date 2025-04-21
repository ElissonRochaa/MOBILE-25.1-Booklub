import 'package:booklub/config/routing/routes.dart';
import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/ui/core/widgets/navigation_icon_widget.dart';
import 'package:booklub/utils/routing/routing_utils.dart';
import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {

  final Widget child;

  const BaseLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = screenHeight * 0.064;
    final bottomBarHeight = (screenHeight - statusBarHeight
      - appBarHeight) * 0.08;
    final systemNavBarHeight = MediaQuery.of(context).padding.bottom;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: _buildAppBar(
        colorScheme: colorScheme,
        appBarHeight: appBarHeight,
      ),
      body: _buildBody(
        statusBarHeight: statusBarHeight,
        appBarHeight: appBarHeight,
        systemNavBarHeight: systemNavBarHeight,
        bottomBarHeight: bottomBarHeight,
        child: child,
      ),
      bottomNavigationBar: _buildBottomBar(
        context: context,
        colorScheme: colorScheme,
        bottomBarHeight: bottomBarHeight,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  PreferredSize _buildAppBar({
    required double appBarHeight,
    required ColorScheme colorScheme
  }) => PreferredSize(
    preferredSize: Size.fromHeight(appBarHeight),
    child: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Booklub',
        style: TextStyle(
          fontFamily: 'Navicula',
          color: colorScheme.primary,
          fontSize: 32,
          fontWeight: FontWeight.w400,
          shadows: [Shadow(
            color: colorScheme.black,
            blurRadius: 4,
            offset: Offset(-1, 1)
          )]
        ),
      ),
    ),
  );

  Widget _buildBody({
    required double statusBarHeight,
    required double appBarHeight,
    required double systemNavBarHeight,
    required double bottomBarHeight,
    required Widget child
  }) => Stack(
    children: [
      Positioned.fill(
        child: Image.asset(
          'assets/images/light-background.png',
          fit: BoxFit.cover,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: statusBarHeight + appBarHeight,
          bottom: systemNavBarHeight + bottomBarHeight
        ),
        child: child,
      )
    ],
  );

  Widget _buildBottomBar({
    required BuildContext context,
    required ColorScheme colorScheme,
    required double bottomBarHeight
  }) {
    final currentRoute = RoutingUtils.getRoute(context);

    Widget buildNavIcon({
      required IconData icon,
      required bool selected,
      required String destination
    }) => Flexible(
      flex: 1,
      child: NavigationIconWidget(
        icon: icon,
        selected: selected,
        destination: destination,
      )
    );

    final navigationIcons = [
      buildNavIcon(
        icon: Icons.group,
        selected: currentRoute == Routes.groups,
        destination: Routes.groups
      ),
      Spacer(flex: 1),
      buildNavIcon(
        icon: Icons.person,
        selected: currentRoute == Routes.profile,
        destination: Routes.profile
      )
    ];

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      height: bottomBarHeight,
      color: colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: navigationIcons,
      ),
    );
  }

}
