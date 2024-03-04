import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylesync/futures/authentication/screens/onboarding/onboarding.dart';
import 'package:stylesync/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Flutter App',
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: OnBoardingScreen(),
    );
  }
}
