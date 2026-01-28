import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class _BarChart extends StatelessWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 4),
            color: Colors.black.withOpacity(.05),
          )
        ],
      ),
      child: BarChart(
        BarChartData(
          maxY: 20,
          alignment: BarChartAlignment.spaceBetween,
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 5,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                strokeWidth: 1,
                color: Colors.grey.withOpacity(.15),
              );
            },
          ),
          barGroups: barGroups,
        ),
        swapAnimationDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(enabled: false);

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    );

    const labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return SideTitleWidget(
      meta: meta,
      child: Text(labels[value.toInt()], style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 28,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: 5,
        getTitlesWidget: (value, meta) => Text(
          value.toInt().toString(),
          style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
        ),
        reservedSize: 28,
      ),
    ),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );

  LinearGradient get _barsGradient => const LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xff4facfe),
      Color(0xff00f2fe),
    ],
  );

  List<BarChartGroupData> get barGroups => List.generate(
    7,
        (i) => BarChartGroupData(
      x: i,
      barRods: [
        BarChartRodData(
          toY: [8, 10, 14, 15, 13, 10, 16][i].toDouble(),
          width: 18,
          borderRadius: BorderRadius.circular(8),
          gradient: _barsGradient,
        ),
      ],
    ),
  );
}

class RequestsGraph extends StatefulWidget {
  const RequestsGraph({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<RequestsGraph> {
  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 1.6,
      child: _BarChart(),
    );
  }
}