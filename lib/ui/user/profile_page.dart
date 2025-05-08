import 'package:booklub/ui/user/widgets/profile_header.dart';
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
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, -8),
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

              Text(
                'Meus Clubes',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontFamily: 'Navicula',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
