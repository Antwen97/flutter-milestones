library flutter_milestones;
export 'flutter_milestones.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'components/gradient_container.dart';

class Milestones extends StatefulWidget {

  final List<MilestoneElement> items;

  const Milestones({
    super.key,
    required this.items
  });

  @override
  State<Milestones> createState() => _MilestonesState();
}

class _MilestonesState extends State<Milestones> {

  @override
  Widget build(BuildContext context)
    => ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items.elementAt(index);
          final defaultGradient = LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                item.milestoneColor,
                Colors.white
              ],
              stops: const [.5, 1]
          );
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
                      MediaQuery.of(context).size.width * (5/ 100),
                      MediaQuery.of(context).size.width * (5/ 100),
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
                    visible: index < widget.items.length -1,
                    child: SizedBox(
                      height: item.verticalDividerLength ?? MediaQuery.of(context).size.height * ((item.details.length > 2 ? 23 : 10) / 100),
                      child: VerticalDivider(
                        color: item.reached
                          ? item.milestoneColor
                          : Colors.white,
                        thickness: 1.5,
                      ),
                    ),
                  )
                ],
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * (80/ 100),
                  maxHeight: MediaQuery.of(context).size.height * ((item.details.length > 2 ? 26 : 13) / 100)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * (2/ 100)
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * (65/ 100)
                        ),
                        child: AutoSizeText(
                          item.title,
                          maxLines: 1,
                          minFontSize: 5,
                          maxFontSize: item.titleFontSize,
                          style: TextStyle(
                              color: item.labelColor,
                              fontSize: item.titleFontSize
                          ),
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * ((item.details.length > 2 ? 23 : 10) / 100)
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: item.details.length,
                        itemBuilder: (context, subIndex) {
                          final milestoneDetail = item.details.elementAt(subIndex);
                          return Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * (5/ 100),
                              top: MediaQuery.of(context).size.height * (.5/ 100)
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: item.details.isNotEmpty,
                                  child: GradientContainer(
                                    label: '',
                                    gradientOnBorders: !milestoneDetail.$1,
                                    gradient:item.milestoneGradient ?? defaultGradient,
                                    size: Size(
                                      MediaQuery.of(context).size.width * (3/ 100),
                                      MediaQuery.of(context).size.width * (3/ 100),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width * (2/ 100),
                                  ),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * (65/ 100),
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

class MilestoneElement {

  final String title;
  final double titleFontSize;
  final bool reached;
  final List<(bool, String)> details;
  final Color labelColor;
  final double detailsFontSize;
  final Color milestoneColor;
  final Gradient? milestoneGradient;
  final Widget? milestoneChild;
  final double? verticalDividerLength;

  const MilestoneElement({
    this.title = '',
    this.titleFontSize = 18,
    this.reached = false,
    this.details = const [],
    this.detailsFontSize = 15,
    this.labelColor = Colors.black,
    this.milestoneColor = Colors.white,
    this.milestoneGradient,
    this.milestoneChild,
    this.verticalDividerLength
  });
}