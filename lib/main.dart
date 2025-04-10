import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solnote/features/home/page/home_page.dart';
import 'package:solnote/utils/app_constants.dart';
import 'package:solnote/utils/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

final appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp.router(
      title: AppConstants.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          secondary: const Color(0XFF00ffff),
          tertiary: const Color(0XFFff9f00),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
      // home: HomePage(),
    );
  }
}
