import 'package:admin_panel/ui/statsPage/view_models/requests_model_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/requestGraphModel.dart';


class _BarChart extends StatefulWidget {
  const _BarChart();

  @override
  State<_BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<_BarChart> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RequestsModelView>().fetchRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RequestsModelView>();
    final data = vm.requests; // List<RequestGraphModel>

    if (data.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final maxY = data
        .map((e) => e.requests)
        .reduce((a, b) => a > b ? a : b)
        .toDouble() +
        2;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(.05),
          )
        ],
      ),
      child: BarChart(
        BarChartData(
          maxY: maxY,
          alignment: BarChartAlignment.spaceBetween,
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY / 4,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                strokeWidth: 1,
                color: Colors.grey.withOpacity(.15),
              );
            },
          ),
          barGroups: _buildBarGroups(data),
        ),
        swapAnimationDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(enabled: false);

  List<BarChartGroupData> _buildBarGroups(
      List<RequestGraphModel> data) {
    return List.generate(data.length, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: data[i].requests.toDouble(),
            width: 18,
            borderRadius: BorderRadius.circular(8),
            gradient: _barsGradient,
          ),
        ],
      );
    });
  }

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
    rightTitles:
    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles:
    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );

  LinearGradient get _barsGradient => const LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xff4facfe),
      Color(0xff00f2fe),
    ],
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