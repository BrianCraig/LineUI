import 'package:flutter/widgets.dart' hide Text;
import '../../components/components.dart';

class TownTellyApp extends StatelessWidget {
  const TownTellyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = LineTheme.of(context);
    return Scaffold(
      title: 'Town Telly',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: theme.spacing),
        child: Text(about),
      ),
    );
  }
}

const String about =
    'TownTelly is your premier subscription-based local TV streaming service, dedicated to delivering the heart and soul of your town directly to your screens. Offering a diverse array of locally produced shows, news, events, and exclusive content, TownTelly is the go-to platform for embracing the unique flavors and stories of your community.';
