import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class CustomToggleTabs extends StatefulWidget {
  const CustomToggleTabs({
    super.key,
    required this.firstText,
    required this.secondText,
    this.onChanged,
    this.selectedColor,
    this.unselectedColor, required this.initialIndex,
  });

  final String firstText;
  final String secondText;
  final ValueChanged<int>? onChanged;
  final Color? selectedColor;
  final Color? unselectedColor;
  final int initialIndex;

   
  
  @override
  State<CustomToggleTabs> createState() => _CustomToggleTabsState();
}

class _CustomToggleTabsState extends State<CustomToggleTabs> {
  int _selectedTab = 0;
 @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialIndex;
  }

   void _select(int index) {
    if (index == _selectedTab) return;
    setState(() {
      _selectedTab = index;
    });
    widget.onChanged?.call(index);
  }

  Widget _buildTab({required String text, required int index}) {
    final bool isSelected = _selectedTab == index;
    final Color selectedColor = widget.selectedColor ?? Colors.amber;
    final Color unselectedColor = widget.unselectedColor ?? AppColors.textColor;

    return GestureDetector(
      onTap: () => _select(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: text,
            color: isSelected ? AppColors.textAmber : unselectedColor,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
          ),
          const SizedBox(height: 4),
          Container(
            height: 1,
            width: 150,
            color: isSelected ? selectedColor : Colors.transparent,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTab(text: widget.firstText, index: 0),
        _buildTab(text: widget.secondText, index: 1),
      ],
    );
  }
}