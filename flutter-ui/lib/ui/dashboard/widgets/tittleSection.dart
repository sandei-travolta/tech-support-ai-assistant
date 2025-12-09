import 'package:flutter/material.dart';

import 'tagWidget.dart';
class TittleSection extends StatelessWidget {
  const TittleSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(
          padding: .only(top:35.0,left:25),
          child: Text("All Conversations".toUpperCase(),style: TextStyle(
              fontSize: 18.0,
              fontWeight: .w600
          ),),
        )),
        Expanded(child: Container(
          padding: .only(right:35.0,top:35.0),
          child: Row(
            mainAxisAlignment: .end,
            spacing: 35.0,
            children: [
              TagWidgets(
                text: 'Refresh',
                asset: 'refresh',),
              TagWidgets(
                  text: 'Filter',
                  asset: 'filter',
                  ),
              TagWidgets(
                  text: 'Date',
                  asset: 'date-range',),
            ],
          ),
        ))
      ],
    );
  }
}
