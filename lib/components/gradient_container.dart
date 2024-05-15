import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

///Gradient Container is a classic container rounded and filled with a gradient color.
///Depending on its params, user can change most of its UI.
///Params are defined as follows:
/// - [gradient] is the main gradient used to fill the container
/// - [gradientOnBorders] is a bool param to move the gradient on borders. If [true] it override the Container background and fill it with a [Colors.transparent] color.
/// - [color] could be used to override the default color of the container. If specified it overrides the gradient in case of [gradientOnBorders] false, otherwise the background color
/// - [borderColor] could be specified to override the borderColor. It overrides the gradient in case of [gradientOnBorders] true, otherwise it colors the Container borders
/// - [borderWidth] the width of the Container borders
/// - [borderRadius] the Radius of Container Borders
/// - [constraints] helps the user to have a dynamical components that respects defined constraints
/// - [size] helps the user to force the Container Size. If specified it overrides [constraints]
/// - [isExpanded] will expand the container in horizontal
/// - [contentAlignment] specifies the content Alignment of the container
/// - [padding] defines the padding between the child/label and the container borders
/// - [label] can be used in case you just want to show a string inside the container. If [child] is not specified and [label] is null, the label default value is set to Empty String
/// - [labelMaxLines] in line with [AutoSizeText] library, you can specify how many lines the label can use before starting reducing its fontSize to adapt the label to the [constraints] or [size]
/// - [labelFontSize] is the fontSize of [label]
/// - [labelColor] is the color of [label]
/// - [child] can be used to override the [label] text widget
class GradientContainer extends StatelessWidget {
  /// [gradient] is the main gradient used to fill the container
  final Gradient gradient;

  /// [gradientOnBorders] is a bool param to move the gradient on borders. If [true] it override the Container background and fill it with a [Colors.transparent] color.
  final bool gradientOnBorders;

  /// [color] could be used to override the default color of the container. If specified it overrides the gradient in case of [gradientOnBorders] false, otherwise the background color
  final Color? color;

  /// [borderColor] could be specified to override the borderColor. It overrides the gradient in case of [gradientOnBorders] true, otherwise it colors the Container borders
  final Color? borderColor;

  /// [borderWidth] the width of the Container borders
  final double? borderWidth;

  /// [borderRadius] the Radius of Container Borders
  final BorderRadius? borderRadius;

  /// [constraints] helps the user to have a dynamical components that respects defined constraints
  final BoxConstraints? constraints;

  /// [size] helps the user to force the Container Size. If specified it overrides [constraints]
  final Size? size;

  /// [isExpanded] will expand the container in horizontal
  final bool isExpanded;

  /// [contentAlignment] specifies the content Alignment of the container
  final MainAxisAlignment contentAlignment;

  /// [padding] defines the padding between the child/label and the container borders
  final EdgeInsetsGeometry padding;

  /// [label] can be used in case you just want to show a string inside the container. If [child] is not specified and [label] is null, the label default value is set to Empty String
  final String? label;

  /// [labelMaxLines] in line with [AutoSizeText] library, you can specify how many lines the label can use before starting reducing its fontSize to adapt the label to the [constraints] or [size]
  final int labelMaxLines;

  /// [labelFontSize] is the fontSize of [label]
  final double labelFontSize;

  /// - [labelColor] is the color of [label]
  final Color labelColor;

  /// - [child] can be used to override the [label] text widget
  final Widget? child;

  const GradientContainer(
      {super.key,
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
          ]),
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
      this.child});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: gradientOnBorders ? (color ?? Colors.transparent) : null,
            gradient: !gradientOnBorders && color == null ? gradient : null,
            border: borderColor != null
                ? Border.all(color: borderColor!)
                : GradientBoxBorder(
                    gradient: gradientOnBorders
                        ? gradient
                        : const LinearGradient(colors: [
                            Colors.transparent,
                            Colors.transparent,
                          ]),
                    width: borderWidth ??
                        MediaQuery.of(context).size.width * (.3 / 100)),
            borderRadius: borderRadius ?? BorderRadius.circular(50)),
        child: Padding(
          padding: padding,
          child: ConstrainedBox(
            constraints: constraints ??
                BoxConstraints(
                    minWidth: size?.width ?? 0.0,
                    maxWidth: size?.width ?? double.infinity,
                    minHeight: size?.height ?? 0.0,
                    maxHeight: size?.height ?? double.infinity),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: contentAlignment,
              children: [
                child ??
                    AutoSizeText(
                      label ?? '',
                      textAlign: TextAlign.center,
                      maxLines: labelMaxLines,
                      minFontSize: 5,
                      maxFontSize: labelFontSize,
                      style:
                          TextStyle(fontSize: labelFontSize, color: labelColor),
                    )
              ],
            ),
          ),
        ),
      );
}
