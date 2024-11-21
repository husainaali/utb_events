import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utb_events/utils/size_extensions.dart';

import '../../constant/routes.dart';
import '../../widgets/custom_app_bar.dart';
import 'category_list_view.dart';

class CategoriesView extends ConsumerStatefulWidget {
  const CategoriesView({super.key});

  @override
  ConsumerState<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends ConsumerState<CategoriesView> {
  final List<Map<String, String>> categories = [
    {
      'title': 'Education events',
      'image': 'assets/education.png',
      'corner': 'topRight'
    },
    {
      'title': 'General events',
      'image': 'assets/general.png',
      'corner': 'topLeft'
    },
    {
      'title': 'Sports events',
      'image': 'assets/sport.png',
      'corner': 'bottomRight'
    },
    {
      'title': 'Food events',
      'image': 'assets/food.png',
      'corner': 'bottomLeft'
    },
    {
      'title': 'Education events',
      'image': 'assets/education.png',
      'corner': 'topRight'
    },
    {
      'title': 'General events',
      'image': 'assets/general.png',
      'corner': 'topLeft'
    },
    {
      'title': 'Sports events',
      'image': 'assets/sport.png',
      'corner': 'bottomRight'
    },
    {
      'title': 'Food events',
      'image': 'assets/food.png',
      'corner': 'bottomLeft'
    },
  ];

  final List<Map<String, dynamic>> events = [
    {
      'title': 'Bahrain Universities Conference 2025',
      'location': 'Sakheer (UOB)',
      'tag': '@UOB',
      'date': 'Jan 2025',
      'image': 'assets/university.png', // Add your image asset
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Categories'),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.87,
              ),
              itemBuilder: (context, index) {
                String corner = categories[index % 4]['corner']!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.categoryListView,
                        arguments: CategoryListViewArguments(
                          events: events,
                          categoryName: categories[index]['title']!,
                        ),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 90.w, // Adjust width as needed
                          height: 90.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: _getBorderRadius(corner),
                            image: DecorationImage(
                              image: AssetImage(categories[index]['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: _getBorderRadius(corner),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: LimitedBox(
                              maxHeight: 25.h,
                              maxWidth: 100.w,
                              child: AutoSizeText(
                                maxLines: 2,
                                minFontSize: 14,
                                maxFontSize: 16,
                                categories[index]['title']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  BorderRadius _getBorderRadius(String corner) {
    const double radius = 20.0;
    switch (corner) {
      case 'topRight':
        return const BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        );
      case 'topLeft':
        return const BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        );
      case 'bottomRight':
        return const BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
        );
      case 'bottomLeft':
        return const BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        );
      default:
        return const BorderRadius.all(Radius.circular(radius));
    }
  }
}
