import 'package:flutter/material.dart';

class LogOutBtn extends StatelessWidget {
  const LogOutBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      mainAxisAlignment: .end,
      children: [
        IconButton(onPressed: (){}, icon: Icon(Icons.logout_outlined)),
        Text("Log Out")
      ],
    );
  }
}
