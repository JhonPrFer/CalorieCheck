import 'package:flutter/material.dart';

class CaloriesDisplay extends StatefulWidget {
  final int totalCalories;
  final String type;

  const CaloriesDisplay({Key? key, required this.totalCalories, required this.type}) : super(key: key);

  @override
  _CalorieDisplayState createState() => _CalorieDisplayState();
}

class _CalorieDisplayState extends State<CaloriesDisplay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          width: 200, // Largura fixa para o círculo
          height: 200, // Altura fixa para o círculo
          padding: const EdgeInsets.all(20), // Padding interno
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.type == 'GAINED'
                  ? const Color(0xFF4CAF50) // Borda verde
                  : const Color.fromARGB(255, 233, 30, 23), // Borda verde
              width: 4, // Espessura da borda
            ),
            color: Colors.white, // Fundo branco para contraste
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
                  color: Colors.black, // Texto "Hoje" em preto
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
              Text(
                '${widget.type == 'GAINED' ? '+' : '-'}${widget.totalCalories} kcal',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: widget.type == 'GAINED'
                      ? const Color(0xFF4CAF50) // Texto verde se for 'GAINED'
                      : const Color.fromARGB(255, 233, 30, 23), // Texto vermelho se não for 'GAINED'
                  shadows: const [
                    Shadow(
                      offset: Offset(1.4, 1.4),
                      blurRadius: 3.0,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
