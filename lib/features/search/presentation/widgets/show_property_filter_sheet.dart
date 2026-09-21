import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/features/location/presentation/bloc/getlocation/getlocation_cubit.dart';
import 'package:real_estate/features/property/presentation/bloc/getproperty/getproperty_cubit.dart';
import 'package:real_estate/features/search/domain/entities/property_filter.dart';
import 'package:real_estate/service_locator.dart';

Future<void> showPropertyFilterSheet(BuildContext context) {
  final propertyCubit = context.read<GetpropertyCubit>();

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: propertyCubit),
        BlocProvider(create: (_) => sl<GetlocationCubit>()..getAllLocations()),
      ],
      child: const _PropertyFilterSheetBody(),
    ),
  );
}

class _PropertyFilterSheetBody extends StatefulWidget {
  const _PropertyFilterSheetBody();

  @override
  State<_PropertyFilterSheetBody> createState() =>
      _PropertyFilterSheetBodyState();
}

class _PropertyFilterSheetBodyState extends State<_PropertyFilterSheetBody> {
  late PropertyFilterParams _draft;

  String? _selectedCountry;
  String? _selectedCity;
  double _minPrice = 0;
  RangeValues _rateRange = const RangeValues(0, 5);
  DateTime? _createdFrom;
  DateTime? _createdTo;

  @override
  void initState() {
    super.initState();
    _draft = context.read<GetpropertyCubit>().currentFilter;
    _selectedCountry = _draft.country;
    _selectedCity = _draft.city;
    _minPrice = _draft.minPrice ?? 0;
    _rateRange = RangeValues(_draft.minRate ?? 0, _draft.maxRate ?? 5);
    _createdFrom = _draft.createdFrom;
    _createdTo = _draft.createdTo;
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: AppColors.textColor),
      filled: true,
      fillColor: AppColors.textFieldColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
    );
  }

  ButtonStyle get _dateButtonStyle => OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        side: BorderSide(color: AppColors.borderColor),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      );

  Future<void> _pickDate({required bool isFrom}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.primaryColor,
            onPrimary: Colors.white,
            onSurface: AppColors.textColor,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.secondaryText,
            ),
          ),
        ),
        child: child!,
      ),
    );
    if (picked == null) return;
    setState(() {
      if (isFrom) {
        _createdFrom = picked;
      } else {
        _createdTo = picked;
      }
    });
  }

  void _apply() {
    final filter = _draft.copyWith(
      country: _selectedCountry,
      city: _selectedCity,
      clearCountry: _selectedCountry == null,
      clearCity: _selectedCity == null,
      minPrice: _minPrice > 0 ? _minPrice : null,
      minRate: _rateRange.start > 0 ? _rateRange.start : null,
      maxRate: _rateRange.end < 5 ? _rateRange.end : null,
      createdFrom: _createdFrom,
      createdTo: _createdTo,
    );

    context.read<GetpropertyCubit>().applyFilters(filter);
    Navigator.pop(context);
  }

  void _reset() {
    context.read<GetpropertyCubit>().resetFilters();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Properties',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                TextButton(
                  onPressed: _reset,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.secondaryText,
                  ),
                  child: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            BlocBuilder<GetlocationCubit, GetlocationState>(
              builder: (context, state) {
                if (state is GetlocationLoaded) {
                  final countries = state.locations
                      .map((l) => l.country)
                      .toSet()
                      .toList();
                  final cities = state.locations
                      .where((l) =>
                          _selectedCountry == null ||
                          l.country == _selectedCountry)
                      .map((l) => l.city)
                      .toSet()
                      .toList();

                  return Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: _selectedCountry,
                        dropdownColor: AppColors.thirdColor,
                        decoration: _inputDecoration('Country'),
                        items: countries
                            .map((c) => DropdownMenuItem(
                                  value: c,
                                  child: Text(
                                    c,
                                    style:
                                        TextStyle(color: AppColors.textColor),
                                  ),
                                ))
                            .toList(),
                        onChanged: (v) => setState(() {
                          _selectedCountry = v;
                          _selectedCity = null; // reset city when country changes
                        }),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedCity,
                        dropdownColor: AppColors.thirdColor,
                        decoration: _inputDecoration('City'),
                        items: cities
                            .map((c) => DropdownMenuItem(
                                  value: c,
                                  child: Text(
                                    c,
                                    style:
                                        TextStyle(color: AppColors.textColor),
                                  ),
                                ))
                            .toList(),
                        onChanged: (v) => setState(() => _selectedCity = v),
                      ),
                    ],
                  );
                }
                return SizedBox(
                  height: 40,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.primaryColor,
                inactiveTrackColor: AppColors.grayColor,
                thumbColor: AppColors.fourthColor,
                valueIndicatorColor: AppColors.primaryColor,
                valueIndicatorTextStyle: const TextStyle(color: Colors.white),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Minimum price: ${_minPrice.toStringAsFixed(0)}',
                    style: TextStyle(color: AppColors.textColor),
                  ),
                  Slider(
                    value: _minPrice,
                    min: 0,
                    max: 1000000,
                    divisions: 50,
                    label: _minPrice.toStringAsFixed(0),
                    onChanged: (v) => setState(() => _minPrice = v),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rating: ${_rateRange.start.toStringAsFixed(1)} - ${_rateRange.end.toStringAsFixed(1)}',
                    style: TextStyle(color: AppColors.textColor),
                  ),
                  RangeSlider(
                    values: _rateRange,
                    min: 0,
                    max: 5,
                    divisions: 10,
                    labels: RangeLabels(
                      _rateRange.start.toStringAsFixed(1),
                      _rateRange.end.toStringAsFixed(1),
                    ),
                    onChanged: (v) => setState(() => _rateRange = v),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: _dateButtonStyle,
                    onPressed: () => _pickDate(isFrom: true),
                    child: Text(_createdFrom == null
                        ? 'From date'
                        : '${_createdFrom!.year}-${_createdFrom!.month}-${_createdFrom!.day}'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    style: _dateButtonStyle,
                    onPressed: () => _pickDate(isFrom: false),
                    child: Text(_createdTo == null
                        ? 'To date'
                        : '${_createdTo!.year}-${_createdTo!.month}-${_createdTo!.day}'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _apply,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Apply Filters'),
            ),
          ],
        ),
      ),
    );
  }
}