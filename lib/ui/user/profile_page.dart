import 'package:booklub/ui/user/widgets/circular_carousel.dart';
import 'package:booklub/ui/user/widgets/item_circle.dart';
import 'package:booklub/ui/user/widgets/item_rect.dart';
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
                    HorizontalCarousel(
                      items: [
                        ItemCircle(
                          imageUrl:
                              'https://static.wikia.nocookie.net/marvels-avengers4475/images/6/63/N7UmKNPcZKKZNb8J1PxPWgsa~2.jpg/revision/latest/scale-to-width-down/1200?cb=20220903204205',
                        ),
                        ItemCircle(
                          imageUrl:
                              'https://img.odcdn.com.br/wp-content/uploads/2021/08/Marvels-Avengers-Spider-Man.jpg',
                        ),
                        ItemCircle(
                          imageUrl:
                              'https://recreio.com.br/media/uploads/dc_comics/jlaavengers_capa.jpg',
                        ),
                        ItemCircle(
                          imageUrl:
                              'https://s2-techtudo.glbimg.com/O2bSuHnqYLyc9stkml3J8L-QkD0=/0x0:1444x500/888x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_08fbf48bc0524877943fe86e43087e7a/internal_photos/bs/2020/P/4/3VItCzSROwvTWjC7el6A/marvels-avengers-review-capa.jpg',
                        ),
                      ],
                    ),

                    SectionTitle(
                      title: "Histórico de Leitura",
                      icon: Icons.book_rounded,
                    ),

                    HorizontalCarousel(
                      items: [
                        ItemRectangle(
                          imageUrl:
                              'https://cinema10.com.br/upload/series/series_4145_quartaasa.png',
                        ),
                        ItemRectangle(
                          imageUrl:
                              'https://media.theeverygirl.com/wp-content/uploads/2023/10/sarah-j-maas-the-everygirl-4-667x1024.jpeg',
                        ),
                        ItemRectangle(
                          imageUrl:
                              'https://snworksceo.imgix.net/cds/fed37627-d796-48b8-888c-813b6f96a0b4.sized-1000x1000.jpg?w=1000&dpr=2',
                        ),
                        ItemRectangle(
                          imageUrl:
                              'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1564577305i/38820046._UX160_.jpg',
                        ),
                      ],
                    ),

                    SectionTitle(
                      title: "Meus Badges",
                      icon: Icons.bookmark_add_rounded,
                    ),
                    HorizontalCarousel(
                      items: [
                        ItemCircle(
                          imageUrl:
                              'https://i0.wp.com/greatplacetowork.me/wp-content/uploads/2025/01/2025_National-List-Badge_KSA.png?fit=3751%2C3751&ssl=1',
                        ),
                        ItemCircle(
                          imageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTX4AEhVlZToAikcUGfmncZDrkmPVoaHFUTisKeaKSDgdXAQ6UbbN8GamvSxpptMDRiNRM&usqp=CAU',
                        ),
                        ItemCircle(
                          imageUrl:
                              'https://aniportalimages.s3.amazonaws.com/media/details/Screenshot_2022-04-15_100038Workplaces.png',
                        ),
                        ItemCircle(
                          imageUrl:
                              'https://www.greatplacetowork.in/wp-content/uploads/2024/11/2024_India_IT-IT-BPM-logo.png',
                        ),
                        ItemCircle(
                          imageUrl:
                              'https://f.hubspotusercontent40.net/hubfs/5369947/Best%20Workplaces%20Ireland%202021%20-%20INCL%20GS%20LOGO-1.png',
                        ),
                      ],
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
                    userId: widget.userId,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
