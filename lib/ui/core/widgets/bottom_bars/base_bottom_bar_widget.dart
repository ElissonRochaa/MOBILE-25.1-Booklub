import 'package:flutter/material.dart';
import '../../../../config/routing/routes.dart';
import '../../../../utils/routing/routing_utils.dart';
import '../navigation_icon_widget.dart';

class BaseBottomBarWidget extends StatelessWidget {
  final double height;

  const BaseBottomBarWidget({
    super.key,
    this.height = kBottomNavigationBarHeight,
  });

  @override
  Widget build(BuildContext context) {
    final currentRoute = RoutingUtils.getRoute(context);
    final colorScheme = Theme.of(context).colorScheme;

    Widget buildNavIcon({
      required IconData icon,
      required bool selected,
      required String destination,
    }) => Flexible(
      flex: 1,
      child: NavigationIconWidget(
        icon: icon,
        selected: selected,
        destination: destination,
      ),
    );

    final navigationIcons = [
      buildNavIcon(
        icon: Icons.group,
        selected: currentRoute == Routes.clubs,
        destination: Routes.clubs,
      ),
      Spacer(flex: 1),
      buildNavIcon(
        icon: Icons.person,
        selected: currentRoute == Routes.userProfile(userId: 'abc123'), //se mudar de id não vai mais estar selecionado. isso aqui é só para meu perfil ent não pode mudar o id
        destination: Routes.userProfile(userId: 'abc123'),
      ),
    ];

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      height: height,
      color: colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: navigationIcons,
      ),
    );
  }
}
