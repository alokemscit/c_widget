import 'package:flutter/material.dart';
import '../theme/colors.dart';
class CTabButton extends StatefulWidget {
  final bool isCrossButton;
  final String text;
  final Function() buttonClick;
  final Function() crossButtonClick;
  final Color? color;
  final Color? textColor;
  final bool isSelected;

  const CTabButton({
    super.key,
    required this.isCrossButton,
    required this.text,
    required this.buttonClick,
    required this.crossButtonClick,
    this.color,
    this.isSelected = false,
    this.textColor,
  });

  @override
  State<CTabButton> createState() => _CTabButtonState();
}

class _CTabButtonState extends State<CTabButton> {
  bool isHover = false;
  bool isCrossHover = false;

  @override
  Widget build(BuildContext context) {
    AppThemeColors theme = AppThemeColors(context);

    final enabledBorderColor = theme.borderColor;

    // ---- SAME COLOR LOGIC AS CustomTool ----

    // BG Colors
    final Color normalBg = theme.normalBg;
    final Color hoverBg = theme.hoverBg;
    final Color selectedBg = theme.selectedBg;

    // Text Colors
    final Color normalText = theme.normalText;
    final Color hoverText = theme.hoverText;

    // Cross Button Colors
    final Color crossNormal = theme.crossNormal;
    final Color crossHover = theme.crossHover;

    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: AnimatedContainer(
        height: 22,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.only(left: 6, right: 2, top: 1, bottom: 1),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? selectedBg
              : isHover
                  ? hoverBg
                  : normalBg,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          border: Border.all(
            width: AppThemeColors.borderWidth(context),
            color: enabledBorderColor,
          ),
          boxShadow: isHover && !widget.isSelected
              ? [
                  BoxShadow(
                    color: AppThemeColors.secondary(context).withOpacity(.15),
                    spreadRadius: -3,
                    blurRadius: 3,
                  )
                ]
              : widget.isSelected?[BoxShadow(
                    color: AppThemeColors.secondary(context).withOpacity(.05),
                    spreadRadius: 0,
                    blurRadius: 0,
                  )]: [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // MAIN TEXT
            InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: widget.buttonClick,
              child: Text(
                widget.text,
                style: AppThemeColors.bodySmall(context).copyWith(
                  fontSize:
                      (AppThemeColors.bodySmall(context).fontSize ?? 9.5) * .92,
                  fontWeight: isHover || widget.isSelected ? FontWeight.bold : FontWeight.w600,
                  color: isHover ? hoverText : normalText,
                ),
              ),
            ),

            // CROSS BUTTON
            if (widget.isCrossButton)
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: MouseRegion(
                  onEnter: (_) => setState(() => isCrossHover = true),
                  onExit: (_) => setState(() => isCrossHover = false),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    hoverColor: Colors.transparent,
                    // splashColor:  Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: widget.crossButtonClick,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.close_outlined,
                        size:
                            (AppThemeColors.bodyLarge(context).fontSize ?? 14) *
                                1.4,
                        color: isCrossHover ? crossHover : crossNormal,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
