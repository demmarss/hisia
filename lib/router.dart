import 'package:go_router/go_router.dart';
import 'package:hisia/pages/account_page.dart';
import 'package:hisia/pages/home_screen.dart';
import 'package:hisia/pages/login_page.dart';

final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => AccountScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(),
      )
    ]);
