import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the provider
final navigationProvider =
    StateNotifierProvider<NavigationNotifier, int>((ref) {
  return NavigationNotifier();
});

// Create the state notifier class
class NavigationNotifier extends StateNotifier<int> {
  NavigationNotifier() : super(0);

  int _isLoggedIn = 0;
  int get isLoggedIn => _isLoggedIn;

  void setLoginStatus(bool status) {
    _isLoggedIn = status ? 1 : 0;
  }

  void setIndex(int index) {
    state = index;
  }
}
