import 'package:enduro/view/history/history_screen.dart';
import 'package:enduro/view/home/home_screen.dart';
import 'package:enduro/view/onboarding/onboarding_screen.dart';
import 'package:enduro/view/workout/workout_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class Routes {
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const history = '/history';
  static const workout = '/workout';
}

final getScreens = [
  _buildScreen(Routes.onboarding, () => const OnboardingScreen()),
  _buildScreen(Routes.home, () => const HomeScreen()),
  _buildScreen(Routes.history, () => const HistoryScreen()),
  _buildScreen(Routes.workout, () => const WorkoutScreen()),
];

GetPage _buildScreen(String name, GetPageBuilder page) {
  return GetPage(name: name, page: page, transition: Transition.native);
}
