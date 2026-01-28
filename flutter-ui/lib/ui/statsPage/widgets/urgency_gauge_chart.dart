import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class UrgencyGaugeChart extends StatelessWidget {
  const UrgencyGaugeChart({super.key});

  final double low = 48;
  final double mid = 27;
  final double high = 18;

  @override
  Widget build(BuildContext context) {
    final total = low + mid + high;

    return Column(
      children: [
        SizedBox(
          height: 170,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PieChart(
                PieChartData(
                  startDegreeOffset: 180,
                  sectionsSpace: 2,
                  centerSpaceRadius: 60,
                  sections: _sections(),
                ),
              ),

              Positioned(
                bottom: 40,
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
            legendItem(Colors.green, "LOW", low.toInt()),
            legendItem(Colors.blue, "MID", mid.toInt()),
            legendItem(Colors.red, "HIGH", high.toInt()),
          ],
        )
      ],
    );
  }

  List<PieChartSectionData> _sections() {
    return [
      PieChartSectionData(
        value: low,
        color: Colors.green,
        radius: 18,
        showTitle: false,
      ),
      PieChartSectionData(
        value: mid,
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

      // Invisible half (forces 180° gauge)
      PieChartSectionData(
        value: low + mid + high,
        color: Colors.transparent,
        radius: 18,
        showTitle: false,
      ),
    ];
  }

  Widget legendItem(Color color, String label, int value) {
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
