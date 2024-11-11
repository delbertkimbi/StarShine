// routes.dart
import 'package:flutter/material.dart';
import 'package:star_shine/screens/artist_homescreen.dart';
import 'package:star_shine/screens/artist_signup.dart';
import 'package:star_shine/screens/fan_home_screen.dart';
import 'package:star_shine/screens/splash_screen.dart';
import 'package:star_shine/screens/user_signup.dart';
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
      fanLogin: (context) => const UserSignUp(),
      artistLogin: (context) => const ArtistSignUp(),
      fanRegistration: (context) => const UserSignUp(),
      artistRegistration: (context) => const ArtistSignUp(),
      fanHome: (context) => const FanHomeScreen(),
      artistHome: (context) => const ArtistHomeScreen(),
    };
  }
}