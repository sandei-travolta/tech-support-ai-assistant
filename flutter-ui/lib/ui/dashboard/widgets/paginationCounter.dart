import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/table_view_model.dart';

class PaginationCounter extends StatelessWidget {
  const PaginationCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TableViewModel>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: vm.start == 0 ? null : vm.previousPage,
          icon: const Icon(Icons.arrow_back, size: 15),
        ),

        Text('${vm.currentPage} / ${vm.totalPages}'),

        IconButton(
          onPressed: (vm.start + vm.pageSize >= vm.messages.length)
              ? null
              : vm.nextPage,
          icon: const Icon(Icons.arrow_forward, size: 15),
        ),
      ],
    );
  }
}
