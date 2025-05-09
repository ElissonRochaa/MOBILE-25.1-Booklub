import 'package:booklub/ui/core/widgets/grids/base_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ExplorePage extends StatelessWidget {

  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: BaseGridWidget.sliver(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 128,
          mainAxisSpacing: 16
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => _buildHorizontalCard(
            colorScheme: colorScheme,
            imageProvider: NetworkImage('https://i.pinimg.com/236x/ca/69/5c/ca695c269ab2dcf39c9ff5459ee65662.jpg'),
            child: Column(
              children: [
                Text('Spider Man Fans'),
                Text('A culpa é das estrelas')
              ],
            )
          ),
          childCount: 6
        )
      ),
    );
  }

  Widget _buildHorizontalCard({
    required ColorScheme colorScheme,
    ImageProvider? imageProvider,
    Widget? child,
    VoidCallback? onTap,
  }) {
    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(100),
      topRight: Radius.circular(25),
      bottomLeft: Radius.circular(100),
      bottomRight: Radius.circular(25)
    );

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: borderRadius
      ),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCardImage(
              colorScheme: colorScheme,
              imageProvider: imageProvider
            ),
            if (child != null) child,
          ]
        ),
      ),
    );
  }

  Align _buildCardImage({
    required ColorScheme colorScheme,
    ImageProvider? imageProvider,
  }) {
    final decorationImage = imageProvider != null
      ? DecorationImage(
        image: imageProvider,
        fit: BoxFit.cover,
      )
      : null;

    return Align(
      alignment: Alignment.topCenter,
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          width: constraints.maxHeight,
          decoration: BoxDecoration(
            border: Border.all(
              color: colorScheme.primary,
              width: 3.2
            ),
            color: Colors.white,
            shape: BoxShape.circle,
            image: decorationImage,
          ),
        ),
      ),
    );
  }

}
