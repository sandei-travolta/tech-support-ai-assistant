import 'package:admin_panel/ui/dashboard/view_models/table_view_model.dart';
import 'package:admin_panel/utils/format_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
class TableSection extends StatefulWidget {
  const TableSection({super.key});

  @override
  State<TableSection> createState() => _TableSectionState();
}

class _TableSectionState extends State<TableSection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TableViewModel>().loadMessages();
    });
  }
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TableViewModel>();
    return Builder(
      builder: (context) {
        if(vm.isLoading){
          return Center(child: CircularProgressIndicator());
        }
        if (vm.error != null) {
          return Center(child: Text(vm.error!));
        }
        return Container(
          margin: const EdgeInsets.all(16),
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: IntrinsicColumnWidth(),
              1: FixedColumnWidth(200),
              2: FixedColumnWidth(100),
              3:FixedColumnWidth(280),
              4:FlexColumnWidth(),
              5:FlexColumnWidth()
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              // Table header
              TableRow(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: .circular(12.0)),
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Sender',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Message',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'category',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Response',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Status',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'TimeStamp',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container()
                  ),
                ],
              ),
              TableRow(
                children: List.generate(7, (context){
                  return SizedBox(height: 10);
                })
              ),

              // Data rows
              for (int i = 0; i < vm.visibleMessages.length; i++)
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(vm.visibleMessages[i].sender),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(vm.visibleMessages[i].message,maxLines: 3,overflow: .ellipsis,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(vm.visibleMessages[i].tags??""),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(vm.visibleMessages[i].response??"",maxLines: 3,overflow: .ellipsis,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(

                        children: [
                          SvgPicture.asset(
                              height: 25,
                              width: 25,
                              true?"resources/svgs/complete.svg":"resources/svgs/system-pending.svg"),
                          Text(true?"Complete":"Pending",),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(timeAgo(vm.visibleMessages[i].timestamp)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                          height: 35,
                          width: 35,
                          "resources/svgs/open.svg"),
                    ),
                  ],
                ),
            ],
          ),
        );
      }
    );
  }
}
