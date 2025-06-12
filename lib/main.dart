import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miles_assignment/firebase_options.dart';
import 'package:miles_assignment/providers/providers.dart';
import 'package:miles_assignment/screens/home_screen.dart';
import 'package:miles_assignment/screens/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812), // Base design size (iPhone X)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
            // Make text scaling responsive
          ),
          home: child,
        );
      },
      child: authState.when(
        data: (user) {
          if (user == null) {
            return const SignInScreen();
          }
          return const HomeScreen();
        },
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stackTrace) =>
            Scaffold(body: Center(child: Text('Error: $error'))),
      ),
    );
  }
}
