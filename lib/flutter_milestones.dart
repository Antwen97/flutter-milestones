library flutter_milestones;

export 'flutter_milestones.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'components/gradient_container.dart';

/// Milestones helps the user to create a timeline representing the
/// milestones of a workflow. It uses [GradientContainer] to generate
/// the points and sub-points. Optimized to use less code as possible
/// it just accept the list of the elements called [items]. Each element can
/// be personalized as user wants. Colors, fontSize and mode described in the
/// [MilestoneElement] docs.

class Milestones extends StatefulWidget {
  ///The list of MilestoneElements
  final List<MilestoneElement> items;

  const Milestones({super.key, required this.items});

  @override
  State<Milestones> createState() => _MilestonesState();
}

class _MilestonesState extends State<Milestones> {
  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items.elementAt(index);
            final defaultGradient = LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [item.milestoneColor, Colors.white],
                stops: const [.5, 1]);
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GradientContainer(
                      label: '',
                      gradient: item.milestoneGradient ?? defaultGradient,
                      size: Size(
                        MediaQuery.of(context).size.width * (5 / 100),
                        MediaQuery.of(context).size.width * (5 / 100),
                      ),
                      gradientOnBorders: !item.reached,
                      child: Visibility(
                        visible: item.milestoneChild != null,
                        child: FittedBox(
                          child: item.milestoneChild ?? Container(),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: index < widget.items.length - 1,
                      child: SizedBox(
                        height: item.verticalDividerLength ??
                            MediaQuery.of(context).size.height *
                                ((item.details.length > 2 ? 23 : 10) / 100),
                        child: VerticalDivider(
                          color:
                              item.reached ? item.milestoneColor : Colors.white,
                          thickness: 1.5,
                        ),
                      ),
                    )
                  ],
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * (80 / 100),
                      maxHeight: MediaQuery.of(context).size.height *
                          ((item.details.length > 2 ? 26 : 13) / 100)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                MediaQuery.of(context).size.width * (2 / 100)),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width *
                                  (65 / 100)),
                          child: AutoSizeText(
                            item.title,
                            maxLines: 1,
                            minFontSize: 5,
                            maxFontSize: item.titleFontSize,
                            style: TextStyle(
                                color: item.labelColor,
                                fontSize: item.titleFontSize),
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height *
                                ((item.details.length > 2 ? 23 : 10) / 100)),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: item.details.length,
                          itemBuilder: (context, subIndex) {
                            final milestoneDetail =
                                item.details.elementAt(subIndex);
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width *
                                      (5 / 100),
                                  top: MediaQuery.of(context).size.height *
                                      (.5 / 100)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: item.details.isNotEmpty,
                                    child: GradientContainer(
                                      label: '',
                                      gradientOnBorders: !milestoneDetail.$1,
                                      gradient: item.milestoneGradient ??
                                          defaultGradient,
                                      size: Size(
                                        MediaQuery.of(context).size.width *
                                            (3 / 100),
                                        MediaQuery.of(context).size.width *
                                            (3 / 100),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          (2 / 100),
                                    ),
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                (65 / 100),
                                      ),
                                      child: AutoSizeText(
                                        milestoneDetail.$2,
                                        minFontSize: 5,
                                        maxFontSize: item.detailsFontSize,
                                        style: TextStyle(
                                          fontSize: item.detailsFontSize,
                                          color: item.labelColor,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      );
}

/// MilestoneElement is the single object representing a point of your milestone
/// timeline. Prams are defined as following:
/// - [title] is the milestone title, displayed with a bigger fontSize and placed near the milestone container;
/// - [titleFontSize] is used to change the default title fontSize
/// - [reached] is the bool param used to fill the Milestone container
/// - [details] defined by a List<(bool, String)> is used to fill or not a sub-point with the indicated label
/// - [labelColor] is used to define the Milestone and its sub-point labels color
/// - [detailsFontSize] is used to override the default detail fontSize
/// - [milestoneColor] is used to override the default color of the milestone. This color is combined with [Colors.white] to define a Linear gradient
/// - [milestoneGradient] is used to override the default gradient of the milestone. If null, the gradient refers to [milestoneColor]
/// - [milestoneChild] is the Widget displayed inside the Milestone Container
/// - [verticalDividerLength] is the height of the verticalDivider that connects Milestones
class MilestoneElement {
  /// - [title] is the milestone title, displayed with a bigger fontSize and placed near the milestone container;
  final String title;

  /// - [titleFontSize] is used to change the default title fontSize
  final double titleFontSize;

  /// - [reached] is the bool param used to fill the Milestone container
  final bool reached;

  /// - [details] defined by a List<(bool, String)> is used to fill or not a sub-point with the indicated label
  final List<(bool, String)> details;

  /// - [labelColor] is used to define the Milestone and its sub-point labels color
  final Color labelColor;

  /// - [detailsFontSize] is used to override the default detail fontSize
  final double detailsFontSize;

  /// - [milestoneColor] is used to override the default color of the milestone. This color is combined with [Colors.white] to define a Linear gradient
  final Color milestoneColor;

  /// - [milestoneGradient] is used to override the default gradient of the milestone. If null, the gradient refers to [milestoneColor]
  final Gradient? milestoneGradient;

  /// - [milestoneChild] is the Widget displayed inside the Milestone Container
  final Widget? milestoneChild;

  /// - [verticalDividerLength] is the height of the verticalDivider that connects Milestones
  final double? verticalDividerLength;

  const MilestoneElement(
      {this.title = '',
      this.titleFontSize = 18,
      this.reached = false,
      this.details = const [],
      this.detailsFontSize = 15,
      this.labelColor = Colors.black,
      this.milestoneColor = Colors.white,
      this.milestoneGradient,
      this.milestoneChild,
      this.verticalDividerLength});
}
