import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogarClickableText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle defaultStyle = TextStyle(
      color: theme.colorScheme.onSurface,
      fontSize: theme.textTheme.bodyLarge?.fontSize ?? 16,
    );
    TextStyle linkStyle = TextStyle(color: theme.colorScheme.secondary);
    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(text: 'ou '),
          TextSpan(
            text: 'fazer login',
            style: linkStyle,
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    context.go('/login'); //Aqui eu vou fazer quando adicionar a página de registrar
                  },
          ),
        ],
      ),
    );
  }
}
