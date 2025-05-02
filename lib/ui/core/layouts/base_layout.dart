import 'package:booklub/ui/core/widgets/app_bars/base_app_bar_widget.dart';
import 'package:booklub/ui/core/widgets/floating_action_buttons/base_floating_action_button_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_bars/base_bottom_bar_widget.dart';

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

    final body = Stack(
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

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: BaseAppBarWidget(height: appBarHeight),
      body: body,
      bottomNavigationBar: BaseBottomBarWidget(height: bottomBarHeight),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BaseFloatingActionButtonWidget(),
    );
  }

}
