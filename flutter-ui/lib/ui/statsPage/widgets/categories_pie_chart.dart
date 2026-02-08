import 'package:admin_panel/domain/models/categoriesModel.dart';
import 'package:admin_panel/ui/statsPage/view_models/pie_chart_model_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import 'indicator.dart';

class CategoriesPieChart extends StatefulWidget {
  const CategoriesPieChart({super.key});

  @override
  State<StatefulWidget> createState() => CategoriesPieChartState();
}

class CategoriesPieChartState extends State<CategoriesPieChart> {
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PieChartModelView>().fetchCategories();
    });
  }

  // Predefined colors for categories (extend as needed)
  final List<Color> sectionColors = [
    AppColors.contentColorBlue,
    AppColors.contentColorYellow,
    AppColors.contentColorPurple,
    AppColors.contentColorGreen,
    Colors.orange,
    Colors.red,
    Colors.teal,
  ];

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PieChartModelView>();
    final categories = vm.categories; // List<CategoriesModel>

    // Calculate total for percentage
    final total = categories.fold<int>(0, (sum, item) => sum + item.f);

    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(categories, total),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          // Dynamic legend with flexible layout
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(categories.length, (i) {
                  final color = sectionColors[i % sectionColors.length];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: color,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            categories[i].category,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(
      List<CategoriesModel> categories, int total) {
    return List.generate(categories.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 18.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      final value = categories[i].f.toDouble();
      final percentage = total > 0 ? (value / total * 100).toStringAsFixed(1) : "0";

      return PieChartSectionData(
        color: sectionColors[i % sectionColors.length],
        value: value,
        title: "$percentage%",
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.mainTextColor1,
          shadows: shadows,
        ),
      );
    });
  }
}