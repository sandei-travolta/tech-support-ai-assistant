import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TableSection extends StatelessWidget {
  const TableSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final data = [
      ['John Doe', 'My Wifi appears to be down can you check it out for me', 'Network'],
      ['Jane Smith', 'The printer has a paper jam', 'Printer'],
      ['Bob Johnson', 'getting errors after the last update', 'Moderator'],
    ];

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
          for (int i = 0; i < data.length; i++)
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(data[i][0]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(data[i][1]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(data[i][2]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(loremIpsum,maxLines: 3,overflow: .ellipsis,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    
                    children: [
                      SvgPicture.asset(
                          height: 25,
                          width: 25,
                          i.isEven?"resources/svgs/complete.svg":"resources/svgs/system-pending.svg"),
                      Text(i.isEven?"Complete":"Pending",),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(TimeOfDay.now().format(context).toString()),
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
}
String loremIpsum="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam rhoncus pellentesque ligula, id semper erat. Phasellus non tincidunt turpis, sed elementum diam. Pellentesque malesuada feugiat posuere. Ut non erat in purus condimentum interdum. Cras malesuada nibh at massa auctor auctor. Donec eleifend blandit nisi, sed ullamcorper urna egestas vel. Etiam.";