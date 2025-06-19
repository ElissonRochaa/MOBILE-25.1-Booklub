import 'package:booklub/ui/core/view_models/auth_view_model.dart';
import 'package:booklub/utils/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final authViewModel = context.watch<AuthViewModel>();

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
        icon: Icons.home_rounded,
        selected: currentRoute == Routes.home,
        destination: Routes.home,
      ),
      Spacer(flex: 1),
      buildNavIcon(
        icon: Icons.search_rounded,
        selected: currentRoute == Routes.explore,
        destination: Routes.explore,
      ),
      Spacer(flex: 2),
      buildNavIcon(
        icon: Icons.group,
        selected: currentRoute == Routes.clubs,
        destination: Routes.clubs,
      ),
      Spacer(flex: 1),
      AsyncBuilder(
        future: authViewModel.getAuthData(),
        onRetrieved:
            (authData) => buildNavIcon(
              icon: Icons.person,
              selected:
                  currentRoute ==
                  Routes.userProfile(
                    userId: authData.user.id,
                  ), //se mudar de id não vai mais estar selecionado. isso aqui é só para meu perfil ent não pode mudar o id
              destination: Routes.userProfile(userId: authData.user.id),
            ),
        onLoading:
            () => buildNavIcon(
              icon: Icons.person,
              selected: false,
              destination: currentRoute,
            ),
        onError:
            (_, _) => buildNavIcon(
              icon: Icons.person,
              selected: false,
              destination: currentRoute,
            ),
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
