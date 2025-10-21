import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zcmc_portal/src/today_log/provider/today_log_provider.dart';
import 'package:zcmc_portal/src/geofence/controller/geofence_state.dart';
import 'package:zcmc_portal/src/geofence/provider/geofence_provider.dart';

class Biometric extends ConsumerStatefulWidget {
  const Biometric({super.key});

  @override
  ConsumerState<Biometric> createState() => _BiometricState();
}

class _BiometricState extends ConsumerState<Biometric>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _iconAnimation;
  late Animation<double> _textFadeOut;
  late Animation<double> _textFadeIn;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _iconAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );

    _textFadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    _widthAnimation = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeInOut),
    );

    _textFadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final biometric = ref.watch(todayLogControllerProvider);
    final controller = ref.read(todayLogControllerProvider.notifier);
    final geofenceState = ref.watch(geofenceControllerProvider);

    // Animate button based on authentication
    if (biometric.isAuthenticated &&
        _animController.status != AnimationStatus.completed) {
      _animController.forward();
    } else if (!biometric.isAuthenticated &&
        _animController.status != AnimationStatus.dismissed) {
      _animController.reverse();
    }

    const biometricText = 'Biometric';
    const savedText = 'Saved!';

    final biometricWidth = _measureTextWidth(
      biometricText,
      const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    );

    final savedWidth = _measureTextWidth(
      savedText,
      const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    );

    // Determine button color based on geofence state
    Color buttonColor;
    bool isInside = false;

    if (geofenceState is GeofenceStateSuccess) {
      isInside = geofenceState.geofenceModel.inside;
      buttonColor = isInside ? Colors.green : Colors.grey.shade400;
    } else if (geofenceState is GeofenceStateLoading) {
      buttonColor = Colors.grey.shade300;
    } else if (geofenceState is GeofenceStateError) {
      buttonColor = Colors.grey.shade300;
    } else {
      buttonColor = Colors.grey.shade300;
    }

    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        final currentWidth = biometricWidth +
            (savedWidth - biometricWidth) * _widthAnimation.value +
            22 + // icon width
            8 + // spacing
            30; // padding

        final rightPadding = 15 * (1 - _widthAnimation.value);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: currentWidth,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: (biometric.isAuthenticated ||
                      geofenceState is GeofenceStateLoading ||
                      geofenceState is GeofenceStateError ||
                      !isInside)
                  ? null
                  : () async {
                      await controller.authenticateAndRegisterAttendance();
                    },
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: rightPadding,
                  top: 6,
                  bottom: 6,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Icon
                    SizedBox(
                      width: 22,
                      height: 22,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Opacity(
                            opacity: 1 - _iconAnimation.value,
                            child: Transform.scale(
                              scale: 1 - (_iconAnimation.value * 0.2),
                              child: const Icon(
                                Icons.fingerprint,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: _iconAnimation.value,
                            child: Transform.scale(
                              scale: 0.8 + (_iconAnimation.value * 0.2),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),

                    // Text crossfade
                    Stack(
                      children: [
                        Opacity(
                          opacity: _textFadeOut.value,
                          child: Text(
                            biometricText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: _textFadeIn.value,
                          child: Text(
                            savedText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double _measureTextWidth(String text, TextStyle style) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    return tp.width;
  }
}
