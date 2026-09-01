import 'package:flutter/material.dart';

extension ResponsiveExtension on BuildContext {
  // الحصول على أبعاد الشاشة الحالية للمستخدم
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  //⚠ هام: غيّر هذه الأرقام لتطابق حجم شاشة التصميم الأصلي في Figma
  // (الأكثر شيوعاً هو 375 للعرض و 812 للارتفاع)
  static const double designWidth = 430.0;
  static const double designHeight = 932.0;

  /// دالة لحساب العرض (تأخذ القيمة الأصلية وتحسب النسبة تلقائياً)
  /// مثال: context.w(20)
  double w(double value) => (value / designWidth) * screenWidth;

  /// دالة لحساب الارتفاع
  /// مثال: context.h(97)
  double h(double value) => (value / designHeight) * screenHeight;

  /// دالة لحساب الـ BorderRadius أو أحجام الخطوط (غالباً نربطها بالعرض)
  /// مثال: context.r(16)
  double r(double value) => (value / designWidth) * screenWidth;

  // ✨ الدالة الجديدة المخصصة لحجم الخط (Text)
  double sp(double value) {
    // 1. حساب الحجم بناءً على عرض الشاشة (مثل الـ ScreenUtil)
    double scaledSize = (value / designWidth) * screenWidth;

    // 2. احترام إعدادات تكبير الخط في هاتف المستخدم (Accessibility)
    // ملاحظة: textScalerOf متوفرة في Flutter 3.16 فأحدث (وهو المعيار الحالي)
    return MediaQuery.textScalerOf(this).scale(scaledSize);
  }
}