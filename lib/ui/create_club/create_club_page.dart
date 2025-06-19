import 'package:booklub/ui/core/widgets/buttons/purple_rounded_button.dart';
import 'package:booklub/ui/core/widgets/input_fields/image_field_widget.dart';
import 'package:booklub/ui/core/widgets/input_fields/named_text_field_widget.dart';
import 'package:booklub/ui/core/widgets/input_fields/toggleable_field_widget.dart';
import 'package:booklub/ui/create_club/view_models/create_club_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CreateClubPage extends StatelessWidget {
  const CreateClubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CreateClubViewModel>(context);

    if (viewModel.created) context.pop();

    if (viewModel.isLoading) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(24),
      sliver: SliverFillRemaining(
        hasScrollBody: false,
        child: Column(
          spacing: 32,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(builder: _buildClubImageField),
            Column(
              spacing: 12,
              children: [
                Builder(builder: _buildClubNameField),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Builder(builder: _buildPrivacityWidget)]
                ),
              ],
            ),
            PurpleRoundedButton("Criar", viewModel.createClub),
          ],
        ),
      ),
    );
  }

  Widget _buildClubImageField(BuildContext context) {
    final viewModel = context.read<CreateClubViewModel>();
    final screenWidth = MediaQuery.sizeOf(context).width;

    return ValueListenableBuilder(
      valueListenable: viewModel.clubImage,
      builder: (context, image, _) {
        final decorationImage = (image != null
          ? DecorationImage(image: FileImage(image), fit: BoxFit.cover)
          : null
        );

        return ImageFieldWidget(
          constraints: BoxConstraints(
            maxHeight: 172,
            maxWidth: 172,
          ),
          height: screenWidth * 0.4,
          width: screenWidth * 0.4,
          imagePicker: () => viewModel.picklubImage(),
          image: decorationImage,
        );
      }
    );
  }

  Widget _buildClubNameField(BuildContext context) {
    final viewModel = context.read<CreateClubViewModel>();

    return NamedTextFieldWidget(
      label: 'Nome do Clube',
      inputWrapper: viewModel.nameInput
    );
  }

  Widget _buildPrivacityWidget(BuildContext context) {
    final viewModel = context.read<CreateClubViewModel>();
    final textTheme = Theme.of(context).textTheme;

    return ToggleableFieldWidget(
      label: 'Privado',
      value: viewModel.isPrivate.value,
      labelStyle: textTheme.labelMedium,
      onChanged: (value) => viewModel.isPrivate.value = value,
    );
  }

}
