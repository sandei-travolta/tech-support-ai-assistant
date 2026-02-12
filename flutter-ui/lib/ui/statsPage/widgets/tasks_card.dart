import 'package:admin_panel/ui/statsPage/view_models/tasks_model_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksCard extends StatefulWidget {
  const TasksCard({super.key});

  @override
  State<TasksCard> createState() => _TasksCardState();
}

class _TasksCardState extends State<TasksCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TasksModelView>().fetchHumanRation();
      context.read<TasksModelView>().fetchTotalMessages();
    });
  }
  @override
  Widget build(BuildContext context) {
    final vm=context.watch<TasksModelView>();
    final human=vm.humanRatio*100;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 55.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: .circular(12.0)
        ),
        child: Column(
          children: [
            Expanded(child: Stack(
              children: [
                Container(
                  padding: .all(12.0),
                  child: Row(
                    children: [
                      Text("${human.toInt().toString()}%",style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.white,
                        fontWeight: .w700
                      ),),
                      const SizedBox(width: 15.0),
                      Text("Requests Require\nHuman Intervation",style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,

                      ),)
                    ],
                  ),
                ),
                Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      height: 40,
                      width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: .circle
                  ),
                  child: Center(
                    child: Text(vm.totalRequests.toString(),style: Theme.of(context).textTheme.labelLarge),
                  ),
                ))
              ],
            )),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                padding: .all(12.0),
                decoration: BoxDecoration(
                  borderRadius: .circular(12.0),
                  color: Colors.white
                ),
                child: Row(
                  children: [
                    Text("${(100-human).toInt().toString()}%",style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.black54,
                        fontWeight: .w700
                    ),),
                    const SizedBox(width: 15.0),
                    Text("Requests Do not Require\nHuman Intervation",style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                    ),)
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
