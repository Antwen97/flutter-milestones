# Flutter Milestones

## Introduction

This Package let you create a milestone timeline with gradients points and a list of sub-details where each one can be set as reached/enabled or not. Each milestone can have the same color or a different one. You can custom colors and font sizes as you prefer. Also it's possible to set a Widget as child of the milestone point to include it as shown in the preview.

## Features Preview

![preview](./images/example.png)

## Getting started

### Add dependency

Please check the latest version before installation.
If there is any problem with the new version, please use the previous version

```yaml
dependencies:
  flutter:
    sdk: flutter
  # add flutter_milestones
  flutter_milestones: ^{latest version}
```

## Usage

### Add the following imports to your Dart code

```dart
import 'package:flutter_milestones/flutter_milestones.dart';
```

### Parent Usage

```dart
Milestones(
    items: [],
),
```

### Child Usage Examples

#### 1. Red One

```dart
MilestoneElement(
    reached: true,
    title: 'Title 1',
    details: [
        (true, 'Detail 1'),
        (true, 'Detail 2'),
        (true, 'Detail 3')
    ],
    verticalDividerLength: 100,
    milestoneColor: Colors.red
),
```

![red](./images/milestone_red.png)

### Parent Properties

| Property | Type | Default Value | Description                                       |
|----------|------|---------------|---------------------------------------------------|
| items    | List | *default*     | The list of the MilestoneElement you want to show |

### MilestoneElement Properties

| Property              | Type                 | Default Value | Description                                                                                                                                                                                                               |
|-----------------------|----------------------|---------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| title                 | String               | Empty String  | The title of your Milestone                                                                                                                                                                                               |
| titleFontSize         | double               | 18            | The title font size                                                                                                                                                                                                       |
| reached               | bool                 | false         | The value that represent your milestone is reached or not and will color the container representing it                                                                                                                    |
| details               | List<(bool, String)> | Empty List    | The list representing the sub-points that can be set as reached or not and, in addition, the label to describe the sub-point itself                                                                                       |
| labelColor            | Color                | Colors.black  | the font color of the title and sub-points labels                                                                                                                                                                         |
| milestoneColor        | Color                | Colors.white  | The color of the title and sub-points containers. If specified without specifying the milestoneGradient, this color will be use in a LinearGradient with white Color to determinate the milestone and sub-points gradient |
| milestoneGradient     | Gradient             | null          | The gradient used to color the milestone and sub-points containers. If not specified, will be considered the milestoneColor param                                                                                         |
| milestoneChild        | Widget               | null          | The widget to show inside the milestone container                                                                                                                                                                         |
| verticalDividerLength | double               | null          | The length of each milestone trace to the next one                                                                                                                                                                        |

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
