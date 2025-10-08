import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DeliveryCategoryWidget extends StatelessWidget {
  const DeliveryCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 380,
          height: 350,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Tabs for Bike, Bicycle, Car
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildTransportOption("🚲", "Bike", true),
                  buildTransportOption("🚴", "Bicycle", false),
                  buildTransportOption("🚗", "Car", false),
                ],
              ),
              SizedBox(height: 10),
              // Total deliveries text
              Text(
                "Total 2,450 delivers",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              // Line chart
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        horizontalInterval: 20000,
                        verticalInterval: 1,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey.shade300,
                            strokeWidth: 1,
                          );
                        },
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: Colors.grey.shade300,
                            strokeWidth: 1,
                          );
                        },
                      ),
                      // titlesData: FlTitlesData(
                      //   leftTitles: SideTitles(
                      //     showTitles: true,
                      //     interval: 20000,
                      //     getTextStyles: (context, value) => const TextStyle(
                      //       color: Colors.black54,
                      //       fontSize: 12,
                      //     ),
                      //   ),
                      //   bottomTitles: SideTitles(
                      //     showTitles: true,
                      //     getTitles: (value) {
                      //       const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                      //       return months[value.toInt()];
                      //     },
                      //     getTextStyles: (context, value) => const TextStyle(
                      //       color: Colors.black54,
                      //       fontSize: 12,
                      //     ),
                      //   ),
                      // ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      minX: 0,
                      maxX: 11,
                      minY: 0,
                      maxY: 80000,
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 20000),
                            FlSpot(1, 30000),
                            FlSpot(2, 60000),
                            FlSpot(3, 40000),
                            FlSpot(4, 70000),
                            FlSpot(5, 50000),
                            FlSpot(6, 35000),
                            FlSpot(7, 40000),
                            FlSpot(8, 60000),
                            FlSpot(9, 30000),
                            FlSpot(10, 50000),
                            FlSpot(11, 20000),
                          ],
                          isCurved: true,
                          // colors: [Colors.purple],
                          barWidth: 4,
                          isStrokeCapRound: true,
                          belowBarData: BarAreaData(
                            show: true,
                            // colors: [
                            //   Colors.purple.withValues(alpha: 0.1),
                            // ],
                          ),
                          dotData: FlDotData(show: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTransportOption(String icon, String title, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(
            icon,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.purple : Colors.black54,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 20,
              color: Colors.purple,
            ),
        ],
      ),
    );
  }
}
