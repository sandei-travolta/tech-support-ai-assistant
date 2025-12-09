import 'package:flutter/material.dart';
class TableSection extends StatelessWidget {
  const TableSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        border: .all(),
        columnWidths: const<int,TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
          2: FixedColumnWidth(60.0),
        },
      ),
    );
  }
}



