import 'package:flutter/material.dart';
import 'package:real_estate/features/appoinment/presentation/widgets/appointment_calendar_day_cell.dart';

class AppointmentCalendarGrid extends StatelessWidget {
  const AppointmentCalendarGrid({
    super.key,
    required this.visibleMonth,
    required this.selectedDate,
    required this.onDateSelected,
  });

  final DateTime visibleMonth;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    final daysInMonth =
        DateTime(visibleMonth.year, visibleMonth.month + 1, 0).day;
    final firstDayOfMonth = DateTime(visibleMonth.year, visibleMonth.month, 1);
    final leadingEmptyCells = firstDayOfMonth.weekday - 1;
    final totalCells = leadingEmptyCells + daysInMonth;
    final rowCount = (totalCells / 7).ceil();

    // نجيب "اليوم" بدون وقت (ساعة/دقيقة) عشان المقارنة تكون صح
    final today = DateTime.now();
    final todayDateOnly = DateTime(today.year, today.month, today.day);

    return Column(
      children: List.generate(rowCount, (rowIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (colIndex) {
              final cellIndex = rowIndex * 7 + colIndex;
              final dayNumber = cellIndex - leadingEmptyCells + 1;

              if (dayNumber < 1 || dayNumber > daysInMonth) {
                return const SizedBox(width: 32, height: 32);
              }

              final date =
                  DateTime(visibleMonth.year, visibleMonth.month, dayNumber);
              final isSelected = _isSameDate(date, selectedDate);
              final isPast = date.isBefore(todayDateOnly);

              return AppointmentCalendarDayCell(
                day: dayNumber,
                isSelected: isSelected,
                isDisabled: isPast,
                onTap: isPast ? null : () => onDateSelected(date),
              );
            }),
          ),
        );
      }),
    );
  }

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}