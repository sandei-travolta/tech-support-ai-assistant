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


