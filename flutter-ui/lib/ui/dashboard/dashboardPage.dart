import 'package:flutter/cupertino.dart';

import '../../utils/colors.dart';
import 'widgets/btnCards.dart';
import 'widgets/paginationCounter.dart';
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
          Align(
              alignment: .topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0,bottom: 5.0),
                child: Text("DashBoard".toUpperCase(),style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600
                ),),
              )),
          Row(
            mainAxisAlignment: .spaceAround,
            children: [
              BtnCard(
                text: 'Issues',
                color: AppColors.cardBackground.withOpacity(0.6),
                description: 'Check Reoccurring Raised issues',
              ),
              BtnCard(
                text: "Request",
                color: AppColors.cardBackground2.withOpacity(0.9),
                description: 'Total Requests'),
              BtnCard(
                text: "Conversations",
                color: AppColors.cardBackground3.withOpacity(0.9),
                description: 'Total Conversations',),
            ],
          ),
          TittleSection(),
          TableSection(),
          PaginationCounter()
        ],
      ),
    );
  }
}


