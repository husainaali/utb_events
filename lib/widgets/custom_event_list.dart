import 'package:flutter/material.dart';
import 'package:utb_events/utils/size_extensions.dart';

import '../constant/routes.dart';

ListView customEventCardList({required List<Map<String, dynamic>> events}) {
  return ListView.builder(
    itemCount: events.length,
    itemBuilder: (context, index) {
      return eventCard(context: context, event: events[index]);
    },
  );
}

Container eventCard({
  required BuildContext context,
  required Map<String, dynamic> event,
}) {
  return Container(
    height: 200.h,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(event['image']),
        fit: BoxFit.cover,
      ),
    ),
    child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.eventView, arguments: event);
      },
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
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
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
                    child: Row(
                      children: [
                        Text(
                          event['date'].toString().split(' ')[
                              0], // You can split the date string to get this
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          event['date']
                              .toString()
                              .split(' ')[1]
                              .split('-')
                              .first, // You can split the date string to get this
                          style: const TextStyle(
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        event['location'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        event['tag'],
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
