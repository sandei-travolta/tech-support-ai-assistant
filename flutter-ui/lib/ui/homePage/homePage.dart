import 'package:admin_panel/routing/routes.dart';
import 'package:admin_panel/ui/homePage/widgets/sideBarItem.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          //Side Bar
          Container(
            width: 250.0,
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                SidebarItem(label: "Home", route: Routes.home),
                SidebarItem(label: "Conversations", route: Routes.conversations),
                SidebarItem(label: "Users", route: Routes.users),
                Expanded(child: Container()),
                Container(
                  width: .infinity,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text("Log Out"),
                      Text("Settings")
                    ],
                  ),
                ),
                const SizedBox(
                  height: 55.0,
                )
              ],
            ),
          ),
          Expanded(child: child)
        ],
      ),
    );
  }
}
