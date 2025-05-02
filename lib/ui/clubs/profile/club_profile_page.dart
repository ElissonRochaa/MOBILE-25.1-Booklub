import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/ui/clubs/profile/view_models/club_profile_view_model.dart';
import 'package:booklub/utils/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ClubProfilePage extends StatelessWidget {

  final String clubId;

  late final Club club;

  ClubProfilePage({
    super.key,
    required this.clubId,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ClubProfileViewModel>();
    final futureClub = viewModel.findClubById(clubId);

    return SliverToBoxAdapter(
      child: AsyncBuilder(
        future: futureClub,
        onRetrieved: (club) {
          this.club = club;
          return Builder(builder: _buildPage);
        },
        onLoading: () => Builder(builder: _buildLoading),
        onError: (_, _) => Builder(builder: _buildError),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Column(
      children: [
        Builder(builder: _buildHeading),
      ]
    );
  }

  Widget _buildHeading(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final circleDiameter = screenWidth * 0.4;

    return Column(
      children: [
        Container(
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
        )
      ]
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator()
      ]
    );
  }

  Widget _buildError(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Club with id "$clubId" not found! =(')
        ]
      ),
    );
  }


}
