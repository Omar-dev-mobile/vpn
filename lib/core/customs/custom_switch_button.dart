import 'package:flutter/material.dart';
import 'package:vpn/core/theme/theme.dart';

class AnimatedToggleSwitch extends StatefulWidget {
  final bool isOn;
  final ValueChanged<bool> onToggle;

  const AnimatedToggleSwitch({
    super.key,
    required this.isOn,
    required this.onToggle,
  });

  @override
  _AnimatedToggleSwitchState createState() => _AnimatedToggleSwitchState();
}

class _AnimatedToggleSwitchState extends State<AnimatedToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          widget.onToggle(!widget.isOn);
        },
        child: Stack(
          alignment: widget.isOn ? Alignment.centerRight : Alignment.centerLeft,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 40,
              height: 16,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isOn ? kPrimary : kShadeOfGray,
              ),
              alignment:
                  widget.isOn ? Alignment.centerRight : Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 5),
            ),
          ],
        ),
      ),
    );
  }
}
