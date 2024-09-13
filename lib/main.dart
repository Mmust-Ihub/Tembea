import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tembea/core/commons/Loader.dart';
import 'package:tembea/core/permissions.dart';
import 'package:tembea/core/commons/error_text.dart';
import 'package:tembea/core/commons/routes.dart';
import 'package:tembea/features/Auth/controllers/auth_controller.dart';
import 'package:tembea/models/user_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestPermissions();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

// ErrorText(error: error.toString());
  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangProvider).when(
          data: (data) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Tembea',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              fontFamily: "Roboto",
            ),
            routeInformationParser: const RoutemasterParser(),
            routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
              if (data != null) {
                getData(ref, data);
                if (userModel != null) return loggedInRoutes;
              }
              return routes;
            }),
          ),
          error: (error, stackTrace) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Tembea',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              fontFamily: "Roboto",
            ),
            home: ErrorText(error: error.toString()),
          ),
          loading: () => const Loader(),
        );
  }
}



// fpdot  
