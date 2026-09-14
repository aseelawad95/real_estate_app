import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/features/appoinment/presentation/widgets/appointment_calendar_grid.dart';
import 'package:real_estate/features/appoinment/presentation/widgets/appointment_week_day_header.dart';

class AppointmentDateSelectionSection extends StatelessWidget {
  const AppointmentDateSelectionSection({
    super.key,
    required this.visibleMonth,
    required this.selectedDate,
    required this.onDateSelected,
  });

  final DateTime visibleMonth;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  static const List<String> _weekdayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Select Date',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
              ),
              CustomText(
                text: _monthYearLabel(visibleMonth),
                fontSize: 13,
                color: AppColors.grayColor,
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppointmentWeekdayHeaderRow(labels: _weekdayLabels),
          const SizedBox(height: 8),
          AppointmentCalendarGrid(
            visibleMonth: visibleMonth,
            selectedDate: selectedDate,
            onDateSelected: onDateSelected,
          ),
        ],
      ),
    );
  }

  String _monthYearLabel(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
