import 'package:admin_panel/ui/statsPage/view_models/urgencey_chart_model_view.dart';
import 'package:admin_panel/domain/models/urgenceyModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UrgencyGaugeChart extends StatefulWidget {
  const UrgencyGaugeChart({super.key});

  @override
  State<UrgencyGaugeChart> createState() => _UrgencyGaugeChartState();
}

class _UrgencyGaugeChartState extends State<UrgencyGaugeChart> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UrgenceyChartModelView>().fetchUrgencey();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UrgenceyChartModelView>();

    if (vm.isLoading) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    // ---- Extract values from VM ----
    final double low = _value(vm, "low");
    final double medium = _value(vm, "medium");
    final double high =
        _value(vm, "high") + _value(vm, "critical");

    final double total = low + medium + high;

    if (total == 0) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text("No data available")),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 180,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PieChart(
                PieChartData(
                  startDegreeOffset: 180,
                  sectionsSpace: 2,
                  centerSpaceRadius: 60,
                  sections: _buildSections(
                    low: low,
                    medium: medium,
                    high: high,
                  ),
                ),
              ),

              Positioned(
                bottom: 42,
                child: Column(
                  children: [
                    Text(
                      total.toInt().toString(),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Total Requests",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _legendItem(Colors.green, "LOW", low.toInt()),
            _legendItem(Colors.blue, "MEDIUM", medium.toInt()),
            _legendItem(Colors.red, "HIGH", high.toInt()),
          ],
        ),
      ],
    );
  }

  // ---------------- Helpers ----------------

  double _value(UrgenceyChartModelView vm, String key) {
    return vm.urgenceyList
        .firstWhere(
          (e) => e.urgencey == key,
      orElse: () => UrgenceyModel(urgencey: key, f: 0),
    )
        .f
        .toDouble();
  }

  List<PieChartSectionData> _buildSections({
    required double low,
    required double medium,
    required double high,
  }) {
    final visibleTotal = low + medium + high;

    return [
      PieChartSectionData(
        value: low,
        color: Colors.green,
        radius: 18,
        showTitle: false,
      ),
      PieChartSectionData(
        value: medium,
        color: Colors.blue,
        radius: 18,
        showTitle: false,
      ),
      PieChartSectionData(
        value: high,
        color: Colors.red,
        radius: 18,
        showTitle: false,
      ),

      // Invisible half to force gauge shape
      PieChartSectionData(
        value: visibleTotal,
        color: Colors.transparent,
        radius: 18,
        showTitle: false,
      ),
    ];
  }

  Widget _legendItem(Color color, String label, int value) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12)),
            Text(
              value.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }
}
