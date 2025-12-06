
import 'package:c_widget/const/theme/colors.dart';
import 'package:flutter/material.dart';

import '../c_helper.dart';
class CTool extends StatefulWidget {
  final ToolMenuSet? menu;
  final bool isHovered;
  final bool isDisable;
  final Function()? onTap;
  final bool isShowText;
  final double borderRadius;
  final EdgeInsets pading;

  CTool({
    super.key,
    this.menu,
    this.isHovered = true,
    this.isDisable = false,
    this.onTap,
    this.isShowText = true,
    this.borderRadius = 4,
    this.pading = const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
  });

  @override
  _HoverToolState createState() => _HoverToolState();
}

class _HoverToolState extends State<CTool> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (widget.menu == ToolMenuSet.divider) {
      return _customHorizontalDivider(context);
    }
    if (widget.menu == ToolMenuSet.none) {
      return const SizedBox.shrink();
    }

    // BG colors based on theme + states
    final Color normalBg = colorScheme.surfaceVariant.withOpacity(.1);
    final Color hoverBg = colorScheme.primary.withOpacity(.12);
    final Color disabledBg = colorScheme.surfaceVariant.withOpacity(.5);
    final inputTheme = theme.inputDecorationTheme;
    final sBorder = safeOutlineBorder(context);
    final enabledBorderColor = sBorder.borderSide.color;
    // Icon colors
    final Color iconColor = widget.isDisable
        ? colorScheme.onSurface.withOpacity(.4)
        : colorScheme.secondary;

    // Text colors
    final Color textColor = widget.isDisable
        ? theme.textTheme.bodyMedium!.color!.withOpacity(.4)
        : theme.textTheme.bodyMedium!.color!;

    return MouseRegion(
      onEnter: (_) {
        if (widget.isHovered && !widget.isDisable) {
          setState(() => _isHovered = true);
        }
      },
      onExit: (_) {
        if (widget.isHovered && !widget.isDisable) {
          setState(() => _isHovered = false);
        }
      },
      cursor: widget.isDisable
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (!widget.isDisable) {
            widget.onTap?.call();
          }
        },
        child: AnimatedContainer(
          
        //  height: 22,
          duration: const Duration(milliseconds: 200),
          padding: widget.pading,
          decoration: BoxDecoration(
            color: widget.isDisable
                ? disabledBg
                : _isHovered
                    ? hoverBg
                    : normalBg,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: sBorder.borderSide.width,
              color: widget.isDisable
                  ? enabledBorderColor.withOpacity(.2)
                  : enabledBorderColor.withOpacity(0.2),
            ),
            boxShadow: _isHovered && !widget.isDisable
                ? [
                    BoxShadow(
                      color: AppThemeColors.scaffoldBackground(context),
                      spreadRadius: 0,
                      blurRadius: 3,
                    )
                  ]
                : [BoxShadow(
                      color: AppThemeColors.scaffoldBackground(context),
                      spreadRadius: 0,
                      blurRadius: 1.5,
                    )],
          ),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                _getIcon(widget.menu!),
                size: (theme.textTheme.bodyLarge?.fontSize ?? 16) * 1.6,
                color: (_isHovered && !widget.isDisable)
                    ? iconColor
                    : widget.isDisable
                        ? textColor
                        : colorScheme.primary,
              ),
              if (widget.isShowText && _getText(widget.menu!) != '')
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(
                    _getText(widget.menu!),
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: textColor,
                      fontSize:
                          (theme.textTheme.bodySmall!.fontSize ?? 9.4) * .9,
                      fontWeight: _isHovered && !widget.isDisable
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ToolMenuSet {
  file,
  save,
  update,
  delete,
  edit,
  close,
  show,
  print,
  search,
  undo,
  divider,
  none,
  approve,
  cancel,
  post,
  export,
  exit
}

IconData _getIcon(ToolMenuSet toolMenuSet) {
  switch (toolMenuSet) {
    case ToolMenuSet.save:
      return Icons.save;
    case ToolMenuSet.update:
      return Icons.update;
    case ToolMenuSet.delete:
      return Icons.delete;
    case ToolMenuSet.edit:
      return Icons.edit;
    case ToolMenuSet.close:
      return Icons.close;
    case ToolMenuSet.show:
      return Icons.visibility;
    case ToolMenuSet.print:
      return Icons.print;
    case ToolMenuSet.search:
      return Icons.search;
    case ToolMenuSet.file:
      return Icons.file_copy_sharp;
    case ToolMenuSet.undo:
      return Icons.undo;
    case ToolMenuSet.approve:
      return Icons.approval;
    case ToolMenuSet.post:
      return Icons.post_add;
    case ToolMenuSet.cancel:
      return Icons.cancel_rounded;
    case ToolMenuSet.export:
      return Icons.download;
    case ToolMenuSet.exit:
      return Icons.close;

    default:
      return Icons.help_outline; // Default icon
  }
}

// Function to map enum to text
String _getText(ToolMenuSet toolMenuSet) {
  switch (toolMenuSet) {
    case ToolMenuSet.save:
      return 'Save';
    case ToolMenuSet.update:
      return 'Update';
    case ToolMenuSet.delete:
      return 'Delete';
    case ToolMenuSet.edit:
      return 'Edit';
    case ToolMenuSet.close:
      return 'Close';
    case ToolMenuSet.show:
      return 'Show';
    case ToolMenuSet.print:
      return 'Print';
    case ToolMenuSet.search:
      return 'Search';
    case ToolMenuSet.file:
      return 'New';
    case ToolMenuSet.undo:
      return 'Undo';
    case ToolMenuSet.approve:
      return 'Approve';
    case ToolMenuSet.post:
      return 'Post';
    case ToolMenuSet.export:
      return 'Export';
    case ToolMenuSet.cancel:
      return 'Cancel';

    default:
      return ''; // Default text
  }
}

Widget _customHorizontalDivider(
  BuildContext context, [
  double height = 18,
]) {
  Color color =   Theme.of(context).colorScheme.secondary;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5.2, vertical: 2),
    child: Container(
      height: height,
      width: 0.7,
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
      ),
    ),
  );
}
