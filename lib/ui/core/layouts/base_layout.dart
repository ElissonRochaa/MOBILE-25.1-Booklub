import 'package:booklub/ui/core/widgets/app_bars/base_app_bar_widget.dart';
import 'package:booklub/ui/core/widgets/floating_action_buttons/base_floating_action_button_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_bars/base_bottom_bar_widget.dart';

class BaseLayout extends StatelessWidget {

  final Widget child;

  final bool appBarVisible;

  final bool bottomBarVisible;

  const BaseLayout({
    super.key,
    required this.child,
    this.appBarVisible = true,
    this.bottomBarVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = screenHeight * 0.064;
    final bottomBarHeight = (screenHeight - statusBarHeight
      - appBarHeight) * 0.08;
    final systemNavBarHeight = MediaQuery.of(context).padding.bottom;

    final body = Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/light-background.png',
            fit: BoxFit.cover,
            opacity: AlwaysStoppedAnimation(0.15),
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

    final appBar = appBarVisible
      ? BaseAppBarWidget(height: appBarHeight)
      : null;

    final bottomBar = bottomBarVisible
      ? BaseBottomBarWidget(height: bottomBarHeight)
      : null;

    final floatingActionButton = bottomBarVisible
      ? BaseFloatingActionButtonWidget()
      : null;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: appBar,
      body: body,
      bottomNavigationBar:bottomBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: floatingActionButton,
    );
  }

}
