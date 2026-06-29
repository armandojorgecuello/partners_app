import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/router/app_routes.dart';
import 'package:partners_app/core/theme/app_theme.dart';
import 'package:partners_app/features/auth/presentation/pages/auth_gate_page.dart';
import 'package:partners_app/features/auth/presentation/pages/login_page.dart';
import 'package:partners_app/features/auth/presentation/pages/new_user_page.dart';
import 'package:partners_app/features/images/presentation/pages/my_images_page.dart';
import 'package:partners_app/features/legal/presentation/pages/privacy_policy_page.dart';
import 'package:partners_app/features/legal/presentation/pages/terms_of_service_page.dart';
import 'package:partners_app/features/notifications/presentation/pages/show_notifications_page.dart';
import 'package:partners_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:partners_app/features/partners/presentation/pages/add_partner_page.dart';
import 'package:partners_app/features/partners/presentation/pages/partners_accepted_page.dart';
import 'package:partners_app/features/partners/presentation/pages/partners_request_page.dart';
import 'package:partners_app/features/profile/presentation/pages/change_number_page.dart';
import 'package:partners_app/features/profile/presentation/pages/notification_settings_page.dart';
import 'package:partners_app/features/profile/presentation/pages/profile_page.dart';
import 'package:partners_app/features/profile/presentation/pages/settings_page.dart';
import 'package:partners_app/features/support/presentation/pages/support_tickets_page.dart';
import 'package:partners_app/features/tasks/domain/entities/task.dart';
import 'package:partners_app/features/tasks/presentation/pages/new_task_page.dart';
import 'package:partners_app/features/tasks/presentation/pages/task_list_page.dart';
import 'package:partners_app/features/tasks/presentation/pages/view_task_page.dart';

/// Composition root: wires the theme, localization and route table that used
/// to live in lib/main.dart's `MyApp`. Each feature owns its page widgets;
/// this file only assembles them behind the route names in core/router.
class PartnersApp extends StatelessWidget {
  const PartnersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Partners',
      theme: AppTheme.light,
      routes: {
        AppRoutes.root: (context) => const AuthGatePage(),
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.newUser: (context) => const NewUserPage(),
        AppRoutes.onboarding: (context) => const OnboardingPage(),
        AppRoutes.home: (context) => const TaskListPage(),
        AppRoutes.newTask: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          return NewTaskPage(partnerUid: args is String ? args : null);
        },
        AppRoutes.viewTask: (context) {
          final task = ModalRoute.of(context)!.settings.arguments as Task;
          return ViewTaskPage(task: task);
        },
        AppRoutes.profile: (context) => const ProfilePage(),
        AppRoutes.settings: (context) => const SettingsPage(),
        AppRoutes.changeNumber: (context) => const ChangeNumberPage(),
        AppRoutes.myImages: (context) => const MyImagesPage(),
        AppRoutes.partnersRequest: (context) => const PartnersRequestPage(),
        AppRoutes.addPartners: (context) => const AddPartnerPage(),
        AppRoutes.partnersAccepted: (context) => const PartnersAcceptedPage(),
        AppRoutes.notifications: (context) => const ShowNotificationsPage(),
        AppRoutes.notificationSettings: (context) => const NotificationSettingsPage(),
        AppRoutes.supportTickets: (context) => const SupportTicketsPage(),
        AppRoutes.privacyPolicy: (context) => const PrivacyPolicyPage(),
        AppRoutes.termsOfService: (context) => const TermsOfServicePage(),
      },
      supportedLocales: const [Locale('en'), Locale('es')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
