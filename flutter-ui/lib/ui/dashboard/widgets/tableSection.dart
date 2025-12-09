import 'package:flutter/material.dart';

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
          1: FixedColumnWidth(250),
          2: FixedColumnWidth(100),
          3:FixedColumnWidth(330),
          4:FlexColumnWidth(),
          5:FlexColumnWidth()
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          // Table header
          TableRow(
            decoration: BoxDecoration(color: Colors.blueGrey.shade100),
            children: const [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Sender',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Message',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'category',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Response',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Status',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'TimeStamp',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          // Data rows
          for (int i = 0; i < data.length; i++)
            TableRow(
              decoration: BoxDecoration(
                color: i.isEven ? Colors.grey.shade100 : Colors.white,
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
                  child: Text("Complete",),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(TimeOfDay.now().format(context).toString()),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
String loremIpsum="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam rhoncus pellentesque ligula, id semper erat. Phasellus non tincidunt turpis, sed elementum diam. Pellentesque malesuada feugiat posuere. Ut non erat in purus condimentum interdum. Cras malesuada nibh at massa auctor auctor. Donec eleifend blandit nisi, sed ullamcorper urna egestas vel. Etiam.";