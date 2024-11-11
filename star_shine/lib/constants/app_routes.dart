// routes.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:star_shine/screens/splash_screen.dart';
import 'package:star_shine/screens/usertype_selection_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String userTypeSelection = '/user-type-selection';
  static const String fanLogin = '/fan-login';
  static const String artistLogin = '/artist-login';
  static const String fanRegistration = '/fan-registration';
  static const String artistRegistration = '/artist-registration';
  static const String fanHome = '/fan-home';
  static const String artistHome = '/artist-home';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(), // You'll need to create this
      userTypeSelection: (context) => const UserTypeSelectionScreen(),
      // fanLogin: (context) => const FanLoginScreen(), // You'll need to create this
      // artistLogin: (context) => const ArtistLoginScreen(), // You'll need to create this
      // fanRegistration: (context) => const FanRegistrationScreen(), // You'll need to create this
      // artistRegistration: (context) => const ArtistRegistrationScreen(), // You'll need to create this
      // fanHome: (context) => const FanHomeScreen(),
      // artistHome: (context) => const ArtistHomeScreen(), // You'll need to create this
    };
  }
}