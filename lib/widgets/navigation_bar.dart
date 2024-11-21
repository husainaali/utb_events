import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utb_events/utils/size_extensions.dart';

import '../constant/routes.dart';
import '../provider/main_provider.dart';

class CustomNavigationBar extends ConsumerWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);

    return Container(
      height: 90.h,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, 0, Icons.home, selectedIndex, ref),
          _buildNavItem(context, 1, Icons.list, selectedIndex, ref),
          _buildNavItem(context, 2, Icons.calendar_today, selectedIndex, ref),
          _buildNavItem(context, 3, Icons.person, selectedIndex, ref),
          _buildNavItem(context, 4, Icons.add, selectedIndex, ref),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon,
      int selectedIndex, WidgetRef ref) {
    final isSelected = selectedIndex == index;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            ref.read(navigationProvider.notifier).setIndex(index);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 50),
            padding: EdgeInsets.all(isSelected ? 14.h : 10.h),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.grey[200],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.red : Colors.red.withOpacity(0.5),
              size: 24,
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(top: 4),
          width: isSelected ? 40.w : 0,
          height: 4.h,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
