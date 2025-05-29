import 'package:booklub/ui/core/widgets/buttons/purple_rounded_button.dart';
import 'package:booklub/ui/login/widgets/cadastrar_clickable_text.dart';
import 'package:booklub/ui/login/widgets/esqueceu_senha_clickable_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckYourEmailRecoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(24),
      sliver: SliverFillRemaining(
        hasScrollBody: false,
        child: Column(
          spacing: 24,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Builder(builder: _buildTextMessage),
            Builder(builder: _buildButtons),
          ],
        ),
      ),
    );
  }
  }

  Widget _buildTextMessage(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(Icons.mark_email_unread_rounded, size: 80, color: theme.colorScheme.primary),
        const SizedBox(height: 20),
        Text(
          "Cheque seu e-mail",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Te enviamos um e-mail que contém um link pra resetar sua senha! Verifique sua caixa de spam.",
          textAlign: TextAlign.left,
          style: TextStyle(color: theme.colorScheme.primary, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        PurpleRoundedButton("Voltar pro login", () => context.push("/login")),
      ],
    );
}

