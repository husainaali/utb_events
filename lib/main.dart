import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constant/colors.dart';
import 'constant/routes.dart';
import 'constant/string.dart';
import 'models/user.dart';
import 'pages_view/calendar/calendar_view.dart';
import 'pages_view/categories/categories_view.dart';
import 'pages_view/categories/category_list_view.dart';
import 'pages_view/create_event/create_event_view.dart';
import 'pages_view/event/event_view.dart';
import 'pages_view/home/home_view.dart';
import 'pages_view/login_register/login_register_view.dart';
import 'pages_view/main_navigation.dart';
import 'pages_view/profile/profile_view.dart';
import 'utils/size_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  await EasyLocalization.ensureInitialized();
  final String userData = sharedPreferences.getString(AppString.user) ?? '';
  User? currentUser;

  if (userData.isNotEmpty) {
    try {
      currentUser = User.fromJson(jsonDecode(userData));
    } catch (e) {
      print('Error parsing user data: $e');
    }
  } else {
    currentUser = User(
        id: 2, name: 'Guest', email: 'guest@example.com', notification: false);
  }

  runApp(ProviderScope(
    child: EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations',
      child: const MyApp(),
    ),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      // navigatorKey: navigationService.navigatorKey,
      initialRoute: AppRoutes.mainNavigation,
      routes: {
        AppRoutes.mainNavigation: (context) => const MainNavigationView(),
        AppRoutes.loginRegisterView: (context) => const LoginRegisterView(),
        AppRoutes.homeView: (context) => const HomeView(),
        AppRoutes.profileView: (context) => const ProfileView(),
        AppRoutes.categoriesView: (context) => const CategoriesView(),
        AppRoutes.calendarView: (context) => const CalendarView(),
        AppRoutes.eventView: (context) => const EventView(),
        AppRoutes.categoryListView: (context) => const CategoryListView(),
        AppRoutes.createEventView: (context) => const CreateEventView(),
      },
    );
  }
}
