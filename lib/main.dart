import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'models/service_provider.dart';
import 'models/service_category.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/service_providers_screen.dart';
import 'screens/provider_detail_screen.dart';
import 'screens/provider_login_screen.dart';
import 'screens/provider_signup_screen.dart';
import 'screens/provider_dashboard_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/service_provider_provider.dart';
import 'providers/category_provider.dart';
import 'utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => ServiceProviderProvider()),
        ChangeNotifierProvider(create: (ctx) => CategoryProvider()),
      ],
      child: MaterialApp(
        title: 'Khidma',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        routes: {
          '/': (ctx) => const SplashScreen(),
          '/home': (ctx) => const HomeScreen(),
          '/service-providers': (ctx) => const ServiceProvidersScreen(),
          '/provider-detail': (ctx) => const ProviderDetailScreen(),
          '/provider-login': (ctx) => const ProviderLoginScreen(),
          '/provider-signup': (ctx) => const ProviderSignupScreen(),
          '/provider-dashboard': (ctx) => const ProviderDashboardScreen(),
        },
      ),
    );
  }
}
