import 'package:booklub/ui/core/widgets/app_bars/base_app_bar_widget.dart';
import 'package:booklub/ui/core/widgets/floating_action_buttons/base_floating_action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/bottom_bars/base_bottom_bar_widget.dart';

class ScrollBaseLayout extends StatefulWidget {

  final Widget sliver;

  final bool appBarVisible;

  final bool bottomBarVisible;

  final String label;

  final bool hideShadow;

  final VoidCallback? onCreateButtonClicked;

  const ScrollBaseLayout({
    super.key,
    required this.sliver,
    this.label = 'Booklub',
    this.appBarVisible = true,
    this.bottomBarVisible = true,
    this.onCreateButtonClicked,
    this.hideShadow = false,
  });

  @override
  State<ScrollBaseLayout> createState() => _ScrollBaseLayoutState();

}

class _ScrollBaseLayoutState extends State<ScrollBaseLayout> {

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = screenHeight * 0.064;
    final bottomBarHeight = widget.bottomBarVisible
      ? (screenHeight - statusBarHeight - appBarHeight) * 0.08
      : 0.0;
    final systemNavBarHeight = MediaQuery.of(context).padding.bottom;

    final body = Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/light-background.png',
            fit: BoxFit.cover,
            opacity:  const AlwaysStoppedAnimation(0.15),
          ),
        ),
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            if (widget.appBarVisible) BaseAppBarWidget.sliver(
              label: widget.label,
              hideShadow: widget.hideShadow,
              height: appBarHeight
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                bottom: systemNavBarHeight + bottomBarHeight,
              ),
              sliver: widget.sliver,
            ),
          ],
        ),
      ],
    );

    final bottomBar = widget.bottomBarVisible
      ? BaseBottomBarWidget(height: bottomBarHeight)
      : null;

    final floatingActionButton = widget.bottomBarVisible
      ? BaseFloatingActionButtonWidget(
          onPressed: widget.onCreateButtonClicked,
        )
      : null;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: ChangeNotifierProvider.value(value: _scrollController, child: body),
      bottomNavigationBar: bottomBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: floatingActionButton,
    );
  }

}
