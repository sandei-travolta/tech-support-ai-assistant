import 'package:admin_panel/ui/statsPage/widgets/Categories_pie_chart.dart';
import 'package:admin_panel/ui/statsPage/widgets/requests_graph.dart';
import 'package:admin_panel/ui/statsPage/widgets/tasks_card.dart';
import 'package:admin_panel/ui/statsPage/widgets/urgency_gauge_chart.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(child: Container(
                          child: CategoriesPieChart(),
                        )),
                        Expanded(child: TasksCard())
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(child: RequestsGraph()),
                          Expanded(child: UrgencyGaugeChart())
                        ],
                  ))
                ],
              )
          ),
          Expanded(
              flex: 3,
              child: Container(
              )
          )
        ],
      ),
    );
  }
}
