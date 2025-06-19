import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_model/home_view_model.dart';
import 'package:booklub/ui/user/widgets/section_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.error != null) {
      return Center(child: Text('Error: ${viewModel.error}'));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (viewModel.myClubs.isEmpty) ...[
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Text(
                'Você ainda não participa de nenhum clube.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ] else ...[
            const SectionTitle(
              title: 'Meus Clubes',
              icon: Icons.menu_book_outlined,
            ),
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(bottom: 8),
                itemCount: viewModel.myClubs.length,
                itemBuilder: (context, index) {
                  final club = viewModel.myClubs[index];
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage:
                            club.imageUrl != null
                                ? NetworkImage(club.imageUrl!)
                                : const AssetImage(
                                      'assets/images/default_club.png',
                                    )
                                    as ImageProvider,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        club.name,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 12),
              ),
            ),
          ],

          const SectionTitle(
            title: 'Atividades',
            icon: Icons.local_activity_outlined,
          ),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('As atividades mais recentes aparecerão aqui.'),
          ),
        ],
      ),
    );
  }
}
