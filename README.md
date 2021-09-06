# Figma Squircle

![image](https://github.com/aloisdeniel/figma_squircle/raw/main/image.png)

Flutter implementation of Figma's corner smoothing.

## Usage

### Decoration

The `SmoothRectangleBorder` can be provided to a regular `ShapeDecoration` with a custom `SmoothBorderRadius`.

```dart
Container(
    height: 100,
    width: 100,
    decoration: ShapeDecoration(
        color: Colors.red.withOpacity(0.75),
        shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 10,
              cornerSmoothing: 0.5,
            ),
        ),
    ),
)
```

### Only

Each corner can have an independent smoothing and radius.

```dart
SmoothBorderRadius.only(
    topLeft: SmoothRadius(
        cornerRadius: 10,
        cornerSmoothing: 1,
    ),
    topRight: SmoothRadius(
        cornerRadius: 20,
        cornerSmoothing: 0.4,
    ),
    bottomLeft: SmoothRadius(
        cornerRadius: 5,
        cornerSmoothing: 0.8,
    ),
    bottomRight: SmoothRadius(
        cornerRadius: 30,
        cornerSmoothing: 0.6,
    ),
),
```

### Clip

To clip any widget with a smooth rectangle, use the `ClipSmoothRect`.

```dart
ClipSmoothRect(
    radius: SmoothBorderRadius(
        cornerRadius: 10,
        cornerSmoothing: 1,
    ),
    child: Container(
        color: Colors.red,
        width: 100,
        height: 100,
    ),
)
```


## Thanks

* [tienphaw/figma-squircle](https://github.com/tienphaw/figma-squircle)'s React Native implementation
* Figma team for publishing [this article](https://www.figma.com/blog/desperately-seeking-squircles/) and [MartinRGB](https://github.com/MartinRGB) for [figuring out all the math](https://github.com/MartinRGB/Figma_Squircles_Approximation) behind it.
* [George Francis](https://github.com/georgedoescode) for creating [Squircley](https://squircley.app/), which was my introduction to squircles.