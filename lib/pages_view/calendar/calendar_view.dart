import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:math';

import '../../constant/routes.dart';
import '../../widgets/custom_app_bar.dart';

class CalendarView extends ConsumerStatefulWidget {
  const CalendarView({super.key});

  @override
  ConsumerState<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends ConsumerState<CalendarView>
    with SingleTickerProviderStateMixin {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late AnimationController _animationController;
  final List<EventButton> _eventButtons = [];
  final List<Map<String, dynamic>> events = [
    {
      'title': 'Bahrain Universities Conference 2025',
      'location': 'Sakheer (UOB)',
      'tag': '@UOB',
      'date': 'Jan 2025',
      'image': 'assets/university.png',
    },
    {
      'title': 'UTB Sports Day',
      'location': 'UTB Sports Complex',
      'tag': '@UTB',
      'date': 'Mar 2025',
      'image': 'assets/match.png',
    },
    {
      'title': 'International Food Festival',
      'location': 'UTB Campus',
      'tag': '@UTB',
      'date': 'Apr 2025',
      'image': 'assets/food.png',
    },
    {
      'title': 'Student Research Conference',
      'location': 'UTB Auditorium',
      'tag': '@UTB',
      'date': 'May 2025',
      'image': 'assets/university.png',
    },
    {
      'title': 'Career Fair 2025',
      'location': 'UTB Exhibition Hall',
      'tag': '@UTB',
      'date': 'Jun 2025',
      'image': 'assets/event.png',
    }
  ];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Create event buttons from events list
    for (var i = 0; i < events.length; i++) {
      _eventButtons.add(
        EventButton(
          offset: i * (1.0 / events.length),
          eventData: events[i],
        ),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Calendar'),
      body: Stack(
        children: [
          Column(
            children: [
              TableCalendar(
                firstDay: DateTime.now().subtract(const Duration(days: 365)),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  weekendTextStyle: const TextStyle(color: Colors.red),
                  selectedDecoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),
            ],
          ),
          ...(_eventButtons.map((button) => AnimatedEventButton(
                animation: _animationController,
                offset: button.offset,
                eventData: button.eventData,
              ))),
        ],
      ),
    );
  }
}

class EventButton {
  final double offset;
  final Map<String, dynamic> eventData;

  EventButton({
    required this.offset,
    required this.eventData,
  });
}

class AnimatedEventButton extends StatelessWidget {
  final AnimationController animation;
  final double offset;
  final Map<String, dynamic> eventData;

  const AnimatedEventButton({
    Key? key,
    required this.animation,
    required this.offset,
    required this.eventData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        final progress = (animation.value + offset) % 1.0;
        final x = screenWidth - (progress * (screenWidth + 100));
        final wave = sin(progress * 2 * pi) * 30;
        final y = screenHeight * 0.6 + wave;

        return Positioned(
          left: x,
          top: y,
          child: GestureDetector(
            onTap: () {
              // Show event details in a dialog or navigate to event page
              Navigator.pushNamed(
                context,
                AppRoutes.eventView,
                arguments: eventData,
              );
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(eventData['image']),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
