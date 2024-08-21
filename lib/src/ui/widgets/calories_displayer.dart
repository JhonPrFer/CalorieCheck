import 'package:flutter/material.dart';
import '../../enums/result_type_enum.dart';

class CaloriesDisplay extends StatelessWidget {
  final int totalCalories;
  final ResultTypeEnum type;

  const CaloriesDisplay({
    Key? key,
    required this.totalCalories,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: type == ResultTypeEnum.gain ? const Color(0xFF4CAF50) : const Color.fromARGB(255, 233, 30, 23),
            width: 4,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hoje',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                shadows: [
                  Shadow(
                    offset: Offset(1.4, 1.4),
                    blurRadius: 3.0,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            FittedBox(
              child: Text(
                '${type == ResultTypeEnum.gain ? '+' : '-'}$totalCalories kcal',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: type == ResultTypeEnum.gain ? const Color(0xFF4CAF50) : const Color.fromARGB(255, 233, 30, 23),
                  shadows: const [
                    Shadow(
                      offset: Offset(1.4, 1.4),
                      blurRadius: 3.0,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
