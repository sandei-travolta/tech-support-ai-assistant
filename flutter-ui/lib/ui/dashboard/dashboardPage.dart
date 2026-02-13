import 'package:admin_panel/ui/dashboard/view_models/cards_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import 'widgets/btnCards.dart';
import 'widgets/paginationCounter.dart';
import 'widgets/tableSection.dart';
import 'widgets/tittleSection.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<CardsViewModel>().fetchUniqueUsers();
      context.read<CardsViewModel>().fetchRequest();
      context.read<CardsViewModel>().fetchConversationCount();
    });
  }
  @override
  Widget build(BuildContext context) {
    final c=context.watch<CardsViewModel>();
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
                text: 'Users',
                color: AppColors.cardBackground.withOpacity(0.6),
                description: 'Unique Users',
                data: c.uniqueUsers,
              ),
              BtnCard(
                text: "Request",
                color: AppColors.cardBackground2.withOpacity(0.9),
                description: 'Total Requests',
                data: c.totalRequests,
              ),
              BtnCard(
                text: "Conversations",
                color: AppColors.cardBackground3.withOpacity(0.9),
                description: 'Total Conversations',
                data: c.conversations,
              )
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


