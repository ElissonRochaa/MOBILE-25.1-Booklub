import 'package:booklub/ui/user/widgets/profile_header.dart';
import 'package:booklub/ui/user/widgets/section_title.dart';
import 'package:flutter/material.dart';
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
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Container branco começa mais embaixo, criando fundo arredondado
                Container(
                  margin: const EdgeInsets.only(top: 125),
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 300, left: 24, right: 24),
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

                      SectionTitle(
                        title: "Histórico de Leitura",
                        icon: Icons.book_rounded,
                      ),

                      SectionTitle(
                        title: "Meus Badges",
                        icon: Icons.bookmark_add_rounded,
                      ),
                    ],
                  ),
                ),

                // ProfileHeader posicionado por cima do container branco
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ProfileHeader(
                      name: 'Mariana Carvalho',
                      username: 'maric',
                      avatarUrl:
                          'https://i.pinimg.com/736x/49/6d/b2/496db2c246a23ffc00dd4ea8650f8fff.jpg',
                      quantidadeFriends: 4,
                      isMyOwnUserProfile: widget.isMyOwnUserProfile,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
