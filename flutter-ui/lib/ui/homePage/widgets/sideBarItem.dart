import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SidebarItem extends StatelessWidget {
  final String label;
  final String route;

  const SidebarItem({required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    final isSelected = GoRouterState.of(context).uri.toString() == route;

    return ListTile(
      title: Text(label, style: TextStyle(color: isSelected?Colors.blue:Colors.grey)),
      selected: isSelected,
      onTap: () {
        context.go(route); // <--- IMPORTANT
      },
    );
  }
}
