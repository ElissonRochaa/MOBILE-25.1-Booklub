import 'package:booklub/config/routing/routes.dart';
import 'package:booklub/ui/core/widgets/buttons/purple_rounded_button.dart';
import 'package:booklub/ui/core/widgets/input_fields/named_text_field_widget.dart';
import 'package:booklub/ui/login/view_models/login_view_model.dart';
import 'package:booklub/ui/login/widgets/cadastrar_clickable_text.dart';
import 'package:booklub/ui/login/widgets/esqueceu_senha_clickable_text.dart';
import 'package:booklub/ui/recover-password/view_models/recover_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RecoverPasswordPage extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  late final RecoverPasswordViewModel recoverPasswordViewModel;

  RecoverPasswordPage({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    recoverPasswordViewModel = context.read<RecoverPasswordViewModel>();

    return SliverPadding(
      padding: const EdgeInsets.all(24),
      sliver: SliverFillRemaining(
        hasScrollBody: false,
        child: Column(
          spacing: 24,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SafeArea(child: _buildBackButton(context)),
            Builder(builder: _buildTextMessage),
            Builder(builder: _buildForm),
            Builder(builder: _buildButtons),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Theme.of(context).colorScheme.primary,
        onPressed: () => context.pop(),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        PurpleRoundedButton("Enviar e-mail", () => _onSubmit(context)),
      ],
    );
  }

  void _onSubmit(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final succeded = await recoverPasswordViewModel.sendResetPasswordEmail();
      if (context.mounted && succeded) context.go(Routes.checkYourEmailRecover);
    }
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 24,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Builder(builder: _buildEmailField),
        ],
      ),
    );
  }

    Widget _buildTextMessage(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Recuperação de Conta",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Digite o e-mail referente à sua conta e iremos te enviar um e-mail com instruções pra recuperar sua senha.",
          textAlign: TextAlign.left,
          style: TextStyle(color: theme.colorScheme.primary, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return NamedTextFieldWidget(
      label: "E-mail",
      inputWrapper: recoverPasswordViewModel.usernameInput,
    );
  }

}
