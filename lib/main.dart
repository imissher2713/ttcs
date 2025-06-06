import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:toeic_app/utils/change_color_by_theme.dart';


import 'home_page.dart';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'utils/get_It.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await initNotification();
  await showRemindNotification();
  await Firebase.initializeApp();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  try{
    Reference audioRef = FirebaseStorage.instance.ref().child('Q10.mp3');
    String audioURL = await audioRef.getDownloadURL();
    print("Success!");
  }
  catch(e){
    print("Dong 36" + e.toString());
  }
  /*List<String> arr = [];
  for (int i = 1; i <= 200; i++) {
    final docRef =
        FirebaseFirestore.instance.collection("Questions").doc(i.toString());
    final doc = await docRef.get();
    if (doc.exists) {
      arr.add(i.toString());
    }
  }
  print(arr);
  FirebaseFirestore.instance
      .collection("Examinations")
      .doc("1")
      .update({'list_question_id': arr});*/
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static const String _title = 'TOEIC APP';

  @override
  State<MyApp> createState() => _MyAppState();
  // ignore: library_private_types_in_public_api
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int start = 0;
  int doc = 32;
  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: MyApp._title,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: HomePage(intialIndex: 0),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('vi')],
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
      changeColorByTheme();
    });
  }

  Future<void> _loadTheme() async {
    final prefs = locator<SharedPreferences>();
    setState(() {
      isDarkMode = (prefs.getBool('DarkMode') ?? false);
      isRemind = (prefs.getBool('isRemind') ?? false);
      if (isDarkMode) {
        _themeMode = ThemeMode.dark;
      }
      changeColorByTheme();
    });
  }
}

tz.TZDateTime _nextInstanceOfRemindTime(int hour, int minute) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute, 0);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(hours: 24));
  }
  print(scheduledDate);
  return scheduledDate;
}

Future<void> showRemindNotification() async {
  if (!isRemind) {
    await flutterLocalNotificationsPlugin.cancel(0);
    return;
  }
  tz.initializeTimeZones();
  try {
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  } catch (err) {
    print("error: $err");
  }

  final prefs = locator<SharedPreferences>();
  String timeRemindString = prefs.getString("TimeRemind") ?? "12:00 AM";
  int hour = int.parse(timeRemindString.split(":")[0]);
  int minute = int.parse(timeRemindString.split(":")[1].substring(0, 2));
  if (timeRemindString.substring(timeRemindString.length - 2) == "PM" &&
      hour != 12) {
    hour += 12;
  }
  if (timeRemindString.substring(timeRemindString.length - 2) == "AM" &&
      hour == 12) {
    hour = 0;
  }

  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Đã đến giờ học rồi',
      'Vào app luyện thôi bạn ơi',
      _nextInstanceOfRemindTime(hour, minute),
      const NotificationDetails(
          android: AndroidNotificationDetails(
        'your channel id',
        'Nhắc nhở học tập',
        'Nhắc nhở thời gian học tập',
        importance: Importance.max,
        priority: Priority.high,
        ongoing: true,
        styleInformation: BigTextStyleInformation(''),
      )),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
}

Future<void> initNotification() async {
  const IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings("@mipmap/ic_launcher");

  const InitializationSettings initializationSettings = InitializationSettings(
    iOS: initializationSettingsIOS,
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
