import 'package:flutter/material.dart';
import 'package:app_agenda/util/styles/cs_colors.dart';
import 'package:app_agenda/util/view/view_utils.dart';

class BellNotification extends StatefulWidget {
  const BellNotification({super.key});

  @override
  State<BellNotification> createState() => _BellNotificationState();
}

class _BellNotificationState extends State<BellNotification> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    super.initState();
  }

  void runAnimation() async {
    for (int i = 0; i < 3; i++) {
      await _animationController.forward();
      await _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            RotationTransition(
              turns: Tween(begin: 0.0, end: -.1)
                  .chain(CurveTween(curve: Curves.elasticIn))
                  .animate(_animationController),
              child: const Icon(ViewUtils.defaultNotificationsIcon),
            ),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: CSColors.primarySwatchV2.color,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        onHover: (value) {
          runAnimation();
        });
  }
}
