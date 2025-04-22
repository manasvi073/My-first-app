import 'package:flutter/material.dart';
import 'package:scary_teacher2/constant/appappbar.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/models/reward_model.dart';

class SpinDetailsScreen extends StatelessWidget {
  final RewardData rewardData;

  const SpinDetailsScreen({super.key, required this.rewardData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            ImageConstant.appBackground,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 40),
              AppAppbar(
                text: rewardData.categoryName!,
              ),
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  rewardData.categoryImage ?? '',
                  height: 250,
                  width: 250,
                ),
              ),
              const SizedBox(height: 25),
              Image.asset(ImageConstant.appSpinButton)
            ],
          ),
        ],
      ),
    );
  }
}

/*import 'dart:math';
import 'package:flutter/material.dart';

class CharacterSpinnerScreen extends StatefulWidget {
  const CharacterSpinnerScreen({super.key});

  @override
  State<CharacterSpinnerScreen> createState() => _CharacterSpinnerScreenState();
}

class _CharacterSpinnerScreenState extends State<CharacterSpinnerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _angle = 0;

  final List<String> characters = [
    'assets/char1.png',
    'assets/char2.png',
    'assets/char3.png',
    'assets/char4.png',
    'assets/char5.png',
    'assets/char6.png',
    'assets/char7.png',
    'assets/char8.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..addListener(() {
        setState(() {
          _angle = _controller.value * 2 * pi * 4; // 4 full spins
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void spinWheel() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "CHARACTERS",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: _angle,
                    child: CustomPaint(
                      size: Size(size, size),
                      painter: SpinnerPainter(characters: characters),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    child: Icon(Icons.arrow_drop_down, size: 40, color: Colors.white),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: spinWheel,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.orange, Colors.deepOrange],
                  ),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
                ),
                child: const Text(
                  'SPIN NOW',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SpinnerPainter extends CustomPainter {
  final List<String> characters;

  SpinnerPainter({required this.characters});

  @override
  void paint(Canvas canvas, Size size) {
    final angle = 2 * pi / characters.length;
    final radius = size.width / 2;
    final center = Offset(radius, radius);
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < characters.length; i++) {
      paint.color = Colors.primaries[i % Colors.primaries.length].shade300;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), angle * i, angle, true, paint);

      final iconAngle = angle * (i + 0.5);
      final iconX = center.dx + radius / 2 * cos(iconAngle);
      final iconY = center.dy + radius / 2 * sin(iconAngle);
      final imageSize = 40.0;

      final imageRect = Rect.fromCenter(
        center: Offset(iconX, iconY),
        width: imageSize,
        height: imageSize,
      );

      // You can use `ui.Image` for real images, or use image widgets layered with Stack
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
*/
