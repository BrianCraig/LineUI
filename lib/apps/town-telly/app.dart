import 'package:flutter/material.dart' hide Text, Scaffold;
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:test_app/helpers/extensions.dart';
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
      (DESKTOP) => 3.5,
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
            Spacing.twice,
            ...functionalities
                .map<Widget>((f) => functionalitiesWidgetCreator(f))
                .intercalate(Spacing.one),
          ],
        ),
      ),
    );
  }
}

class FunctionalityDescription {
  const FunctionalityDescription({required this.title, required this.subtitle});

  final String title;
  final String subtitle;
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
  ),
  FunctionalityDescription(
    title: 'Interactive Neighborhood News',
    subtitle:
        'Engage with news that matters to you through interactive features, comment sections, and community forums linked to local stories, encouraging dialogue among residents.',
  ),
  FunctionalityDescription(
    title: 'Exclusive Behind-the-Scenes',
    subtitle:
        'Gain exclusive access to backstage content, interviews, and sneak peeks, exploring the creation of your favorite local shows and events.',
  ),
];

const String title = "Local Stories Unleashed";

const String about =
    'TownTelly is your premier subscription-based local TV streaming service, dedicated to delivering the heart and soul of your town directly to your screens. Offering a diverse array of locally produced shows, news, events, and exclusive content, TownTelly is the go-to platform for embracing the unique flavors and stories of your community.';
