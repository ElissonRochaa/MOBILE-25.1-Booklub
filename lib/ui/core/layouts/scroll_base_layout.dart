import 'package:booklub/ui/core/widgets/app_bars/base_app_bar_widget.dart';
import 'package:booklub/ui/core/widgets/floating_action_buttons/base_floating_action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/bottom_bars/base_bottom_bar_widget.dart';

class ScrollBaseLayout extends StatefulWidget {

  final Widget sliver;

  const ScrollBaseLayout({
    super.key,
    required this.sliver,
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

    final body = Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/light-background.png',
            fit: BoxFit.cover,
          ),
        ),
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            BaseAppBarWidget.sliver(),
            SliverPadding(
              padding: EdgeInsets.only(
                  bottom: systemNavBarHeight + bottomBarHeight
              ),
              sliver: widget.sliver
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: ChangeNotifierProvider.value(
        value: _scrollController,
        child: body
      ),
      bottomNavigationBar: BaseBottomBarWidget(height: bottomBarHeight),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BaseFloatingActionButtonWidget(),
    );
  }
}

