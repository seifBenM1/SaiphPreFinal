import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saiphappfinal/Screens/Splash.dart';
import 'package:saiphappfinal/Screens/user_formulaire_one.dart';
import 'package:saiphappfinal/providers/user_provider.dart';
import 'package:saiphappfinal/utils/games_utils/inject_dependencies.dart';
import 'package:provider/provider.dart';
import 'package:saiphappfinal/Screens/Quiz/Quiz_screen.dart';
import 'package:saiphappfinal/Screens/Games/flappybird/main.dart';
import 'package:saiphappfinal/Screens/SignInScreen.dart';
import 'Responsive/mobile_screen_layout.dart';
import 'Responsive/responsive_layout_screen.dart';
import 'Responsive/web_screen_layout.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDd73LUWiKhfIm9hoS7OtqqfrsIdpGf3-I",
          authDomain: "mysaiph-26b1c.firebaseapp.com",
          projectId: "mysaiph-26b1c",
          storageBucket: "mysaiph-26b1c.appspot.com",
          messagingSenderId: "154959907692",
          appId: "1:154959907692:web:519c2023e47834f7518149",
          measurementId: "G-1Z9EGRPDCD"
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  await FirebaseAuth.instance.currentUser;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}); // Fix the constructor syntax

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(useMaterial3: false),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {

                  // User is already signed in and verified, navigate to the responsive screen

                  // User is signed in but not verified, navigate to the main screen
                  return SignInScreen();

              }
            }

            // Connection to future hasn't been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // Show splash screen by default
            return SplashScreen();
          },
        ),
      ),
    );
  }
}
