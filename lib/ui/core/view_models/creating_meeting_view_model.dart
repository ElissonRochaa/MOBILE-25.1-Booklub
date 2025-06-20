import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/domain/meetings/entities/meeting_creation_dto.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/infra/books/book_api_repository.dart';
import 'package:booklub/infra/meetings/meetings_repository.dart';
import 'package:booklub/ui/core/view_models/async_change_notifier.dart';
import 'package:booklub/utils/geo/types/latlng.dart';
import 'package:booklub/utils/validation/input_validators.dart';
import 'package:booklub/utils/validation/input_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CreateMeetingViewModel extends AsyncChangeNotifier<void> {
  final Logger log = Logger(printer: SimplePrinter());

  final AuthRepository authRepository;
  final MeetingsRepository meetingsRepository;
  final BookApiRepository bookApiRepository;

  final InputValidators inputValidators = InputValidators();

  late final InputWrapper addressInput;
  late final InputWrapper bookTitleInput;
  late final ValueNotifier<DateTime?> dateInput;
  late final ValueNotifier<LatLng?> latlngInput;
  late final ValueNotifier<TimeOfDay?> timeInput;

  String? readingGoalId;
  BookItem? selectedBookItem;
  bool created = false;

  @override
  void get payload {
    return;
  }

  CreateMeetingViewModel({
    required this.authRepository,
    required this.meetingsRepository,
    required this.bookApiRepository,
  }) {
    addressInput = InputWrapper(
      controller: TextEditingController(),
      validator: inputValidators.validateBasicTextField,
    );
    addressInput.addListener(notifyListeners);

    bookTitleInput = InputWrapper(
      controller: TextEditingController(),
      validator: inputValidators.validateBasicTextField,
    );
    bookTitleInput.addListener(notifyListeners);

    dateInput = ValueNotifier(null);
    dateInput.addListener(notifyListeners);

    latlngInput = ValueNotifier(null);
    latlngInput.addListener(notifyListeners);

    timeInput = ValueNotifier(null);
    timeInput.addListener(notifyListeners);
  }

  void updateLatLng(LatLng? latlng) {
    latlngInput.value = latlng;
  }

  void setDate(DateTime? selectedDate) {
    dateInput.value = selectedDate;
  }

  void setTime(TimeOfDay? selectedTime) {
    timeInput.value = selectedTime;
  }

  bool get isValid {
    return addressInput.isValid &&
        bookTitleInput.isValid &&
        selectedBookItem != null &&
        readingGoalId != null &&
        dateInput.value != null &&
        latlngInput.value != null &&
        timeInput.value != null;
  }

  DateTime get scheduledDateTime {
    final d = dateInput.value!;
    final t = timeInput.value!;
    return DateTime(d.year, d.month, d.day, t.hour, t.minute);
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

  Future<bool> createMeeting(String readingGoalId) async {
    final authData = await authRepository.getAuthData();
    if (authData == null) throw Exception('User não autenticado');

    super.isLoading = true;
    notifyListeners();

    bool completed;

    if (isValid) {
      try {
        final meetingCreationDto = MeetingCreationDto(
          address: addressInput.text.trim(),
          date: scheduledDateTime,
          bookId: selectedBookItem!.id ?? (throw Exception('Livro sem ID')),
          latlng: latlngInput.value!,
        );

        final meeting = await meetingsRepository.createMeeting(
          meetingCreationDto,
          readingGoalId,
        );

        log.i('Meeting created successfully with ID: ${meeting.id}');
        created = true;
        completed = true;
      } catch (e, stackTrace) {
        log.e('Erro ao criar meeting', error: e, stackTrace: stackTrace);
        created = false;
        completed = false;
      } finally {
        super.isLoading = false;
        notifyListeners();
      }
    } else {
      log.w('Dados inválidos para criar meeting');
      completed = false;
      super.isLoading = false;
      notifyListeners();
    }
    return completed;
  }
}
