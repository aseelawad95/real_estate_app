import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/button/button_cubit.dart';
import 'package:real_estate/common/widgets/basic_app_button.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/core/helper_function/TokenHelper.dart';
import 'package:real_estate/features/appoinment/domain/entities/create_appointment.dart';
import 'package:real_estate/features/appoinment/domain/usecase/create_appointment_usecase.dart';
import 'package:real_estate/features/appoinment/presentation/widgets/apointment_app_bar.dart';
import 'package:real_estate/features/appoinment/presentation/widgets/appointment_date_section.dart';
import 'package:real_estate/features/appoinment/presentation/widgets/appointment_info_section.dart';
import 'package:real_estate/features/appoinment/presentation/widgets/appointment_property_image_header.dart';
import 'package:real_estate/features/appoinment/presentation/widgets/appointment_requirments_section.dart';
import 'package:real_estate/features/appoinment/presentation/widgets/appointment_time_window.dart';
import 'package:real_estate/service_locator.dart';

class CreateAppointmentPage extends StatefulWidget {
  const CreateAppointmentPage({super.key, required this.propertyId});
  final int propertyId;

  @override
  State<CreateAppointmentPage> createState() => _CreateAppointmentPageState();
}

class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
  late DateTime _selectedDate = DateTime.now();
  late DateTime visibleMonth = DateTime(DateTime.now().year, DateTime.now().month);
  TimeSlot? _selectedTimeSlot;
  final TextEditingController _requirementsController = TextEditingController();

  String? _customerId;

  @override
  void initState() {
    super.initState();
    _loadCustomerId();
  }

  Future<void> _loadCustomerId() async {
    final id = await TokenHelper.getUserId();
    setState(() => _customerId = id);
  }

  @override
  void dispose() {
    _requirementsController.dispose();
    super.dispose();
  }

  void _onDateSelected(DateTime date) {
    setState(() => _selectedDate = date);
  }

  void _onTimeSlotSelected(TimeSlot slot) {
    setState(() => _selectedTimeSlot = slot);
  }

  /// بيرجع أول وقت (hour, minute) من نطاق الـ TimeSlot المختار
  /// (مثلاً Morning -> 09:00 AM)
  ({int hour, int minute}) _startTimeOf(TimeSlot slot) {
    switch (slot) {
      case TimeSlot.morning:
        return (hour: 9, minute: 0);
      case TimeSlot.afternoon:
        return (hour: 12, minute: 0);
      case TimeSlot.evening:
        return (hour: 16, minute: 0);
    }
  }

  Future<void> _onConfirmAppointment(BuildContext context) async {
    if (_selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.dangerColor,
          content: const Text('من فضلك اختر وقت المعاينة'),
        ),
      );
      return;
    }

    if (_customerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.dangerColor,
          content: const Text('حدث خطأ، حاول تسجيل الدخول من جديد'),
        ),
      );
      return;
    }

    final startTime = _startTimeOf(_selectedTimeSlot!);
    final scheduledAt = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      startTime.hour,
      startTime.minute,
    );

    context.read<ButtonCubit>().excute(
          usecase: sl<CreateAppointmentUseCase>(),
          params: CreateAppointment(
            scheduledAt: scheduledAt,
            propertyId: widget.propertyId,
            customerId: _customerId!,
            status: 1, 
            notes: _requirementsController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ButtonCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppointmentAppBar(),
        body: SafeArea(
          top: false,
          child: BlocListener<ButtonCubit, ButtonState>(
            listener: (context, state) {
              if (state is ButtonSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حجز الموعد بنجاح')),
                );
                Navigator.of(context).pop();
              }
              if (state is ButtonFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const AppointmentPropertyImageHeader(
                    imageUrl: 'https://example.com/obsidian-pavilion.jpg',
                  ),
                  const SizedBox(height: 16),
                  const AppointmentPropertyInfoSection(
                    title: 'The Obsidian Pavilion',
                    location: '9 Bel Air, Los Angeles',
                    price: '\$12,500,000',
                  ),
                  const SizedBox(height: 24),
                  AppointmentDateSelectionSection(
                    visibleMonth: visibleMonth,
                    selectedDate: _selectedDate,
                    onDateSelected: _onDateSelected,
                  ),
                  const SizedBox(height: 24),
                  AppointmentTimeWindowSection(
                    selectedSlot: _selectedTimeSlot,
                    onSlotSelected: _onTimeSlotSelected,
                  ),
                  const SizedBox(height: 24),
                  AppointmentRequirementsSection(
                    controller: _requirementsController,
                  ),
                  const SizedBox(height: 24),
                  Builder(
                    builder: (context) => BasicAppButton(
                      title: 'Confirm Appointment',
                      onPressed: () => _onConfirmAppointment(context),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}