import 'package:booklub/config/routing/routes.dart';
import 'package:booklub/ui/core/widgets/buttons/purple_rounded_button.dart';
import 'package:booklub/ui/core/widgets/input_fields/image_field_widget.dart';
import 'package:booklub/ui/core/widgets/input_fields/named_date_field_widget.dart';
import 'package:booklub/ui/core/widgets/input_fields/named_text_field_widget.dart';
import 'package:booklub/ui/register/view_models/register_view_model.dart';
import 'package:booklub/ui/register/widgets/logar_clickable_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  late final RegisterViewModel registerViewModel;

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    registerViewModel = context.read<RegisterViewModel>();

    return SliverPadding(
      padding: const EdgeInsets.all(24),
      sliver: SliverFillRemaining(
        hasScrollBody: false,
        child: Column(
          spacing: 24,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Builder(builder: _buildLogo),
            Builder(builder: _buildForm),
            Builder(builder: _buildButtons),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Image.asset(
      'assets/images/booklub_logo_icon.png',
      height: MediaQuery.sizeOf(context).height * 0.20,
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        PurpleRoundedButton("Cadastrar", () => _onSubmit(context)),
        LogarClickableText(),
      ],
    );
  }

  void _onSubmit(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final succeded = await registerViewModel.register();
      if (context.mounted && succeded) context.go(Routes.login);
    }
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 24,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Builder(builder: _buildProfilePictureField),
          Builder(builder: _buildFirstNameField),
          Builder(builder: _buildLastNameField),
          Builder(builder: _buildUsernameField),
          Builder(builder: _buildBirthDateField),
          Builder(builder: _buildEmailField),
          Builder(builder: _buildPasswordField),
        ],
      ),
    );
  }

  Widget _buildProfilePictureField(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return ValueListenableBuilder(
      valueListenable: registerViewModel.profilePicture,
      builder: (context, value, child) {
        final image = (value != null
          ? DecorationImage(
            image: FileImage(value),
            fit: BoxFit.cover
          )
          : null
        );

        return ImageFieldWidget(
          constraints: BoxConstraints(
            maxHeight: 172,
            maxWidth: 172,
          ),
          height: screenWidth * 0.4,
          width: screenWidth * 0.4,
          shape: BoxShape.circle,
          imagePicker: () => registerViewModel.pickProfilePicture(),
          image: image,
        );
      }
    );
  }

  Widget _buildFirstNameField(BuildContext context) {
    return NamedTextFieldWidget(
      label: "Nome",
      inputWrapper: registerViewModel.firstNameInput,
    );
  }

  Widget _buildLastNameField(BuildContext context) {
    return NamedTextFieldWidget(
      label: "Sobrenome",
      inputWrapper: registerViewModel.lastNameInput,
    );
  }

  Widget _buildUsernameField(BuildContext context) {
    return NamedTextFieldWidget(
      label: "Usuário",
      inputWrapper: registerViewModel.usernameInput,
    );
  }

  Widget _buildBirthDateField(BuildContext context) {
    return NamedDateFieldWidget(
      label: 'Nascimento',
      inputWrapper: registerViewModel.birthDateInput,
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return NamedTextFieldWidget(
      label: "E-mail",
      inputWrapper: registerViewModel.emailInput,
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return NamedTextFieldWidget(
      label: "Senha",
      inputWrapper: registerViewModel.passwordInput,
      hidable: true,
    );
  }

}
