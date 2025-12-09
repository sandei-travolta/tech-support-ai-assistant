import 'package:flutter/cupertino.dart';

import 'widgets/btnCards.dart';
import 'widgets/tableSection.dart';
import 'widgets/tagWidget.dart';
import 'widgets/tittleSection.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .maxFinite,
      padding: .only(top:50.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .spaceAround,
            children: [
              BtnCard(text: 'Issues',),
              BtnCard(text: "Request",),
              BtnCard(text: "Conversations",)
            ],
          ),
          TittleSection(),
          TableSection()
        ],
      ),
    );
  }
}



