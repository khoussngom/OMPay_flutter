import 'package:get/get.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/home_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';

  static final pages = [
    GetPage(
      name: login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: home,
      page: () => const HomePage(),
    ),
  ];
}