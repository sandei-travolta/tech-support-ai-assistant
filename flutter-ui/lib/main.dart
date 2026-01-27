import 'package:admin_panel/data/repositories/MessagingRepositories.dart';
import 'package:admin_panel/data/services/messageService.dart';
import 'package:admin_panel/routing/router.dart';
import 'package:admin_panel/ui/conversationsPage/view_models/conversations_page_model_view.dart';
import 'package:admin_panel/ui/dashboard/view_models/table_view_model.dart';
import 'package:admin_panel/utils/themeData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_)=>TableViewModel(
              MessagingRepositories(MessagingService())
            ),
            ),
            ChangeNotifierProvider(create: (_)=>ConversationsPageModelView())
          ],
          child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Admin-Panel-Tech-AI',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: route(),
    );
  }
}

