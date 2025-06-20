import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/ui/clubs/profile/view_models/club_profile_view_model.dart';
import 'package:booklub/ui/clubs/profile/widgets/club_profile_page_body_widget.dart';
import 'package:booklub/ui/core/widgets/circle_image_widget.dart';
import 'package:booklub/utils/async_builder.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ClubProfilePage extends StatelessWidget {

  final Logger logger = Logger(printer: SimplePrinter());

  ClubProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ClubProfileViewModel>();

    logger.i('Building ClubProfilePage');

    return AsyncBuilder.fromAsyncChangeNotifier(
      asyncChangeNotifier: viewModel,
      onRetrieved: (club) => Builder(builder: _buildPage),
      onLoading: () => Builder(builder: _buildLoadingPage),
      onError: (_, _) => Builder(builder: _buildErrorPage),
    );
  }

  Widget _buildLoadingPage(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator()
        ]
      ),
    );
  }

  Widget _buildErrorPage(BuildContext context) {
    final viewModel = context.read<ClubProfileViewModel>();
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Club with id "${viewModel.clubId}" not found! =(',
              style: textTheme.titleSmall!.copyWith(
                color: colorScheme.error,
              ),
            )
          ]
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return MultiSliver(
      children: [
        Builder(builder: _buildClubImage),
        Builder(builder: _buildClubLabel),
        ClubProfilePageBodyWidget()
      ]
    );
  }

  Widget _buildClubImage(BuildContext context) {
    final club = context.watch<ClubProfileViewModel>().club!;
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    const minRadius = 120.0;
    final desiredRadius = screenWidth * 0.15;
    final maxRadius = desiredRadius > minRadius ? desiredRadius : minRadius;

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 24),
        color: colorScheme.surfaceContainerHighest,
        child: CircleImageWidget(
          constraint: CircleConstraint(
            minRadius: minRadius,
            maxRadius: maxRadius
          ),
          backgroundColor: colorScheme.white,
          borderColor: colorScheme.primary,
          borderWidth: 2,
          decorationImage: DecorationImage(
            image: NetworkImage(club.imageUrl!),
          ),
        ),
      ),
    );
  }

  Widget _buildClubLabel(BuildContext context) {
    final club = context.watch<ClubProfileViewModel>().club!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final labels = Column(
      children: [
        Text(
          'Clube',
          style: textTheme.titleMedium!.copyWith(
            color: colorScheme.secondary,
            fontFamily: 'Navicula',
            fontWeight: FontWeight.w700
          ),
        ),
        Text(
          club.name,
          style: textTheme.titleLarge!.copyWith(
            color: colorScheme.primary,
            fontFamily: 'Navicula',
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        color: colorScheme.surfaceContainerHighest,
        child: labels
      ),
    );
  }

}
