import 'package:flutter/material.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class CustomDropDownTextField extends StatefulWidget {
  const CustomDropDownTextField({
    super.key,
    this.height,
    this.width,
    this.hintText,
    this.label,
    this.icon,
    required this.items,
    required this.onChanged,
    this.value,
  });

  final String? hintText;
  final String? label;
  final IconData? icon;
  final double? height;
  final double? width;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  State<CustomDropDownTextField> createState() =>
      _CustomDropDownTextFieldState();
}

class _CustomDropDownTextFieldState extends State<CustomDropDownTextField> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    if (widget.value != null &&
        widget.items.contains(widget.value)) {
      _selectedValue = widget.value;
    } else {
      _selectedValue = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 60,
      width: widget.width ?? double.infinity,
      child: DropdownButtonFormField<String>(
        value: _selectedValue, 
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
        validator: (v) {
          if (v == null || v.isEmpty) {
            return "Please Select ${widget.hintText}";
          }
          return null;
        },
        onChanged: (value) {
          setState(() {
            _selectedValue = value;
          });
          widget.onChanged(value);
        },
        items: widget.items
            .toSet() 
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: const TextStyle(color: Colors.black)),
              ),
            )
            .toList(),
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.grayColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.grayColor),
          ),
          hintText: widget.hintText,
          labelText: widget.label,
          hintStyle: const TextStyle(color: Colors.black),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
