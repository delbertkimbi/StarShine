// routes.dart
import 'package:flutter/material.dart';
import 'package:star_shine/game/game_screen.dart';
import 'package:star_shine/screens/artists/artist_homescreen.dart';
import 'package:star_shine/screens/artists/artist_landing.dart';
import 'package:star_shine/screens/artists/artist_login_screen.dart';
import 'package:star_shine/screens/artists/artist_notifications.dart';
import 'package:star_shine/screens/artists/artist_settings_screen.dart';
import 'package:star_shine/screens/artists/artist_signup.dart';
import 'package:star_shine/screens/challenges/challenge_creation.dart';
import 'package:star_shine/screens/fan_home_screen.dart';
import 'package:star_shine/screens/favourite_artist.dart';
import 'package:star_shine/screens/main_screen.dart';
import 'package:star_shine/screens/profile_screen.dart';
import 'package:star_shine/screens/shorts_screen.dart';
import 'package:star_shine/screens/splash_screen.dart';
import 'package:star_shine/screens/user_login.dart';
import 'package:star_shine/screens/user_signup.dart';
import 'package:star_shine/screens/usertype_selection_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String userTypeSelection = '/user-type-selection';
  static const String fanLogin = '/fan-login';
  static const String userRegistration = '/user-registration';
  static const String fanHome = '/fan-home';
  static const String userLogin = '/user-login';

  static const String artistLanding = '/artist-landing';
  static const String artistHome = '/artist-home';
  static const String createChallengeScreen = '/artist/create-challenge-screen';
  static const String artistLogin = '/artist-login';
  static const String artistNotifications = '/artist-notification';
  static const String artistRegistration = '/artist-registration';
  static const String artistProfile = '/artist-profile';
  static const String artistSettings = '/artist-settings';
  static const String favoriteArtists = '/favorite-artists';
  static const String userMainScreen = '/users/mains';
  static const String shorts = '/shorts';

  static const String game = '/game';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(), // You'll need to create this
      userTypeSelection: (context) => const UserTypeSelectionScreen(),
      fanLogin: (context) => const UserSignUp(),
      artistLanding: (context) => const ArtistLanding(),
      artistLogin: (context) => const ArtistLogin(),
      userRegistration: (context) => const UserSignUp(),
      artistRegistration: (context) => const ArtistSignUp(),
      fanHome: (context) => const FanHomeScreen(),
      artistHome: (context) => const ArtistHomeScreen(),
      artistSettings: (context) => const ArtistSettingsScreen(),
      artistProfile: (context) => const ArtistProfileScreen(),
      artistNotifications: (context) => const ArtistNotificationScreen(),
      userLogin: (context) => const UserLogin(),
      createChallengeScreen: (context) => const CreateChallengeScreen(),
      favoriteArtists: (context) => const FavoriteArtists(),
      userMainScreen: (context) => const MainScreen(),
      shorts: (context) => const ShortsScreen(videoId: '',),
      game: (context) => const GameScreen(),
    };
  }
}