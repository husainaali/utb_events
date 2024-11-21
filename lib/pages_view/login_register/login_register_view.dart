import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:utb_events/utils/size_extensions.dart';

import '../../constant/colors.dart';
import '../../provider/main_provider.dart';
import '../main_navigation.dart';
import '../../utils/university_data.dart';

const List<String> universityOccupations = [
  'Student',
  'Professor',
  'Lecturer',
  'Dean',
  'Department Head',
  'Administrator',
  'Accountant',
  'Advertiser',
  'Marketing Staff',
  'Alumni',
  'Research Assistant',
  'Teaching Assistant',
  'Library Staff',
  'IT Staff',
  'Other',
];

class LoginRegisterView extends ConsumerStatefulWidget {
  const LoginRegisterView({super.key});

  @override
  ConsumerState<LoginRegisterView> createState() => _LoginRegisterViewState();
}

class _LoginRegisterViewState extends ConsumerState<LoginRegisterView> {
  bool isSignIn = true;

  void onPressedSwitcher() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final setLogIn = ref.read(navigationProvider);
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isSignIn ? 250.h : 130.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/university.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                height: 250.h,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (isSignIn)
                      SvgPicture.asset(
                        'assets/calendar.svg',
                        height: 60.h,
                      ),
                    const Gap(10),
                    const Text(
                      'UTB Events',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          isSignIn
              ? signInWidget(context, onPressedSwitcher, ref)
              : Expanded(
                  child: signUpWidget(context, onPressedSwitcher),
                ),
        ],
      ),
    );
  }
}

Widget signInWidget(BuildContext context, void Function() onPressedSwitcher,
        WidgetRef ref) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account? "),
              TextButton(
                onPressed: onPressedSwitcher,
                child: Text(
                  'Sign up here',
                  style: TextStyle(
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          Gap(24.h),
          TextField(
            decoration: InputDecoration(
              labelText: 'User Name',
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
          ),
          Gap(24.h),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
          ),
          Gap(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                    activeColor: primaryColor,
                  ),
                  Text(
                    'Remember me',
                    style: TextStyle(color: primaryColor),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forget Password?',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          Gap(24.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                print('Login button pressed');
                ref.read(navigationProvider.notifier).setLoginStatus(true);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainNavigationView()),
                    (route) => false);
                print('Login status updated');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Gap(16.h),
        ],
      ),
    );

Widget signUpWidget(BuildContext context, void Function() onPressedSwitcher) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account? "),
              TextButton(
                onPressed: onPressedSwitcher,
                child: const Text(
                  'Sign in here',
                  style: TextStyle(
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          Gap(24.h),
          TextField(
            decoration: InputDecoration(
              labelText: 'User Name',
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
          ),
          Gap(24.h),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
          ),
          Gap(24.h),
          TextField(
            decoration: InputDecoration(
              labelText: 'Full Name',
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
          ),
          Gap(24.h),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Personal ID',
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
          ),
          Gap(24.h),
          TextField(
            decoration: InputDecoration(
              labelText: 'Phone Number',
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
          ),
          Gap(24.h),
          DropdownButtonFormField<String>(
            hint: const Text('Select Occupation'),
            items: universityOccupations.map((occupation) {
              return DropdownMenuItem(
                value: occupation,
                child: Text(occupation),
              );
            }).toList(),
            onChanged: (value) {},
            decoration: InputDecoration(
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
          ),
          Gap(24.h),
          DropdownButtonFormField<String>(
            hint: const Text('Select University'),
            items: bahrainUniversities.map((university) {
              return DropdownMenuItem(
                value: university.shortName,
                child: LimitedBox(
                  maxWidth: 200.w,
                  child: AutoSizeText(
                    maxLines: 1,
                    minFontSize: 10,
                    maxFontSize: 16,
                    '${university.name} (${university.shortName})',
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {},
            decoration: InputDecoration(
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
          ),
          Gap(24.h),
          TextField(
            decoration: InputDecoration(
              labelText: 'Academic ID',
            ),
          ),
          Gap(24.h),
          TextField(
            decoration: InputDecoration(
              labelText: 'Date of Birth',
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
            readOnly: true,
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              // Handle the selected date
            },
          ),
          Gap(24.h),
          DropdownButtonFormField(
            hint: const Text('Select Gender'),
            items: const [
              DropdownMenuItem(value: "Male", child: Text("Male")),
              DropdownMenuItem(value: "Female", child: Text("Female")),
            ],
            onChanged: (value) {},
          ),
          Gap(24.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
