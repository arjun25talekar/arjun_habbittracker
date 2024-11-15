import 'package:arjun_habbittracker/state/hive_model.dart';
import 'package:arjun_habbittracker/ui/screens/dashboard_screen.dart';
import 'package:arjun_habbittracker/ui/screens/habit_details.dart';
import 'package:arjun_habbittracker/ui/screens/habit_overview.dart';
import 'package:arjun_habbittracker/ui/widgets/setting.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/overview',
      name: 'habitOverview',
      builder: (context, state) => const HabitOverviewScreen(),
    ),
    GoRoute(
      path: '/details',
      name: 'habitDetails',
      builder: (context, state) {
        final habit = state.extra as Habit?;
        if (habit == null) {
          throw Exception(
              "Habit data is required to navigate to HabitDetailsScreen.");
        }
        return HabitDetailsScreen(habit: habit);
      },
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
