import 'package:flutter/material.dart';
import 'package:booklub/ui/core/layouts/scroll_base_layout.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:booklub/ui/book/widgets/review_card_widget.dart';

class IndividualBookPage extends StatelessWidget {
  const IndividualBookPage({super.key, required this.bookId});

  final String bookId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return ScrollBaseLayout(
      sliver: MultiSliver(
        children: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Capa, título e autor centralizados
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Capa do livro
                        Container(
                          height: 229,
                          width: 153,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/misery_capa.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Título
                        Text(
                          "Misery",
                          style: textTheme.titleLarge?.copyWith(
                            color: colorScheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),

                        // Autor
                        Text(
                          "Stephen King",
                          style: textTheme.titleSmall?.copyWith(
                            color: colorScheme.secondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Quantos clubes leram/estão lendo o livro
                  Row(
                    children: [
                      Icon(Icons.group, color: colorScheme.primary),
                      const SizedBox(width: 8),
                      const Text("Read by 15 clubs"),
                      const SizedBox(width: 16),
                      Icon(Icons.play_arrow, color: colorScheme.primary),
                      const SizedBox(width: 8),
                      const Text("Currently read by 4 clubs"),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Estrelas
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 4),
                      Text("4.5"),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Resenhas
                  Text("Reviews", style: textTheme.titleMedium),
                  const SizedBox(height: 12),

                  ...List.generate(
                    3,
                    (index) => const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: ReviewCard(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
