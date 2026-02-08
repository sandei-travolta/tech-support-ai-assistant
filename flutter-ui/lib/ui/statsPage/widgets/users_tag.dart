import 'package:admin_panel/ui/statsPage/view_models/unique_users_model_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersTag extends StatefulWidget {


  const UsersTag({
    super.key,
  });

  @override
  State<UsersTag> createState() => _UsersTagState();
}

class _UsersTagState extends State<UsersTag> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UniqueUsersModelView>().fetchUsers();
    });
  }
  @override
  Widget build(BuildContext context) {
    final vm=context.watch<UniqueUsersModelView>();
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              vm.users.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Total Users',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}