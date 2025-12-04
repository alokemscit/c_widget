

import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CHoverMaskContainer extends StatefulWidget {
  final Widget child;
  final Color? hoverColor;
  final Duration duration;

  const CHoverMaskContainer({
    super.key,
    required this.child,
    this.hoverColor, // light blue overlay
    this.duration = const Duration(milliseconds: 250),
  });

  @override
  // ignore: library_private_types_in_public_api
  _CHoverMaskContainerState createState() => _CHoverMaskContainerState();
}

class _CHoverMaskContainerState extends State<CHoverMaskContainer> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: AnimatedContainer(
        duration: widget.duration,
        curve: Curves.easeOut,
        foregroundDecoration: BoxDecoration(
          color: isHover ? (widget.hoverColor??AppThemeColors.primary(context).withAlpha(5)) : Colors.transparent,
        ),
        child: widget.child,
      ),
    );
  }
}