import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/calculator_theme.dart';

enum TactileButtonVariant {
  numeric,
  operator,
  destructive,
  primaryAction,
  function,
}

class TactileButton extends StatefulWidget {
  final String label;
  final Widget? icon;
  final TactileButtonVariant variant;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final double fontSize;

  const TactileButton({
    super.key,
    required this.label,
    this.icon,
    this.variant = TactileButtonVariant.numeric,
    required this.onTap,
    this.height,
    this.width,
    this.fontSize = 24,
  });

  @override
  State<TactileButton> createState() => _TactileButtonState();
}

class _TactileButtonState extends State<TactileButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 140),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
    HapticFeedback.lightImpact();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  Color _getBackgroundColor() {
    switch (widget.variant) {
      case TactileButtonVariant.numeric:
        return StitchColors.surfaceContainerLowest; // #FFFFFF
      case TactileButtonVariant.operator:
        return StitchColors.primaryFixed; // #E2DFFF
      case TactileButtonVariant.destructive:
        return StitchColors.tertiaryFixed; // #FFDADB
      case TactileButtonVariant.primaryAction:
        return StitchColors.primary; // #3525CD
      case TactileButtonVariant.function:
        return StitchColors.surfaceContainerHigh; // #E2E7FF
    }
  }

  Color _getTextColor() {
    switch (widget.variant) {
      case TactileButtonVariant.numeric:
        return StitchColors.onSurface; // #131B2E
      case TactileButtonVariant.operator:
        return StitchColors.primary; // #3525CD
      case TactileButtonVariant.destructive:
        return StitchColors.onTertiaryFixedVariant; // #92002A
      case TactileButtonVariant.primaryAction:
        return StitchColors.onPrimary; // #FFFFFF
      case TactileButtonVariant.function:
        return StitchColors.onSurface; // #131B2E
    }
  }

  List<BoxShadow> _getShadows() {
    if (_isPressed) {
      return widget.variant == TactileButtonVariant.primaryAction
          ? StitchColors.primaryCtaPressedShadow
          : StitchColors.pressedKeyShadow;
    }
    switch (widget.variant) {
      case TactileButtonVariant.primaryAction:
        return StitchColors.primaryCtaShadow;
      case TactileButtonVariant.operator:
        return StitchColors.operatorKeyShadow;
      case TactileButtonVariant.destructive:
      case TactileButtonVariant.function:
      case TactileButtonVariant.numeric:
        return StitchColors.restingKeyShadow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _getBackgroundColor();
    final textColor = _getTextColor();
    final shadows = _getShadows();

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: widget.height ?? 64,
          width: widget.width,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: shadows,
            border: Border.all(
              color: const Color.fromARGB(165, 255, 255, 255),
              width: 1.0,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Highlight reflex at top
              Positioned(
                top: 0,
                left: 12,
                right: 12,
                height: 1,
                child: Container(
                  color: const Color.fromARGB(178, 255, 255, 255),
                ),
              ),
              widget.icon ??
                  Text(
                    widget.label,
                    style: StitchTypography.keypadLabel(color: textColor).copyWith(
                      fontSize: widget.fontSize,
                      fontWeight: widget.variant == TactileButtonVariant.primaryAction ||
                              widget.variant == TactileButtonVariant.destructive
                          ? FontWeight.bold
                          : FontWeight.w600,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
