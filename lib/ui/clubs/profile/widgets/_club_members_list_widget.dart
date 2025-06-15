import 'package:booklub/config/routing/routes.dart';
import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/domain/entities/users/user.dart';
import 'package:booklub/ui/clubs/profile/view_models/club_profile_view_model.dart';
import 'package:booklub/ui/core/widgets/circle_image_widget.dart';
import 'package:booklub/ui/core/widgets/grids/infinite_grid_widget.dart';
import 'package:booklub/utils/async_builder.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ClubMembersListWidget extends StatelessWidget {

  const ClubMembersListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ClubProfileViewModel>();

    return AsyncBuilder(
      future: viewModel.getClubMembers(8),
      onRetrieved: (paginator) => Builder(
        builder: (ctx) => onRetrieved(ctx, paginator)
      ),
      onLoading: () => Builder(
        builder: onLoading
      ),
      onError: (error, stackTrace) => Builder(
        builder: (ctx) => onError(ctx, error, stackTrace)
      ),
    );
  }

  Widget onRetrieved(BuildContext context, Paginator<User> paginator) {
    final scrollController = context.read<ScrollController>();

    final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      childAspectRatio: 9/2,
      mainAxisSpacing: 12
    );

    SliverChildBuilderDelegate childrenDelegateProvider(
      List<User> users,
      int totalUsers
    ) => SliverChildBuilderDelegate(
      (context, index) => _ClubMemberCard(member: users[index]),
      childCount: totalUsers
    );

    return SliverPadding(
      padding: EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: 36
      ),
      sliver: InfiniteGridWidget.sliver(
        paginator: paginator,
        controller: scrollController,
        gridDelegate: gridDelegate,
        childrenDelegateProvider: childrenDelegateProvider
      ),
    );
  }

  Widget onLoading(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget onError(BuildContext context, Object error, StackTrace stackTrace) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Text('Erro ao carregar membros do clube'),
      ),
    );
  }

}

class _ClubMemberCard extends StatelessWidget {

  final User member;

  const _ClubMemberCard({
    super.key,
    required this.member
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final decorationImage = member.imageUrl != null
      ? DecorationImage(
          image: NetworkImage(member.imageUrl!)
        )
      : null;

    final border = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(100),
        topRight: Radius.circular(36),
        bottomLeft: Radius.circular(100),
        bottomRight: Radius.circular(36),
      )
    );

    final details = Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(member.fullName),
        Text(member.username)
      ],
    );

    void onTap() => context.push(
      Routes.userProfile(userId: member.id)
    );

    return InkWell(
      onTap: onTap,
      child: Card(
        shape: border,
        child: Row(
          children: [
            CircleImageWidget.expanded(
              backgroundColor: colorScheme.white,
              decorationImage: decorationImage,
              borderColor: colorScheme.primary,
              borderWidth: 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: details,
            )
          ],
        ),
      ),
    );
  }

}

