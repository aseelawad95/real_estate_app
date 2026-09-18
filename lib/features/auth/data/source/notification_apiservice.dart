import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:real_estate/core/helper_function/TokenHelper.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// نادي هاي الميثود مرة وحدة بس عند إقلاع التطبيق (main.dart)
  static Future<void> initialize() async {
    // 1) اطلب صلاحية الإشعارات من المستخدم
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // 2) جهّز الـ Local Notifications (لعرض البانر لما التطبيق مفتوح - Foreground)
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await _localNotifications.initialize(initSettings);

    // 3) استقبال إشعار والتطبيق مفتوح قدام المستخدم (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });

    // 4) المستخدم دوس على الإشعار والتطبيق كان بالخلفية (مو مقفول تماماً)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationTap(message);
    });

    // 5) لو التطبيق كان مقفول تماماً وانفتح بسبب الضغط على إشعار
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  static void _showLocalNotification(RemoteMessage message) {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Notifications',
      channelDescription: 'إشعارات عامة بالتطبيق',
      importance: Importance.high,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'إشعار جديد',
      message.notification?.body ?? '',
      notificationDetails,
    );
  }

  static void _handleNotificationTap(RemoteMessage message) {
    // هون تحط الـ Navigation المناسب حسب نوع الإشعار (data payload)
    print('تم الضغط على الإشعار: ${message.data}');
    // مثال: Navigator.pushNamed(context, '/appointments');
  }

  /// نادي هاي الميثود مباشرة بعد نجاح تسجيل الدخول
  static Future<void> registerDeviceToken(String fullUrl) async {
  try {
    final fcmToken = await _messaging.getToken();
    if (fcmToken == null) {
      print('لم يتم الحصول على FCM Token');
      return;
    }

    final jwt = await TokenHelper.getToken();
    if (jwt == null) {
      print('لا يوجد JWT، تسجيل التوكن تم إلغاؤه');
      return;
    }

    final response = await http.post(
      Uri.parse(fullUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
      body: jsonEncode({'Token': fcmToken}),
    );

    if (response.statusCode == 200) {
      print('تم تسجيل FCM Token بنجاح');
    } else {
      print('فشل تسجيل FCM Token: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    print('استثناء أثناء تسجيل FCM Token: $e');
  }
}
}







 