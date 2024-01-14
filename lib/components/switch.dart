import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart' hide Icon, Text;

import 'package:line_ui/components/components.dart';

class Switch extends StatelessWidget {
  const Switch({super.key, required this.value, this.onChange});

  final bool value;
  final void Function(bool value)? onChange;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (onChange != null) onChange!(!value);
        },
        child: RoundedContainer(
          child: Icon(value ? Icons.power : Icons.abc),
        ),
      ),
    );
  }
}
