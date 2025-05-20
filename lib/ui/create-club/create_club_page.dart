import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/ui/core/view_models/input_field_validation.dart';
import 'package:booklub/ui/core/widgets/buttons/purple_rounded_button.dart';
import 'package:booklub/ui/core/widgets/text_input_fields/text_field_with_field_name.dart';
import 'package:booklub/ui/create-club/view_models/create_club_view_model.dart';
import 'package:booklub/ui/create-club/widgets/club_privacy_toggle.dart';
import 'package:booklub/ui/create-club/widgets/number_input_rounded.dart';
import 'package:booklub/ui/create-club/widgets/text_input_rounded.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CreateClubPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreateClubPage> {
  final _formKey = GlobalKey<FormState>();
  final InputFieldValidation fieldValidatorModel = InputFieldValidation();
  bool hasParticipantLimit = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CreateClubViewModel>(context);
    ThemeData theme = Theme.of(context);

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      sliver: SliverToBoxAdapter(child: _buildWidgets(theme)),
    );
  }

  Widget _buildWidgets(ThemeData theme) {
    return Column(children: [_buildForm(theme)]);
  }

  Widget _buildForm(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 30,
      children: [
        _buildClubNameWidget(theme),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildPrivacityWidget(theme),
            _buildParticipantsLimit(theme),
          ],
        ),
        _buildLabelText("Imagem de capa", theme),
        _buildUploadWidget(theme),
        PurpleRoundedButton("Criar", () => {}),
      ],
    );
  }

  Widget _buildUploadWidget(ThemeData theme) {
    final viewModel = Provider.of<CreateClubViewModel>(context);

    return GestureDetector(
      onTap: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
        );

        if (result != null && result.files.isNotEmpty) {
          final fileBytes = result.files.first.bytes;
          if (fileBytes != null) {
            setState(() {
              viewModel.coverImageBytes = fileBytes;
            });
          }
        }
      },
      child: Container(
        height: 250,
        width: 250,
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(blurRadius: 5, color: const Color.fromARGB(255, 0, 0, 0)),
          ],
        ),
        child: FractionallySizedBox(
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
          (value) => viewModel.clubName = value,
        ),
      ],
    );
  }

  Widget _buildPrivacityWidget(ThemeData theme) {
    final viewModel = Provider.of<CreateClubViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabelText("Privacidade", theme),
        ClubPrivacyToggle(
          isToggled: viewModel.isPrivate,
          onChanged: (value) => viewModel.isPrivate = value,
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
              checkColor: Colors.white,
            ),
            if (hasParticipantLimit)
              SizedBox(
                width: 100,
                child: IntFieldRounded(
                  fieldValidatorModel.validateBasicTextField,
                  (value) => viewModel.participantLimit = value as int?,
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
