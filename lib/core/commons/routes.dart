import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tembea/features/Auth/pages/login_page.dart';
// import 'package:tembea/features/destination/screens/detail_screen.dart';
import 'package:tembea/features/home/screens/home_page.dart';

final routes = RouteMap(routes: {
  "/": (_)=> const MaterialPage(child: LoginPage()),
  // "/home": (_)=> const MaterialPage(child:HomePage())
});
final loggedInRoutes = RouteMap(routes: {
  "/": (_)=> const MaterialPage(child:HomePage()),
  // "/detail-screen": (route) => const MaterialPage(child: DetailScreen())
});
