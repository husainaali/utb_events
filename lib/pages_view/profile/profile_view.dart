import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utb_events/utils/size_extensions.dart';

import '../../constant/colors.dart';
import '../../provider/main_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../main_navigation.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'UTB Events'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Card
            Card(
              color: Colors.pink[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person, size: 35),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NASSER HUSSAIN',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'nasser@utb.events.app',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Menu Items
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.red),
              title: const Text('Notification'),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
                activeColor: Colors.red,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.headset_mic, color: Colors.red),
              title: const Text('Help and support'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ref.read(navigationProvider.notifier).setLoginStatus(false);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainNavigationView()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
