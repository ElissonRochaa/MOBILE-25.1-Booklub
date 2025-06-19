import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/ui/core/widgets/buttons/purple_rounded_button.dart';
import 'package:booklub/ui/create-club/view_models/create_club_view_model.dart';
import 'package:booklub/ui/create-club/widgets/club_privacy_toggle.dart';
import 'package:booklub/ui/create-club/widgets/number_input_rounded.dart';
import 'package:booklub/ui/create-club/widgets/text_input_rounded.dart';
import 'package:booklub/ui/register/view_models/input_field_validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateClubPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreateClubPage> {
  final InputFieldValidation fieldValidatorModel = InputFieldValidation();
  bool hasParticipantLimit = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CreateClubViewModel>(context);
    ThemeData theme = Theme.of(context);

    return SliverPadding(
      padding: EdgeInsets.all(30),
      sliver: SliverToBoxAdapter(
        child: Form(
          key: viewModel.formKey,
          child: Column(
            spacing: 30,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildClubNameWidget(theme),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildPrivacityWidget(theme),
                  _buildParticipantsLimit(theme),
                ],
              ),
              _buildUploadWidget(theme),
              PurpleRoundedButton("Criar", () => viewModel.createClub()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadWidget(ThemeData theme) {
    final viewModel = Provider.of<CreateClubViewModel>(context);

    return InkWell(
      onTap: () async {
        await viewModel.pickCoverImage();
      },
      child: Container(
        height: 250,
        width: 250,
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(blurRadius: 5, color: theme.colorScheme.shadow),
          ],
          image:
              viewModel.coverImage != null
                  ? DecorationImage(
                    image: FileImage(viewModel.coverImage!),
                    fit: BoxFit.cover,
                  )
                  : null,
        ),
        child: viewModel.coverImage == null ? _buildUploadSquare(theme) : null,
      ),
    );
  }

  Widget _buildUploadSquare(ThemeData theme) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      heightFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(color: theme.colorScheme.darkWhite),
        child: Center(
          child: Icon(
            Icons.file_upload_outlined,
            size: 25,
            color: theme.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildClubNameWidget(ThemeData theme) {
    final viewModel = Provider.of<CreateClubViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabelText("Nome do seu clube", theme),
        TextFieldRounded(
          fieldValidatorModel.validateBasicTextField,
          (value) => viewModel.updateClubName(value),
        ),
      ],
    );
  }

  Widget _buildPrivacityWidget(ThemeData theme) {
    final viewModel = Provider.of<CreateClubViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabelText("Clube Privado", theme),
        ClubPrivacyToggle(
          viewModel.isPrivate,
          (value) => viewModel.togglePrivacy(),
        ),
      ],
    );
  }

  Widget _buildParticipantsLimit(ThemeData theme) {
    final viewModel = Provider.of<CreateClubViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabelText("Limite de\nparticipantes", theme),
        Row(
          children: [
            Checkbox(
              value: hasParticipantLimit,
              onChanged: (bool? value) {
                setState(() {
                  hasParticipantLimit = value ?? false;
                });
              },
              activeColor: theme.colorScheme.primary,
              checkColor: theme.colorScheme.onPrimary,
            ),
            if (hasParticipantLimit)
              SizedBox(
                width: 80,
                child: IntFieldRounded(
                  fieldValidatorModel.validateBasicTextField,
                  (value) => viewModel.updateParticipantLimit(value),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildLabelText(String label, ThemeData theme) {
    return Text(
      label,
      style: TextStyle(
        color: theme.colorScheme.secondary,
        fontSize: 24,
        fontFamily: 'Navicula',
      ),
    );
  }
}
