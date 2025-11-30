import 'package:admin_panel/routing/routes.dart';
import 'package:admin_panel/ui/homePage/homePage.dart';
import 'package:admin_panel/ui/loginPage/loginpage.dart';
import 'package:admin_panel/ui/splashScreen/splashScreen.dart';
import 'package:go_router/go_router.dart';

GoRouter route()=>GoRouter(
    initialLocation: Routes.splashScreen,
    routes: [
      GoRoute(
          path: Routes.splashScreen,
          builder: (builder,ctx){
            return Splashscreen();
          }),
      GoRoute(
          path:Routes.home,
          builder: (builder,context){
            return Homepage();
          }),
      GoRoute(
          path: Routes.login,
          builder:(builder,context){
            return Loginpage();
          }),
    ],

);