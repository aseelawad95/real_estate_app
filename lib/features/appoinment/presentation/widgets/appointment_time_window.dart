import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/features/appoinment/presentation/widgets/appointment_time_slot.dart';

enum TimeSlot { morning, afternoon, evening }

extension TimeSlotData on TimeSlot {
  String get label {
    switch (this) {
      case TimeSlot.morning:
        return 'Morning';
      case TimeSlot.afternoon:
        return 'Afternoon';
      case TimeSlot.evening:
        return 'Evening';
    }
  }

  String get range {
    switch (this) {
      case TimeSlot.morning:
        return '09:00 AM - 12:00 PM';
      case TimeSlot.afternoon:
        return '12:00 PM - 04:00 PM';
      case TimeSlot.evening:
        return '04:00 PM - 07:00 PM';
    }
  }

  IconData get icon {
    switch (this) {
      case TimeSlot.morning:
        return Icons.wb_sunny_outlined;
      case TimeSlot.afternoon:
        return Icons.wb_sunny;
      case TimeSlot.evening:
        return Icons.nightlight_round;
    }
  }
}

class AppointmentTimeWindowSection extends StatelessWidget {
  const AppointmentTimeWindowSection({
    super.key,
    required this.selectedSlot,
    required this.onSlotSelected,
  });

  final TimeSlot? selectedSlot;
  final ValueChanged<TimeSlot> onSlotSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Time Window',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryText,
        ),
        const SizedBox(height: 12),
        ...TimeSlot.values.map(
          (slot) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: AppointmentTimeSlotTile(
              slot: slot,
              isSelected: slot == selectedSlot,
              onTap: () => onSlotSelected(slot),
            ),
          ),
        ),
      ],
    );
  }
}