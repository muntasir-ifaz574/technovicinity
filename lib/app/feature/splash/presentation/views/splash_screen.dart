import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../di.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../../route/app_route.gr.dart';
import '../../../authentication/domain/use_case/check_splash_redirect_use_case.dart';

@RoutePage()
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  // Logo entrance: scale + fade
  late AnimationController _logoController;
  late Animation<double> _logoScale;
  late Animation<double> _logoFade;

  // Subtitle + tagline slide up
  late AnimationController _textController;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;

  // Continuous pulsing ring around logo
  late AnimationController _pulseController;
  late Animation<double> _pulseScale;
  late Animation<double> _pulseOpacity;

  // Rotating outer ring
  late AnimationController _rotateController;

  // Star twinkle
  late AnimationController _twinkleController;

  final List<_StarParticle> _stars = [];

  @override
  void initState() {
    super.initState();

    // ── Generate random star particles
    final rng = math.Random(42);
    for (int i = 0; i < 60; i++) {
      _stars.add(_StarParticle(
        x: rng.nextDouble(),
        y: rng.nextDouble(),
        radius: rng.nextDouble() * 1.8 + 0.4,
        twinkleOffset: rng.nextDouble(),
      ));
    }

    // ── Logo controller: 0–900ms
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoScale = Tween<double>(begin: 0.35, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _logoController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeIn)),
    );

    // ── Text controller: starts 400ms in
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );
    _textSlide =
        Tween<Offset>(begin: const Offset(0.0, 0.18), end: Offset.zero).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );

    // ── Pulse controller: infinite looping
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _pulseScale = Tween<double>(begin: 1.0, end: 1.28).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseOpacity = Tween<double>(begin: 0.35, end: 0.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // ── Rotate controller: slow perpetual spin
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    // ── Twinkle controller: star shimmer
    _twinkleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    // ── Sequence: logo → text → redirect
    _logoController.forward();

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _textController.forward();
    });

    Future.delayed(const Duration(milliseconds: 2800), () async {
      if (!mounted) return;
      final checkRedirect = sl<CheckSplashRedirectUseCase>();
      final result = await checkRedirect(NoParams());

      if (!mounted) return;
      result.fold(
        (failure) => context.router.replace(const SignInRoute()),
        (redirect) {
          switch (redirect) {
            case SplashRedirect.signIn:
              context.router.replace(const SignInRoute());
              break;
            case SplashRedirect.start:
              context.router.replace(const StartRoute());
              break;
            case SplashRedirect.home:
              context.router.replace(const HomeRoute());
              break;
          }
        },
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _pulseController.dispose();
    _rotateController.dispose();
    _twinkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Deep cosmic background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0F0C20), // Dark space black
                  Color(0xFF161233), // Deep midnight blue
                  Color(0xFF1A1040), // Rich cosmic violet
                ],
              ),
            ),
          ),

          // ── Star field
          AnimatedBuilder(
            animation: _twinkleController,
            builder: (context, _) {
              return CustomPaint(
                painter: _StarFieldPainter(
                  stars: _stars,
                  twinkleValue: _twinkleController.value,
                ),
                size: size,
              );
            },
          ),

          // ── Top-right glowing orb (blue)
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0066FF).withValues(alpha: 0.18),
                    blurRadius: 140,
                    spreadRadius: 60,
                  ),
                ],
              ),
            ),
          ),

          // ── Bottom-left glowing orb (amber)
          Positioned(
            bottom: -80,
            left: -60,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7C3AED).withValues(alpha: 0.14),
                    blurRadius: 160,
                    spreadRadius: 60,
                  ),
                ],
              ),
            ),
          ),

          // ── Center content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Logo area
                AnimatedBuilder(
                  animation: Listenable.merge([
                    _logoController,
                    _pulseController,
                    _rotateController,
                  ]),
                  builder: (context, _) {
                    return FadeTransition(
                      opacity: _logoFade,
                      child: ScaleTransition(
                        scale: _logoScale,
                        child: SizedBox(
                          width: 180,
                          height: 180,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Pulsing outer glow ring
                              Transform.scale(
                                scale: _pulseScale.value,
                                child: Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF0066FF).withValues(
                                          alpha: _pulseOpacity.value),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),

                              // Second larger pulsing ring (offset phase)
                              Transform.scale(
                                scale: 1.0 +
                                    (_pulseScale.value - 1.0) * 1.6,
                                child: Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF4364F7).withValues(
                                          alpha: _pulseOpacity.value * 0.5),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),

                              // Rotating dashed arc
                              Transform.rotate(
                                angle: _rotateController.value * 2 * math.pi,
                                child: CustomPaint(
                                  painter: _ArcPainter(),
                                  size: const Size(148, 148),
                                ),
                              ),

                              // Glassmorphic logo circle
                              Container(
                                width: 114,
                                height: 114,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Colors.white.withValues(alpha: 0.04),
                                  border: Border.all(
                                    color:
                                        Colors.white.withValues(alpha: 0.12),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF0066FF)
                                          .withValues(alpha: 0.30),
                                      blurRadius: 30,
                                      spreadRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: ShaderMask(
                                    shaderCallback: (bounds) =>
                                        const LinearGradient(
                                      colors: [
                                        Color(0xFF6FB1FC),
                                        Color(0xFF0066FF),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ).createShader(bounds),
                                    child: const Icon(
                                      Icons.bolt_rounded,
                                      size: 56,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                // ── App name + tagline
                FadeTransition(
                  opacity: _textFade,
                  child: SlideTransition(
                    position: _textSlide,
                    child: Column(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFFFFFFFF), Color(0xFFBBCCFF)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ).createShader(bounds),
                          child: const Text(
                            'Technovicinity',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 72),

                // ── Loading indicator
                FadeTransition(
                  opacity: _textFade,
                  child: _PulsingDots(),
                ),
              ],
            ),
          ),

          // ── Bottom version label
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _textFade,
              child: const Text(
                'v1.0.0',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF44466A),
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _PulsingDots extends StatefulWidget {
  @override
  State<_PulsingDots> createState() => _PulsingDotsState();
}

class _PulsingDotsState extends State<_PulsingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final phase = ((_ctrl.value * 3) - i).clamp(0.0, 1.0);
            final opacity = (math.sin(phase * math.pi)).clamp(0.0, 1.0);
            final scale = 0.6 + opacity * 0.4;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.lerp(
                      const Color(0xFF334488),
                      const Color(0xFF6FB1FC),
                      opacity,
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}


class _StarParticle {
  final double x;
  final double y;
  final double radius;
  final double twinkleOffset;

  const _StarParticle({
    required this.x,
    required this.y,
    required this.radius,
    required this.twinkleOffset,
  });
}

class _StarFieldPainter extends CustomPainter {
  final List<_StarParticle> stars;
  final double twinkleValue;

  const _StarFieldPainter({required this.stars, required this.twinkleValue});

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in stars) {
      final phase = (twinkleValue + star.twinkleOffset) % 1.0;
      final alpha = 0.15 + math.sin(phase * math.pi) * 0.65;
      final paint = Paint()
        ..color = Colors.white.withValues(alpha: alpha.clamp(0.0, 1.0))
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _StarFieldPainter old) =>
      old.twinkleValue != twinkleValue;
}

class _ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..color = const Color(0xFF0066FF).withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    const dashCount = 18;
    const dashAngle = 0.12;
    const gapAngle = (2 * math.pi / dashCount) - dashAngle;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * (dashAngle + gapAngle);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        dashAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}