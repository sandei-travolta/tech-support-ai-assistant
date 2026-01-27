import 'package:admin_panel/routing/routes.dart';
import 'package:admin_panel/ui/conversationsPage/conversationsPage.dart';
import 'package:admin_panel/ui/dashboard/dashboardPage.dart';
import 'package:admin_panel/ui/homePage/homePage.dart';
import 'package:admin_panel/ui/loginPage/loginpage.dart';
import 'package:admin_panel/ui/splashScreen/splashScreen.dart';
import 'package:go_router/go_router.dart';

import '../ui/statsPage/usersPage.dart';

GoRouter route()=>GoRouter(
    initialLocation: Routes.splashScreen,
    routes: [
      GoRoute(
          path: Routes.splashScreen,
          builder: (builder,ctx){
            return Splashscreen();
          }),
      GoRoute(
          path: Routes.login,
          builder:(builder,context){
            return Loginpage();
          }),
      ShellRoute(
          builder: (context,state,child){
            return Homepage(child: child);
          },
          routes: [
            GoRoute(
                path: Routes.home,
                builder: (context,state){
                  return DashBoardPage();
                },
                routes:<RouteBase>[
                  GoRoute(
                      path: Routes.conversations,
                      builder: (context,state){
                        return ConversationsPage();
                      }),
                  GoRoute(
                      path: Routes.users,
                      builder: (context,state){
                        return UsersPage();
                      })
                ]
            ),
          ]
          /*routes: GoRoute(
              path:"",
              ))*/
      )
    ],

);