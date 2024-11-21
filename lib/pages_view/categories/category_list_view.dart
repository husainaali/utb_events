import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_event_list.dart';

class CategoryListView extends ConsumerStatefulWidget {
  const CategoryListView({super.key});

  @override
  ConsumerState<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends ConsumerState<CategoryListView> {
  CategoryListViewArguments? arguments;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    arguments =
        ModalRoute.of(context)!.settings.arguments as CategoryListViewArguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: arguments!.categoryName),
      body: customEventCardList(events: arguments!.events),
    );
  }
}

class CategoryListViewArguments {
  final List<Map<String, dynamic>> events;
  final String categoryName;

  CategoryListViewArguments({required this.events, required this.categoryName});
}
