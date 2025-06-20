import 'package:booklub/ui/core/view_models/create_reading_goal_view_model.dart';
import 'package:booklub/ui/core/widgets/buttons/purple_rounded_button.dart';
import 'package:booklub/ui/core/widgets/input_fields/named_date_field_widget.dart';
import 'package:booklub/ui/core/widgets/input_fields/named_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateReadingGoalPage extends StatelessWidget {
  final String clubId;
  final _formKey = GlobalKey<FormState>();

  CreateReadingGoalPage({super.key, required this.clubId});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CreateReadingGoalViewModel>();

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
            Builder(builder: (_) => _buildForm(context, viewModel)),
            Builder(builder: (_) => _buildButton(context, viewModel)),
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

  Widget _buildForm(BuildContext context, CreateReadingGoalViewModel vm) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 24,
        children: [
          NamedTextFieldWidget(
            label: "Nome do livro",
            inputWrapper: vm.bookTitleInput,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () => vm.searchBookByTitle(),
            ),
          ),
          NamedDateFieldWidget(
            label: "Data Início",
            inputWrapper: vm.startDateTextInput,
          ),
          NamedDateFieldWidget(
            label: "Data Final",
            inputWrapper: vm.endDateTextInput,
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, CreateReadingGoalViewModel vm) {
    return PurpleRoundedButton("Criar", () async {
      if (_formKey.currentState?.validate() ?? false) {
        print('📋 DEBUG CREATE READING GOAL');
        print('Título válido: ${vm.bookTitleInput.isValid}');
        print('Livro selecionado: ${vm.selectedBookItem?.title}');
        print('Data início: ${vm.startDateInput.value}');
        print('Data fim: ${vm.endDateInput.value}');
        print(
          'Início < Fim? ${vm.startDateInput.value != null && vm.endDateInput.value != null ? vm.startDateInput.value!.isBefore(vm.endDateInput.value!) : 'n/a'}',
        );
        final success = await vm.createReadingGoal();
        if (context.mounted && success) Navigator.of(context).pop();
      }
    });
  }
}

// import 'package:booklub/ui/core/layouts/scroll_base_layout.dart';
// import 'package:booklub/ui/core/view_models/create_reading_goal_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CreateReadingGoalPage extends StatelessWidget {
//   final String clubId;

//   const CreateReadingGoalPage({super.key, required this.clubId});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => CreateReadingGoalViewModel(
//         authRepository: context.read(),
//         readingGoalsRepository: context.read(),
//         bookApiRepository: context.read(),
//         clubId: clubId,
//       ),
//       child: ScrollBaseLayout(
//         label: 'Criar leitura',
//         bottomBarVisible: false,
//         sliver: Center(child: Text('TODO: UI da criação de meta')),
//       ),
//     );
//   }
// }
