import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

enum ButtonVariant { primary, secondary }

enum ButtonIconPosition { left, right }

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final ButtonVariant variant;
  final ButtonIconPosition iconPosition;
  final Widget? icon;

  const CustomButton({
    Key? key,
    required this.title,
    this.onTap,
    this.variant = ButtonVariant.primary,
    this.iconPosition = ButtonIconPosition.left,
    this.icon,
  }) : super(key: key);

  Color backgroundColor() {
    if (onTap == null) {
      return secondary;
    }
    switch (variant) {
      case ButtonVariant.primary:
        return primary;
      case ButtonVariant.secondary:
        return Colors.white;
    }
  }

  Color color() {
    if (onTap == null) {
      return const Color(0xffafafaf);
    }

    switch (variant) {
      case ButtonVariant.primary:
        return Colors.white;
      case ButtonVariant.secondary:
        return primary;
    }
  }

  Widget content() {
    final text = Text(
      title,
      style: TextStyle(
        color: color(),
        fontWeight: FontWeight.bold,
      ),
    );

    if (icon == null) {
      return text;
    }

    var widgets = [
      icon!,
      const SizedBox(
        width: 10,
      ),
      text
    ];

    if (iconPosition == ButtonIconPosition.right) {
      widgets = widgets.reversed.toList();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PushableButton(
      child: content(),
      height: buttonHeight,
      elevation: 8,
      backgroundColor: backgroundColor(),
      onPressed: onTap,
    );
  }
}
