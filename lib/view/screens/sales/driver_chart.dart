import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _BarChart extends StatelessWidget {
  final Map? chart;
  final String? current_chart;
  final int? max_value;
  const _BarChart(this.chart, this.current_chart, this.max_value);

  @override
  Widget build(BuildContext context) {
    print('max_value....${max_value}');
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: double.parse('${max_value}'),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: AppColors.contentColorCyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.contentColorBlue,
      fontWeight: FontWeight.bold,
      fontSize: current_chart == 'Monthly' ? 5.5 : 9,
    );
    String text = '';
    text = chart!.entries.toList()[value.toInt()].key;
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          AppColors.contentColorBlue,
          AppColors.contentColorCyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups {
    int current_index = -1;
    List<BarChartGroupData> list = chart!.entries.toList().map((e) {
      current_index = current_index + 1;
      Map dd = e.value;
      print('${dd.values.first}');
      return BarChartGroupData(
        x: current_index,
        barRods: [
          BarChartRodData(
            toY: double.parse('${dd.values.first ?? 0.0}'),
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      );
    }).toList();
    return list;
  }
}

class DriverChart extends StatefulWidget {
  final Map? chart;
  final String? current_chart;
  const DriverChart({super.key, this.chart, this.current_chart});

  @override
  State<StatefulWidget> createState() => DriverChartState();
}

class DriverChartState extends State<DriverChart> {
  int max_value = 0;
  @override
  void initState() {
    widget.chart!.entries.toList().forEach((element) {
      Map dd = element.value;
      if (dd.values.first != null && max_value < dd.values.first) {
        max_value = dd.values.first;
      }
    });
    max_value = max_value + 200;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      child: _BarChart(widget.chart, widget.current_chart, max_value),
      aspectRatio: 1.6,
    );
  }
}

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}
