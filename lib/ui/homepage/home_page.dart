import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_model/home_view_model.dart';
import 'package:booklub/ui/user/widgets/section_title.dart';
import 'widgets/club_card_widget.dart';
import 'package:booklub/ui/core/widgets/cards/activity_cards/activity_card_builder.dart';
import 'package:booklub/utils/async_builder.dart';
import 'package:booklub/ui/core/widgets/grids/infinite_grid_widget.dart';
import 'package:booklub/domain/activities/entities/activity.dart';
import 'package:booklub/utils/pagination/paginator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 1,
    mainAxisSpacing: 12,
    childAspectRatio: 4 / 2,
  );

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return AsyncBuilder.fromAsyncChangeNotifier(
      asyncChangeNotifier: viewModel,
      onRetrieved:
          (payload) => CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPadding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 12,
                  bottom: 36,
                ),
                sliver: SliverToBoxAdapter(
                  child: const SectionTitle(
                    title: 'Meus Clubes',
                    icon: Icons.menu_book_outlined,
                  ),
                ),
              ),

              if (payload.myClubs.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text(
                      'Você ainda não participa de nenhum clube.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              else
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 170,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: payload.myClubs.length,
                      itemBuilder: (context, index) {
                        final club = payload.myClubs[index];
                        return ClubCardWidget(club: club);
                      },
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                    ),
                  ),
                ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: const SectionTitle(
                    title: 'Atividades',
                    icon: Icons.local_activity_outlined,
                  ),
                ),
              ),
              FutureBuilder<Paginator<Activity>>(
                future: viewModel.getRecentActivitiesPaginator(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasError) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          "Erro ao carregar atividades: ${snapshot.error}",
                        ),
                      ),
                    );
                  }

                  final paginator = snapshot.data!;
                  return InfiniteGridWidget.sliver(
                    paginator: paginator,
                    controller: scrollController,
                    gridDelegate: gridDelegate,
                    childrenDelegateProvider: (activities, total) {
                      print('Tem $total atividades');
                      return SliverChildBuilderDelegate((context, index) {
                        final activity = activities[index];
                        try {
                          return ActivityCardBuilder(
                            activity: activity,
                            showAuthorHeader: true,
                          );
                        } catch (e) {
                          debugPrint("Skipping invalid activity: $e");
                          return const SizedBox.shrink();
                        }
                      }, childCount: total);
                    },
                  );
                },
              ),
            ],
          ),
      onLoading: () => const Center(child: CircularProgressIndicator()),
      onError: (e, stack) => Center(child: Text("Erro: $e")),
    );
  }
}
