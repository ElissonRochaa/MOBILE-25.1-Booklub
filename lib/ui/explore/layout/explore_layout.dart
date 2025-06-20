import 'package:booklub/ui/core/widgets/bottom_bars/base_bottom_bar_widget.dart';
import 'package:booklub/ui/core/widgets/floating_action_buttons/base_floating_action_button_widget.dart';
import 'package:booklub/ui/explore/widget/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExploreLayout extends StatefulWidget {
  final Widget sliver;

  const ExploreLayout({super.key, required this.sliver});

  @override
  State<ExploreLayout> createState() => _ExploreLayoutState();
}

class _ExploreLayoutState extends State<ExploreLayout> {
  late final ScrollController _scrollController;
  final TextEditingController _searchController = TextEditingController();

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
    final colorScheme = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = screenHeight * 0.064;
    final bottomBarHeight =
        (screenHeight - statusBarHeight - appBarHeight) * 0.08;
    final systemNavBarHeight = MediaQuery.of(context).padding.bottom;

    final searchBar = SliverAppBar(
      expandedHeight: appBarHeight,
      elevation: 0,
      title: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            context.read<SearchQueryNotifier>().update(value);
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 13),
            hintText: 'Pesquisar',
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
      ),
    );

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
            searchBar,
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

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: ChangeNotifierProvider.value(value: _scrollController, child: body),
      bottomNavigationBar: BaseBottomBarWidget(height: bottomBarHeight),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BaseFloatingActionButtonWidget(),
    );
  }
}
