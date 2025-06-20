import 'package:booklub/ui/core/view_models/creating_meeting_view_model.dart';
import 'package:booklub/ui/core/widgets/buttons/purple_rounded_button.dart';
import 'package:booklub/ui/core/widgets/input_fields/named_date_field_widget.dart';
import 'package:booklub/ui/core/widgets/input_fields/named_text_field_widget.dart';
import 'package:booklub/ui/core/widgets/input_fields/named_time_field_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateMeetingPage extends StatelessWidget {
  final String clubId;
  final _formKey = GlobalKey<FormState>();

  CreateMeetingPage({super.key, required this.clubId});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CreateMeetingViewModel>();

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

  Widget _buildForm(BuildContext context, CreateMeetingViewModel vm) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 24,
        children: [
          NamedTextFieldWidget(
            label: "Nome do lugar",
            inputWrapper: vm.addressInput,
            suffixIcon: Icon(Icons.search),
          ),
          NamedDateFieldWidget(label: "Data", inputWrapper: vm.dateTextInput),
          NamedTimeFieldWidget(
            label: "Horário",
            inputWrapper: vm.timeTextInput,
          ),
          NamedTextFieldWidget(
            label: "Leitura",
            inputWrapper: vm.bookTitleInput,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () => vm.searchBookByTitle(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, CreateMeetingViewModel vm) {
    return PurpleRoundedButton("Criar", () async {
      if (_formKey.currentState?.validate() ?? false) {
        print('📋 Criando meeting com dados:');
        print('Endereço válido: ${vm.addressInput.isValid}');
        print('Livro selecionado: ${vm.selectedBookItem?.title}');
        print('ReadingGoalId: ${vm.readingGoalId}');
        print('Data: ${vm.dateInput.value}');
        print('Hora: ${vm.timeInput.value}');
        print('Localização: ${vm.latlngInput.value}');

        final success = await vm.createMeeting(clubId);
        if (context.mounted && success) Navigator.of(context).pop();
      }
    });
  }
}

// import 'package:booklub/ui/core/layouts/scroll_base_layout.dart';
// import 'package:booklub/ui/core/view_models/creating_meeting_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CreateMeetingPage extends StatelessWidget {
//   final String clubId;

//   const CreateMeetingPage({super.key, required this.clubId});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => CreateMeetingViewModel(
//         authRepository: context.read(),
//         meetingsRepository: context.read(),
//         bookApiRepository: context.read(),
//       ),
//       child: ScrollBaseLayout(
//         label: 'Criar encontro',
//         bottomBarVisible: false,
//         sliver: Center(child: Text('TODO: UI da criação de encontro')),
//       ),
//     );
//   }
// }
