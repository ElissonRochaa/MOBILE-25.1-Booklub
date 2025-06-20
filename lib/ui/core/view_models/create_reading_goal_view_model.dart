import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/domain/entities/users/auth_data.dart';
import 'package:booklub/domain/reading_goals/entities/reading_goal.dart';
import 'package:booklub/domain/reading_goals/entities/reading_goal_creation_dto.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/infra/books/book_api_repository.dart';
import 'package:booklub/infra/reading_goals/reading_goals_repository.dart';
import 'package:booklub/ui/core/view_models/async_change_notifier.dart';
import 'package:booklub/utils/validation/input_validators.dart';
import 'package:booklub/utils/validation/input_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class CreateReadingGoalViewModel extends AsyncChangeNotifier<void> {
  final Logger log = Logger(printer: SimplePrinter());
  final AuthRepository authRepository;
  final ReadingGoalsRepository readingGoalsRepository;
  final BookApiRepository bookApiRepository;
  final InputValidators inputValidators = InputValidators();
  final String clubId;

  late final InputWrapper bookTitleInput;
  late final ValueNotifier<DateTime?> startDateInput;
  late final ValueNotifier<DateTime?> endDateInput;

  bool created = false;
  BookItem? selectedBookItem;

  CreateReadingGoalViewModel({
    required this.authRepository,
    required this.readingGoalsRepository,
    required this.bookApiRepository,
    required this.clubId,
  }) {
    bookTitleInput = InputWrapper(
      controller: TextEditingController(),
      validator: inputValidators.validateBasicTextField,
    );
    bookTitleInput.addListener(notifyListeners);

    startDateInput = ValueNotifier(null);
    startDateInput.addListener(notifyListeners);

    endDateInput = ValueNotifier(null);
    endDateInput.addListener(notifyListeners);
  }

  @override
  void get payload {
    return;
  }

  void setStartDate(DateTime? date) {
    startDateInput.value = date;
  }

  void setEndDate(DateTime? date) {
    endDateInput.value = date;
  }

  bool get isValid {
    return bookTitleInput.isValid &&
        selectedBookItem != null &&
        startDateInput.value != null &&
        endDateInput.value != null &&
        startDateInput.value!.isBefore(endDateInput.value!);
  }

  Future<void> searchBookByTitle() async {
    final title = bookTitleInput.text.trim();
    if (title.isEmpty) return;

    try {
      final paginator = await bookApiRepository.searchBooks(intitle: title);
      final page = await paginator[0];

      if (page.content.isNotEmpty) {
        selectedBookItem = page.content.first;
        bookTitleInput.text = selectedBookItem!.title;
      } else {
        selectedBookItem = null;
      }
    } catch (e, stackTrace) {
      log.e(
        'Erro ao buscar livro por título',
        error: e,
        stackTrace: stackTrace,
      );
      selectedBookItem = null;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> createReadingGoal() async {
    final authData = await authRepository.getAuthData();
    if (authData == null) throw Exception('O usuário não está autenticado');

    super.isLoading = true;
    notifyListeners();

    final bool completed;

    if (isValid) {
      final dto = CreateReadingGoalDto(
        bookId: selectedBookItem!.id ?? (throw Exception('Livro sem ID')),
        startDate: startDateInput.value!.toIso8601String().substring(0, 10),
        endDate: endDateInput.value!.toIso8601String().substring(0, 10),
      );

      await readingGoalsRepository.createReadingGoal(dto, clubId);
      completed = true;
    } else {
      log.d('dados invalidos para criar reading goal');
      completed = false;
    }

    isLoading = false;
    created = true;
    notifyListeners();
    return completed;
  }
}
