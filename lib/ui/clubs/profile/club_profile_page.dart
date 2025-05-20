import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/ui/clubs/profile/view_models/club_profile_view_model.dart';
import 'package:booklub/ui/clubs/profile/widgets/club_activities_list_widget.dart';
import 'package:booklub/utils/async_builder.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ClubProfilePage extends StatelessWidget {

  final String clubId;

  late final Club club;

  // ignore: prefer_const_constructors_in_immutables
  ClubProfilePage({
    super.key,
    required this.clubId,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ClubProfileViewModel>();
    final futureClub = viewModel.findClubById(clubId);

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
    return SliverToBoxAdapter(
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
    return SliverToBoxAdapter(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Club with id "$clubId" not found! =(')
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
    final screenWidth = MediaQuery.of(context).size.width;
    final circleDiameter = screenWidth * 0.4;

    return Container(
      height: circleDiameter,
      width: circleDiameter,
      constraints: BoxConstraints(
          maxWidth: 120,
          maxHeight: 120
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(
            image: NetworkImage(club.imageUrl),
            fit: BoxFit.cover
        ),
      ),
    );
  }

  Widget _buildClubLabel(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: 8,
        children: [
          profileInfoCard('Membros', 8),
          profileInfoCard('Leituras', 3),
          profileInfoCard('Badges', 1),
          profileInfoCard('Solicitações', 4),
        ],
      ),
    );
  }

}
