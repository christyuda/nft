import 'dart:async';

import 'package:webordernft/main.dart';

import '../../config/constant.dart';

/// Service for handling user auto logout based on user activity
class AutoLogoutService {
  static Timer? _timer;
  static const autoLogoutTimer = timeOut;
  // Instance of authentication service, prefer singleton
  final AuthService _authService = AuthService();

  /// Resets the existing timer and starts a new timer
  void startNewTimer(context) {
    stopTimer();
    if (_authService.isUserLoggedIn()) {
      _timer = Timer.periodic(const Duration(seconds: autoLogoutTimer), (_) {
        timedOut(context);
      });
    }
  }

  /// Stops the existing timer if it exists
  void stopTimer() {
    if (_timer != null || (_timer?.isActive != null && _timer!.isActive)) {
      _timer?.cancel();
    }
  }

  /// Track user activity and reset timer
  void trackUserActivity(context) async {
    // void trackUserActivity(context, [_]) async {
    print('User Activity Detected!');
    if (_authService.isUserLoggedIn() && _timer != null) {
      startNewTimer(context);
    }
  }

  /// Called if the user is inactive for a period of time and opens a dialog
  Future<void> timedOut(context) async {
    stopTimer();
    if (_authService.isUserLoggedIn()) {
      _authService.logoutUser(context);
    }
  }
}

/// For managing the authentication logic
class AuthService {
  bool isUserLoggedIn() {
    // Update as per logged in logic
    // print('Logged in');
    return true;
  }

  void logoutUser(context) async {
    // Logout the user

    navigatorKey.currentState?.pushNamed('loginlanding');

    print('app Logged Out: auto logout');
  }
}
