import 'package:flutter/widgets.dart' hide Text;
import 'package:responsive_framework/responsive_breakpoints.dart';
import '../../components/components.dart';

class TownTellyApp extends StatelessWidget {
  const TownTellyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    final rb = ResponsiveBreakpoints.of(context);
    final double titleSize = switch (rb.breakpoint.name) {
      (DESKTOP) => 2,
      (TABLET) => 1.5,
      _ => 1,
    };
    return Scaffold(
      title: 'Town Telly',
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: theme.spacing),
        alignment: Alignment.topCenter,
        constraints: BoxConstraints.loose(const Size(960, double.infinity)),
        child: Text(
          about,
          fontSizeFactor: titleSize,
        ),
      ),
    );
  }
}

const String about =
    'TownTelly is your premier subscription-based local TV streaming service, dedicated to delivering the heart and soul of your town directly to your screens. Offering a diverse array of locally produced shows, news, events, and exclusive content, TownTelly is the go-to platform for embracing the unique flavors and stories of your community.';
