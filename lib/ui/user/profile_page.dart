import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/domain/entities/users/user.dart';
import 'package:booklub/ui/core/widgets/grids/infinite_horizontal_widget.dart';
import 'package:booklub/ui/user/view_models/user_profile_view_model.dart';
import 'package:booklub/ui/user/widgets/circular_carousel.dart';
import 'package:booklub/ui/user/widgets/item_circle.dart';
import 'package:booklub/ui/user/widgets/profile_header.dart';
import 'package:booklub/ui/user/widgets/section_title.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  final bool isMyOwnUserProfile;

  const ProfilePage({
    super.key,
    required this.userId,
    required this.isMyOwnUserProfile,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userProfileViewModel = context.read<UserProfileViewModel>();
    final userFuture = userProfileViewModel.getUserData(widget.userId);
    final clubsFuture = userProfileViewModel.getUserClubs(4, widget.userId);

    return FutureBuilder(
      future: Future.wait([userFuture, clubsFuture]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(child: Text('Erro: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const SliverToBoxAdapter(
            child: Center(child: Text('Dados não encontrados')),
          );
        }

        final user = snapshot.data![0] as User;
        final clubsPaginator = snapshot.data![1] as Paginator<Club>;

        return MultiSliver(
          children: [
            SliverToBoxAdapter(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 125),
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 300,
                      left: 24,
                      right: 24,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F5F7).withAlpha(210),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 16,
                          offset: Offset(0, -8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(
                          title: "Meus Clubes",
                          icon: Icons.menu_book_outlined,
                        ),
                        InfiniteHorizontalList<Club>(
                          paginator: clubsPaginator,
                          itemBuilder: (club) {
                            return ItemCircle(imageUrl: club.imageUrl ?? '');
                          },
                        ),

                        SectionTitle(
                          title: "Histórico de Leitura",
                          icon: Icons.book_rounded,
                        ),
                        HorizontalCarousel(
                          items: [],
                        ),
                        SectionTitle(
                          title: "Meus Badges",
                          icon: Icons.bookmark_add_rounded,
                        ),
                        HorizontalCarousel(
                          items: [],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ProfileHeader(
                        name: user.fullName,
                        username: user.username,
                        avatarUrl: user.imageUrl ?? '',
                        quantidadeFriends:
                            4,
                        isMyOwnUserProfile: widget.isMyOwnUserProfile,
                        userId: widget.userId,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
