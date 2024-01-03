// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_theme.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LineThemeCWProxy {
  LineTheme textColor(Color textColor);

  LineTheme backgroundColor(Color backgroundColor);

  LineTheme primaryColor(Color primaryColor);

  LineTheme secondaryColor(Color secondaryColor);

  LineTheme accentColor(Color accentColor);

  LineTheme lineWidth(double lineWidth);

  LineTheme spacing(double spacing);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LineTheme(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LineTheme(...).copyWith(id: 12, name: "My name")
  /// ````
  LineTheme call({
    Color? textColor,
    Color? backgroundColor,
    Color? primaryColor,
    Color? secondaryColor,
    Color? accentColor,
    double? lineWidth,
    double? spacing,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLineTheme.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLineTheme.copyWith.fieldName(...)`
class _$LineThemeCWProxyImpl implements _$LineThemeCWProxy {
  const _$LineThemeCWProxyImpl(this._value);

  final LineTheme _value;

  @override
  LineTheme textColor(Color textColor) => this(textColor: textColor);

  @override
  LineTheme backgroundColor(Color backgroundColor) =>
      this(backgroundColor: backgroundColor);

  @override
  LineTheme primaryColor(Color primaryColor) =>
      this(primaryColor: primaryColor);

  @override
  LineTheme secondaryColor(Color secondaryColor) =>
      this(secondaryColor: secondaryColor);

  @override
  LineTheme accentColor(Color accentColor) => this(accentColor: accentColor);

  @override
  LineTheme lineWidth(double lineWidth) => this(lineWidth: lineWidth);

  @override
  LineTheme spacing(double spacing) => this(spacing: spacing);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LineTheme(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LineTheme(...).copyWith(id: 12, name: "My name")
  /// ````
  LineTheme call({
    Object? textColor = const $CopyWithPlaceholder(),
    Object? backgroundColor = const $CopyWithPlaceholder(),
    Object? primaryColor = const $CopyWithPlaceholder(),
    Object? secondaryColor = const $CopyWithPlaceholder(),
    Object? accentColor = const $CopyWithPlaceholder(),
    Object? lineWidth = const $CopyWithPlaceholder(),
    Object? spacing = const $CopyWithPlaceholder(),
  }) {
    return LineTheme(
      textColor: textColor == const $CopyWithPlaceholder() || textColor == null
          ? _value.textColor
          // ignore: cast_nullable_to_non_nullable
          : textColor as Color,
      backgroundColor: backgroundColor == const $CopyWithPlaceholder() ||
              backgroundColor == null
          ? _value.backgroundColor
          // ignore: cast_nullable_to_non_nullable
          : backgroundColor as Color,
      primaryColor:
          primaryColor == const $CopyWithPlaceholder() || primaryColor == null
              ? _value.primaryColor
              // ignore: cast_nullable_to_non_nullable
              : primaryColor as Color,
      secondaryColor: secondaryColor == const $CopyWithPlaceholder() ||
              secondaryColor == null
          ? _value.secondaryColor
          // ignore: cast_nullable_to_non_nullable
          : secondaryColor as Color,
      accentColor:
          accentColor == const $CopyWithPlaceholder() || accentColor == null
              ? _value.accentColor
              // ignore: cast_nullable_to_non_nullable
              : accentColor as Color,
      lineWidth: lineWidth == const $CopyWithPlaceholder() || lineWidth == null
          ? _value.lineWidth
          // ignore: cast_nullable_to_non_nullable
          : lineWidth as double,
      spacing: spacing == const $CopyWithPlaceholder() || spacing == null
          ? _value.spacing
          // ignore: cast_nullable_to_non_nullable
          : spacing as double,
    );
  }
}

extension $LineThemeCopyWith on LineTheme {
  /// Returns a callable class that can be used as follows: `instanceOfLineTheme.copyWith(...)` or like so:`instanceOfLineTheme.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LineThemeCWProxy get copyWith => _$LineThemeCWProxyImpl(this);
}
