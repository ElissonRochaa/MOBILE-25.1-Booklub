import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/ui/clubs/profile/view_models/club_profile_view_model.dart';
import 'package:booklub/ui/clubs/profile/widgets/club_activities_list_widget.dart';
import 'package:booklub/ui/core/widgets/circle_image_widget.dart';
import 'package:booklub/utils/async_builder.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ClubProfilePage extends StatefulWidget {

  final String clubId;

  const ClubProfilePage({
    super.key,
    required this.clubId,
  });

  @override
  State<ClubProfilePage> createState() => _ClubProfilePageState();
}

enum ClubActivity {recentes, leituras, encontros}

class _ClubProfilePageState extends State<ClubProfilePage> {

  Club? club;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ClubProfileViewModel>();
    final futureClub = viewModel.findClubById(widget.clubId);

    return AsyncBuilder(
      future: futureClub,
      onRetrieved: (club) {
        this.club = club;
        return Builder(builder: _buildPage);
      },
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
              'Club with id "${widget.clubId}" not found! =(',
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
    final scrollController = context.read<ScrollController>();

    return MultiSliver(
      children: [
        Builder(builder: _buildHeading),
        ClubActivitiesListWidget(scrollController: scrollController),
      ]
    );
  }

  Widget _buildHeading(BuildContext context) {
    return MultiSliver(
      children: [
        Builder(builder: _buildClubImage),
        Builder(builder: _buildClubLabel),
        Builder(builder: _buildProfileInfo),
      ]
    );
  }

  Widget _buildClubImage(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final minRadius = 120.0;
    final desiredRadius = screenWidth * 0.15;
    final maxRadius = desiredRadius > minRadius ? desiredRadius : minRadius;

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 24),
        color: colorScheme.white,
        child: CircleImageWidget(
          constraint: CircleConstraint(
            minRadius: minRadius,
            maxRadius: maxRadius
          ),
          backgroundColor: colorScheme.white,
          borderColor: colorScheme.primary,
          borderWidth: 2,
          decorationImage: DecorationImage(
            image: NetworkImage(club!.imageUrl),
          ),
        ),
      ),
    );
  }

  Widget _buildClubLabel(BuildContext context) {
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
          club!.name,
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
        color: colorScheme.white,
        child: labels
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Widget profileInfoCard(String section, int value) => Expanded(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
              color: colorScheme.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(
                color: Colors.black,
                offset: Offset(1, 0.5),
                blurRadius: 2,
              )]
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
            child: Column(
              children: [
                Text(
                  value.toString(),
                  style: textTheme.labelLarge!.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
                Text(section)
              ],
            ),
          ),
        ),
      ),
    );

    final profileInfo = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      spacing: 8,
      children: [
        profileInfoCard('Membros', 8),
        profileInfoCard('Leituras', 3),
        profileInfoCard('Badges', 1),
        profileInfoCard('Solicitações', 4),
      ],
    );

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 24),
        color: colorScheme.white,
        child: profileInfo,
      ),
    );
  }

}
