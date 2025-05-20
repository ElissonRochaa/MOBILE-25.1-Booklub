abstract class DateFormatter {

  static String formatToDayMonthYear(DateTime date) {
    return (
      '${date.day.toString().padLeft(2, '0')}'
      '/${date.month.toString().padLeft(2, '0')}'
      '/${date.year}'
    );
  }

}