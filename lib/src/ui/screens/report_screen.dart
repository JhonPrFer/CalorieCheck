import 'dart:developer';

import 'package:CalorieCheck/src/models/water.dart';
import 'package:CalorieCheck/src/providers/water_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../models/exercice.dart';
import '../../models/food.dart';
import '../../providers/exercice_provider.dart';
import '../../providers/food_provider.dart';
import '../../providers/goal_provider.dart';

class ReportScreen extends ConsumerWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodNotifier = ref.watch(foodProvider);
    final exerciceNotifier = ref.watch(exerciceProvider);
    final goalNotifier = ref.watch(goalProvider);
    final waterNotifier = ref.watch(waterProvider);

    final todayCaloriesConsumed = ref.read(foodProvider.notifier).getTodayCalories();
    final todayCaloriesBurned = ref.read(exerciceProvider.notifier).getTodayCalories();

    final balance = todayCaloriesConsumed - todayCaloriesBurned;

    final totalGoals = goalNotifier.length;
    final achievedGoals = goalNotifier.where((goal) => goal.achieved ?? false).length;

    final last7DaysCaloriesConsumed = _getLast7DaysCalories(foodNotifier);
    final last7DaysCaloriesBurned = _getLast7DaysCalories(exerciceNotifier);
    final last7DaysWaterConsumed = _getLast7DaysCalories(waterNotifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Relatórios',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBalanceCard(balance),
            const SizedBox(height: 20),
            _buildPieChart(totalGoals, achievedGoals),
            const SizedBox(height: 20),
            _buildBarChart('Calorias consumidas nos últimos 7 dias', last7DaysCaloriesConsumed),
            const SizedBox(height: 20),
            _buildBarChart('Calorias gastas nos últimos 7 dias', last7DaysCaloriesBurned),
            const SizedBox(height: 20),
            _buildBarChart('Água consumida nos últimos 7 dias', last7DaysWaterConsumed),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(int balance) {
    return Card(
      color: balance >= 0 ? const Color(0xFF4CAF50) : const Color(0xFFFF5252),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Balanço de Calorias de Hoje',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '${balance >= 0 ? '+' : '-'}$balance kcal',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(int totalGoals, int achievedGoals) {
    final notAchievedGoals = totalGoals - achievedGoals;

    if (totalGoals == 0) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Metas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sem metas por enquanto',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Metas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: achievedGoals.toDouble(),
                      color: const Color(0xFF4CAF50),
                      title: 'Alcançadas ($achievedGoals)',
                    ),
                    PieChartSectionData(
                      value: (totalGoals - achievedGoals).toDouble(),
                      color: const Color(0xFFFF5252),
                      title: 'Não alcançadas (${notAchievedGoals})',
                    ),
                  ],
                  centerSpaceRadius: 40,
                  sectionsSpace: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart(String title, List<int> data) {
    final allZeroes = data.every((value) => value == 0);

    if (allZeroes) {
      data = List.generate(7, (index) => 0);
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sem dados por enquanto',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    final maxData = data.isNotEmpty ? data.reduce((a, b) => a > b ? a : b) : 1;
    final interval = allZeroes ? 1.0 : (maxData / 4).clamp(1, double.infinity).toDouble();

    log('allZeroes: $allZeroes');
    log('maxData: $maxData');
    log('message: $interval');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: _generateBarGroups(data),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: data.isEmpty
                            ? 1
                            : data.reduce((a, b) => a > b ? a : b) / 4, // Ajuste do intervalo conforme os dados
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          final date = DateTime.now().subtract(Duration(days: 6 - value.toInt()));
                          final dayFormat = DateFormat('dd/MM');
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              dayFormat.format(date),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true, // Exibe as linhas da grade
                    drawVerticalLine: true,
                    horizontalInterval: interval,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups(List<int> data) {
    return List.generate(data.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data[index].toDouble(),
            color: Colors.lightBlueAccent,
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  List<int> _getLast7DaysCalories<T>(List<T> items) {
    final now = DateTime.now();
    return List.generate(7, (index) {
      final day = DateTime(now.year, now.month, now.day - index);
      return items.where((item) {
        DateTime date;
        if (item is Food) {
          date = item.consumedAt;
        } else if (item is Exercice) {
          date = item.executedAt;
        } else if (item is Water) {
          date = item.consumedAt;
        } else {
          throw Exception('Unsupported type');
        }
        return date.year == day.year && date.month == day.month && date.day == day.day;
      }).fold<int>(0, (sum, item) {
        if (item is Food) {
          return sum + item.calories;
        } else if (item is Water) {
          return sum + item.quantity;
        } else if (item is Exercice) {
          return sum + item.calories;
        } else {
          throw Exception('Unsupported type');
        }
      });
    }).reversed.toList(); // Revertendo para mostrar do mais antigo ao mais recente
  }
}
