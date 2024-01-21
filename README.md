# Flutter `the line` UI

The line UI is a Components Library for Flutter ecosystem, based on the idea of animating lines, focusing on clean Interfaces where movement is the one who tells the message.  
Preview demo [here](https://briancraig.github.io/line_ui/).  

## TODO

- Add colors for `Spinner`.
- `Button`s disabled state (`onPressed` = null)
- `MultiSelector` with Animations.
- animate `LinearInput` Label.
- Create `ToggleButton` with same generation structure as `Button` 
- Add `Snackbar`

## Tech debt

- Refactor `Spinner` impl. 
- `LinearInput` labels, add bottom option, and remove hardcoded `Position` offset.

## Ideas

- Implement a simpler `TweenAnimationBuilder` that does not require a `Tween<PropertyX>` implementation, and just requires a `PropertyX lerp(PropertyX begin, PropertyX end, double t)` function, which starts the tween when the property is changed. This would simplify the unnescesary boilerplate and complexity of creating `Tween` classes for animating properties. can be called `LerpAnimationBuilder`

- Implement a responsive breakpoint system, similar to `responsive-framework`, which takes into account a well defined breakpoint list `T Breakpoint.of(context, RuleList<T> rules)` where T is an enum, and rules is a definition of Breakpoints based on devices sizes. A `BreakpointProvider` should be responsible for ensuring that one Widget could listen to multiple rules at the same time.