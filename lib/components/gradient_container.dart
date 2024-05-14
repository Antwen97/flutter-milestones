import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class GradientContainer extends StatelessWidget {

  final Gradient gradient;
  final bool gradientOnBorders;
  final Color? color;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final BoxConstraints? constraints;
  final Size? size;
  final bool isExpanded;
  final MainAxisAlignment contentAlignment;
  final EdgeInsetsGeometry padding;
  final String? label;
  final int labelMaxLines;
  final double labelFontSize;
  final Color labelColor;
  final Widget? child;

  const GradientContainer({
    super.key,
    this.gradient = const LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Colors.red,
        Colors.white,
      ],
      stops: [
        .5,
        1
      ]
    ),
    this.gradientOnBorders = false,
    this.color,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.constraints,
    this.size,
    this.isExpanded = false,
    this.contentAlignment = MainAxisAlignment.center,
    this.padding = EdgeInsets.zero,
    this.label,
    this.labelMaxLines = 1,
    this.labelFontSize = 15,
    this.labelColor = Colors.black,
    this.child
  });

  @override
  Widget build(BuildContext context)
    => Container(
      decoration: BoxDecoration(
          color: gradientOnBorders
            ? (color ?? Colors.transparent)
            :  null,
          gradient: !gradientOnBorders && color == null
            ? gradient
            : null,
          border: borderColor != null
            ? Border.all(
              color: borderColor!
            )
            : GradientBoxBorder(
              gradient: gradientOnBorders
                ? gradient
                : const LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                ]
              ),
              width: borderWidth ?? MediaQuery.of(context).size.width * (.3/ 100)
          ),
          borderRadius: borderRadius ?? BorderRadius.circular(50)
      ),
      child: Padding(
        padding: padding,
        child: ConstrainedBox(
          constraints: constraints ?? BoxConstraints(
            minWidth: size?.width ?? 0.0,
            maxWidth: size?.width ?? double.infinity,
            minHeight: size?.height ?? 0.0,
            maxHeight: size?.height ?? double.infinity
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: contentAlignment,
            children: [
              child ?? AutoSizeText(
                label ?? '',
                textAlign: TextAlign.center,
                maxLines: labelMaxLines,
                minFontSize: 5,
                maxFontSize: labelFontSize,
                style: TextStyle(
                  fontSize: labelFontSize,
                  color: labelColor
                ),
              )
            ],
          ),
        ),
      ),
    );

}