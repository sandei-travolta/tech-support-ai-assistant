import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class UrgencyGaugeChart extends StatelessWidget {
  const UrgencyGaugeChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  startDegreeOffset: 180,
                  sectionsSpace: 4,
                  centerSpaceRadius: 70,
                  sections: showingSections(),
                ),
              ),

              // Center Text
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "120",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Total members"),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        legendItem(Colors.green, "Designer", "48 members"),
        legendItem(Colors.blueGrey, "Developer", "27 members"),
        legendItem(Colors.grey.shade300, "Project manager", "18 members"),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        value: 48,
        color: Colors.green,
        radius: 20,
        showTitle: false,
      ),
      PieChartSectionData(
        value: 27,
        color: Colors.blueGrey,
        radius: 20,
        showTitle: false,
      ),
      PieChartSectionData(
        value: 18,
        color: Colors.grey.shade300,
        radius: 20,
        showTitle: false,
      ),
      PieChartSectionData(
        value: 27, // empty filler to complete half circle
        color: Colors.transparent,
        radius: 20,
        showTitle: false,
      ),
    ];
  }

  Widget legendItem(Color color, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(title),
            ],
          ),
          Text(value),
        ],
      ),
    );
  }
}
