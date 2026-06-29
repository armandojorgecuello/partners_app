/// Central registry of route-name strings so features don't repeat magic
/// literals. Each feature still owns its page widgets and any typed
/// navigation-argument classes; this file only names the destinations.
///
/// Screens reached only via a direct `MaterialPageRoute` push within the
/// same feature (country picker, OTP verification, chat, negotiation, pay,
/// review) intentionally have no named route here — see each feature's
/// presentation/pages for those.
class AppRoutes {
  AppRoutes._();

  static const root = '/';
  static const login = 'loginPage';
  static const newUser = 'new_user';
  static const onboarding = 'onboarding';

  static const home = 'home_page';
  static const newTask = 'new_task';
  static const viewTask = 'view_task';

  static const profile = 'profile';
  static const settings = 'setting';
  static const changeNumber = 'change_number';
  static const myImages = 'my_images';

  static const partnersRequest = 'partners_request';
  static const addPartners = 'add_partners';
  static const partnersAccepted = 'partners_accepted';

  static const notifications = 'notifications';
  static const notificationSettings = 'notification_settings';
  static const supportTickets = 'support_tickets';
  static const privacyPolicy = 'privacy_policy';
  static const termsOfService = 'terms_of_service';
}
