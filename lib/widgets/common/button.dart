import 'package:flutter/material.dart';
import 'package:sign_language_learning/ui/decoration.dart';

const buttonHeight = 50.0;

class PushableButton extends StatefulWidget {
  const PushableButton({
    Key? key,
    this.child,
    required this.backgroundColor,
    required this.height,
    this.elevation = 8.0,
    this.shadow,
    this.onPressed,
  })  : assert(height > 0),
        super(key: key);

  final Widget? child;
  final Color backgroundColor;
  final double height;
  final double elevation;
  final BoxShadow? shadow;
  final VoidCallback? onPressed;

  @override
  _PushableButtonState createState() => _PushableButtonState();
}

class _PushableButtonState extends State<PushableButton> {
  @override
  Widget build(BuildContext context) {
    final totalHeight = widget.height + widget.elevation;
    return SizedBox(
      height: totalHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final hslColor = HSLColor.fromColor(widget.backgroundColor);
          final bottomHslColor =
              hslColor.withLightness(hslColor.lightness - 0.20);
          return GestureDetector(
              onTap: widget.onPressed,
              child: Stack(
                children: [
                  // Draw bottom layer first
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: totalHeight,
                      decoration: BoxDecoration(
                        color: bottomHslColor.toColor(),
                        boxShadow:
                            widget.shadow != null ? [widget.shadow!] : [],
                        borderRadius: BorderRadius.circular(widget.height / 3),
                      ),
                    ),
                  ),
                  // Then top (pushable) layer
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: hslColor.toColor(),
                        borderRadius: BorderRadius.circular(widget.height / 3),
                      ),
                      child: Center(child: widget.child),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color color;
  final Color backgroundColor;

  const CustomButton({
    Key? key,
    required this.title,
    this.color = Colors.white,
    this.backgroundColor = primary,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PushableButton(
      child: Text(
        title,
        style: TextStyle(color: color),
      ),
      height: buttonHeight,
      elevation: 8,
      backgroundColor: backgroundColor,
      onPressed: onTap,
    );
  }
}
