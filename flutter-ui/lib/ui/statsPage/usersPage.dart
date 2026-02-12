import 'package:admin_panel/ui/statsPage/widgets/categories_pie_chart.dart';
import 'package:admin_panel/ui/statsPage/widgets/requests_graph.dart';
import 'package:admin_panel/ui/statsPage/widgets/tasks_card.dart';
import 'package:admin_panel/ui/statsPage/widgets/urgency_gauge_chart.dart';
import 'package:admin_panel/ui/statsPage/widgets/users_table.dart';
import 'package:admin_panel/ui/statsPage/widgets/users_tag.dart';
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
              child: Container(
                padding: .all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          const SizedBox(width: 5),
                          Expanded(child: TasksCard())
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text("Requests Graph",style: Theme.of(context).textTheme.titleMedium),
                                const SizedBox(height: 10),
                                RequestsGraph(),
                              ],
                            )),
                            const SizedBox(width: 25.0),
                            Expanded(child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text("Requests Urgencey",style: Theme.of(context).textTheme.titleMedium),
                                const SizedBox(height: 10),
                                UrgencyGaugeChart(),
                              ],
                            ))
                          ],
                    ))
                  ],
                ),
              )
          ),
          Expanded(
              flex: 3,
              child: Container(
                padding: .all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UsersTag(),
                    const SizedBox(height: 25.0),
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text("Query Categories",style: Theme.of(context).textTheme.labelLarge),
                        CategoriesPieChart(),
                      ],
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
