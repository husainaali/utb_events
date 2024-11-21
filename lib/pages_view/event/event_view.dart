import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utb_events/utils/size_extensions.dart';

import '../../widgets/custom_event_list.dart';

class EventView extends ConsumerStatefulWidget {
  const EventView({super.key});

  @override
  ConsumerState<EventView> createState() => _EventViewState();
}

class _EventViewState extends ConsumerState<EventView> {
  EventViewArguments? arguments;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    arguments = EventViewArguments(event: routeArgs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.h),
        child: Container(
          height: 200.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(arguments!.event['image']),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 60),
                  child: Row(
                    children: [
                          IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        arguments!.event['title'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            arguments!.event['location'],
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            arguments!.event['tag'],
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 50.h,
                      width: 80.w,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            '1', // You can split the date string to get this
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Jan\n2025', // You can split the date string to get this
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Event Details:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We are pleased to invite you to the ${arguments!.event['title']}, '
                    'an esteemed gathering of academic leaders, researchers, and students from '
                    'universities across the nation. This year\'s conference aims to foster collaboration, '
                    'share insights, and explore advancements in education and research.',
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Highlights:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• Keynote speakers from leading academic institutions'),
                      Text('• Panel discussions with industry experts'),
                      Text('• Workshops and networking sessions'),
                      Text('• Research paper presentations'),
                      Text('• Student poster exhibitions'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Registration:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'To confirm your attendance, please register by February 1, 2025, at our conference website '
                    'or contact us at conference@bahrainedu2025.com for further information.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventViewArguments {
  final Map<String, dynamic> event;
  EventViewArguments({required this.event});
}
