import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/main_provider.dart';
import '../widgets/navigation_bar.dart';
import 'calendar/calendar_view.dart';
import 'categories/categories_view.dart';
import 'create_event/create_event_view.dart';
import 'home/home_view.dart';
import 'login_register/login_register_view.dart';
import 'profile/profile_view.dart';

class MainNavigationView extends ConsumerStatefulWidget {
  const MainNavigationView({super.key});

  @override
  ConsumerState<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends ConsumerState<MainNavigationView> {
  @override
  Widget build(BuildContext context) {
    final status = ref.read(navigationProvider.notifier).isLoggedIn;
    log(status.toString());
    return Scaffold(
      body: status == 0
          ? const LoginRegisterView()
          : Stack(
              children: [
                IndexedStack(
                  index: ref.watch(navigationProvider),
                  children: const [
                    HomeView(),
                    CategoriesView(),
                    CalendarView(),
                    ProfileView(),
                    CreateEventView(),
                  ],
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomNavigationBar(),
                ),
              ],
            ),
    );
  }
}
