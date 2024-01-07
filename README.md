# Flutter `the line` UI

The line UI is a Components Library for Flutter ecosystem, based on the idea of animating lines, focusing on clean Interfaces where movement is the one who tells the message.  
Preview demo [here](https://briancraig.github.io/line_ui/).  

## TODO

- `LinearInput` Demo with play stop animation
- Add colors for `Spinner``.
- `Button`s disabled state (`onPressed` = null)
- `MultiSelector`
- `LineTheme` into interface, mopve logic to `BasicLineTheme` implements `LineTheme` 
- `LineThemeTransition` implements `LineTheme`, for transistions between `LineTheme`s. 
- Animations on `SingleSelector` and `MultiSelector`.

## Tech debt

- Refactor `Spinner` impl. 
- Review `Button`s animations design & colors, fix color memoization.