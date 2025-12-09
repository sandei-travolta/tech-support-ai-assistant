import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SidebarItem extends StatelessWidget {
  final String label;
  final String route;

  const SidebarItem({required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    final isSelected = GoRouterState.of(context).uri.toString() == route;

    return Container(
      decoration: BoxDecoration(
        color: isSelected?Colors.black:Colors.white,
        borderRadius: BorderRadius.circular(12.0)
      ),
      child: ListTile(

        title: Text(label, style: TextStyle(color: isSelected?Colors.white:Colors.black)),
        selected: isSelected,
        onTap: () {
          context.go(route);
        },
      ),
    );
  }
}
