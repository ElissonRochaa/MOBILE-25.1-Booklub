import 'package:booklub/ui/core/layouts/_base_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import '_base_bottom_bar.dart';
import '_base_floating_action_button.dart';

class ScrollBaseLayout extends StatelessWidget {

  final Widget sliver;

  const ScrollBaseLayout({super.key, required this.sliver});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    final appBarHeight = screenHeight * 0.064;
    final bottomBarHeight = (screenHeight - statusBarHeight
        - appBarHeight) * 0.08;
    final systemNavBarHeight = MediaQuery
        .of(context)
        .padding
        .bottom;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: _buildBody(
        statusBarHeight: statusBarHeight,
        appBarHeight: appBarHeight,
        systemNavBarHeight: systemNavBarHeight,
        bottomBarHeight: bottomBarHeight,
        sliver: sliver,
      ),
      bottomNavigationBar: BaseBottomBar(height: bottomBarHeight),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BaseFloatingActionButton(),
    );
  }

  Widget _buildBody({
    required double statusBarHeight,
    required double appBarHeight,
    required double systemNavBarHeight,
    required double bottomBarHeight,
    required Widget sliver
  }) => Stack(
    children: [
      Positioned.fill(
        child: Image.asset(
          'assets/images/light-background.png',
          fit: BoxFit.cover,
        ),
      ),
      CustomScrollView(
        slivers: [
          BaseSliverAppBar(),
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: systemNavBarHeight + bottomBarHeight
            ),
            sliver: sliver
          ),
        ],
      ),
    ],
  );

}
