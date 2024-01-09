import 'package:flutter/material.dart' hide Text, Scaffold, Icon;
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:line_ui/helpers/extensions.dart';
import '../../components/components.dart';

class TownTellyApp extends StatelessWidget {
  const TownTellyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    final rb = ResponsiveBreakpoints.of(context);

    final double titleSize = switch (rb.breakpoint.name) {
      (DESKTOP) => 5,
      (TABLET) => 3,
      _ => 2,
    };
    final double aboutSize = switch (rb.breakpoint.name) {
      (DESKTOP) => 2,
      (TABLET) => 1.5,
      _ => 1,
    };
    final double functionalityTitleSize = switch (rb.breakpoint.name) {
      (DESKTOP) => 2.5,
      (TABLET) => 2,
      _ => 1.75,
    };

    final Widget welcomeWidget = switch (rb.breakpoint.name) {
      (MOBILE) => Column(
          children: [
            Text(
              title,
              fontSizeFactor: titleSize,
            ),
            Text(
              about,
              fontSizeFactor: aboutSize,
            ),
          ],
        ),
      _ => Padding(
          padding: EdgeInsets.only(top: theme.spacing * 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                flex: 5,
                child: Column(
                  children: [
                    Text(
                      title,
                      fontSizeFactor: titleSize,
                    ),
                    Text(
                      about,
                      fontSizeFactor: aboutSize,
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                flex: 2,
                child: Container(
                  constraints: BoxConstraints.loose(const Size(300, 300)),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Icon(
                      Icons.mobile_friendly,
                      size: 300,
                      color: theme.accentColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    };

    functionalitiesWidgetCreator(FunctionalityDescription functionality) =>
        SwitchContainer(
          strategy: functionality.strategy,
          child: Column(
            children: [
              Text(
                functionality.title,
                fontSizeFactor: functionalityTitleSize,
              ),
              Text(
                functionality.subtitle,
                fontSizeFactor: aboutSize,
              ),
              Spacing.one,
              const Button(
                child: Text('Read More'),
              )
            ],
          ),
        );

    final functionalityBoxes =
        functionalities.map<Widget>((f) => functionalitiesWidgetCreator(f));

    final List<Widget> functionalitySection = switch (rb.breakpoint.name) {
      DESKTOP => [
          GridView.count(
            crossAxisSpacing: theme.spacing * 2,
            mainAxisSpacing: theme.spacing * 2,
            crossAxisCount: 2,
            shrinkWrap:
                true, //This line prevents GridView from occupying as much space as there is.
            physics: const NeverScrollableScrollPhysics(),
            children: functionalityBoxes.toList(),
          )
        ],
      _ => functionalityBoxes.intercalate(Spacing.one).toList(),
    };

    final Widget spacing = switch (rb.breakpoint.name) {
      DESKTOP => Spacing(ratio: 8),
      TABLET => Spacing(ratio: 6),
      _ => Spacing(ratio: 4),
    };

    final TableColumnWidth iconWidth = switch (rb.breakpoint.name) {
      (MOBILE) => FixedColumnWidth(90),
      (TABLET) => FixedColumnWidth(110),
      _ => FixedColumnWidth(140),
    };

    getIconBool(bool active) => active
        ? Padding(
            padding: EdgeInsets.all(theme.spacing),
            child: Icon(Icons.task_alt),
          )
        : Icon(Icons.highlight_off);

    TableRow getTableRow(ServiceComparison sc) => TableRow(
          children: [
            Text(sc.title, fontSizeFactor: aboutSize),
            getIconBool(sc.townTelly),
            getIconBool(sc.tv),
            getIconBool(sc.twitch),
          ],
        );

    final Widget comparisionSection = SwitchContainer(
      strategy: SwitchContainerStrategy.primaryBackgroundTextSwitch,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          0: const IntrinsicColumnWidth(flex: 1),
          1: iconWidth,
          2: iconWidth,
          3: iconWidth,
        },
        children: [
          TableRow(
            children: [
              SizedBox(),
              Text('TownTelly',
                  textAlign: TextAlign.center, fontSizeFactor: aboutSize),
              Padding(
                padding: EdgeInsets.symmetric(vertical: theme.spacing),
                child: Text('TV',
                    textAlign: TextAlign.center, fontSizeFactor: aboutSize),
              ),
              Text('Twitch',
                  textAlign: TextAlign.center, fontSizeFactor: aboutSize),
            ],
          ),
          ...comparisons.map(getTableRow),
        ],
      ),
    );

    return Scaffold(
      title: 'Town Telly',
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: theme.spacing),
        alignment: Alignment.topCenter,
        constraints: BoxConstraints.loose(const Size(960, double.infinity)),
        child: ListView(
          children: [
            welcomeWidget,
            spacing,
            Text(
              'Engage, React, Stay Connected',
              textAlign: TextAlign.center,
              fontSizeFactor: functionalityTitleSize,
            ),
            Spacing.twice,
            ...functionalitySection,
            spacing,
            Text(
              'Your News, Your rules',
              textAlign: TextAlign.center,
              fontSizeFactor: functionalityTitleSize,
            ),
            Spacing.twice,
            comparisionSection,
            Spacing.twice,
          ],
        ),
      ),
    );
  }
}

class FunctionalityDescription {
  const FunctionalityDescription(
      {required this.title,
      required this.subtitle,
      this.strategy = SwitchContainerStrategy.textIsBackground});

  final String title;
  final String subtitle;
  final SwitchContainerStrategy strategy;
}

const List<FunctionalityDescription> functionalities = [
  FunctionalityDescription(
    title: 'Customized Playlists',
    subtitle:
        'Tailor your viewing experience with personalized playlists, curating a collection of your favorite local shows, news segments, and events for a unique and convenient entertainment selection.',
  ),
  FunctionalityDescription(
    title: 'Live Community Events',
    subtitle:
        'Experience real-time local happenings by tuning in to live streams of events ranging from festivals to town hall meetings, fostering a deeper connection with your community.',
    strategy: SwitchContainerStrategy.primaryBackgroundTextSwitch,
  ),
  FunctionalityDescription(
    title: 'Interactive News',
    subtitle:
        'Engage with news that matters to you through interactive features, comment sections, and community forums linked to local stories.',
    strategy: SwitchContainerStrategy.secondaryBackgroundTextSwitch,
  ),
  FunctionalityDescription(
    title: 'Behind-the-Scenes',
    subtitle:
        'Gain exclusive access to backstage content, interviews, and sneak peeks, exploring the creation of your favorite local shows and events.',
    strategy: SwitchContainerStrategy.accentBackgroundTextSwitch,
  ),
];

const String title = "Local Stories Unleashed";

const String about =
    'TownTelly is your premier subscription-based local TV streaming service, dedicated to delivering the heart and soul of your town directly to your screens. Offering a diverse array of locally produced shows, news, events, and exclusive content, TownTelly embraces the unique flavors and stories of your community.';

class ServiceComparison {
  late String title;
  late bool townTelly;
  late bool tv;
  late bool twitch;

  ServiceComparison({
    required this.title,
    required this.townTelly,
    required this.tv,
    required this.twitch,
  });
}

List<ServiceComparison> comparisons = [
  ServiceComparison(
    title: 'Local Creativity and Storytelling',
    townTelly: true,
    tv: false,
    twitch: true,
  ),
  ServiceComparison(
    title: 'Community Connection',
    townTelly: true,
    tv: false,
    twitch: false,
  ),
  ServiceComparison(
    title: 'Personalized Experience',
    townTelly: true,
    tv: false,
    twitch: true,
  ),
  ServiceComparison(
    title: 'Exclusive Insider Access',
    townTelly: true,
    tv: false,
    twitch: false,
  ),
  ServiceComparison(
    title: 'Revenue Streams',
    townTelly: true,
    tv: true,
    twitch: false,
  ),
  ServiceComparison(
    title: 'Ads Control',
    townTelly: true,
    tv: false,
    twitch: true,
  ),
  ServiceComparison(
    title: 'Fair-Revenue Sharing',
    townTelly: true,
    tv: false,
    twitch: false,
  ),
];
