import 'package:flutter/material.dart';
import 'package:booklub/ui/core/layouts/scroll_base_layout.dart';
import 'package:sliver_tools/sliver_tools.dart';

class IndividualBookPage extends StatelessWidget {
  const IndividualBookPage({super.key, required this.bookId});

  final String bookId;

  @override
  Widget build(BuildContext context) {

    return ScrollBaseLayout(
      sliver: MultiSliver(
        children: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(child: Text('Book Details')),
          ),
        ],
      ),
    );
  }
}

