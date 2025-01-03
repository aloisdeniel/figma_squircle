import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

const niceGradient = LinearGradient(
  colors: [
    Color(0xFFFF4286),
    Color(0xFFFF6666),
  ],
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Figma Squircles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Mode> selected = const <Mode>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Center(
            child: Container(
              color: Colors.red,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: ShapeDecoration(
                  color: Colors.blue.withValues(alpha: 0.5),
                  shape: SmoothRectangleBorder(
                    side: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 16,
                      cornerSmoothing: 0.0,
                    ),
                    borderAlign: BorderAlign.outside,
                  ),
                ),
                child: Text('Hello'),
              ),
            ),
          ),
          CompareExample(),
          EditorExample(),
          AnimatedExample(),
          TilesExample(),
          VariationsExample(
            key: Key('Uniform: 10 1'),
            selected: selected,
            onSelected: (selected) => setState(() => this.selected = selected),
            radius: SmoothBorderRadius(
              cornerRadius: 10,
              cornerSmoothing: 1,
            ),
          ),
          VariationsExample(
            key: Key('Uniform: 25 1'),
            selected: selected,
            onSelected: (selected) => setState(() => this.selected = selected),
            radius: SmoothBorderRadius(
              cornerRadius: 25,
              cornerSmoothing: 1,
            ),
          ),
          VariationsExample(
            key: Key('Only-TopRight: 50 1.0'),
            selected: selected,
            onSelected: (selected) => setState(() => this.selected = selected),
            radius: SmoothBorderRadius.only(
              topRight: SmoothRadius(
                cornerRadius: 30,
                cornerSmoothing: 1,
              ),
            ),
          ),
          VariationsExample(
            key: Key('Uniform: 10 0.5'),
            selected: selected,
            onSelected: (selected) => setState(() => this.selected = selected),
            radius: SmoothBorderRadius(
              cornerRadius: 10,
              cornerSmoothing: 0.5,
            ),
          ),
          VariationsExample(
            key: Key('Top: 10 0.5'),
            selected: selected,
            onSelected: (selected) => setState(() => this.selected = selected),
            radius: SmoothBorderRadius.vertical(
              top: SmoothRadius(
                cornerRadius: 10,
                cornerSmoothing: 1,
              ),
            ),
          ),
          VariationsExample(
            key: Key('Bottom: 10 0.5'),
            selected: selected,
            onSelected: (selected) => setState(() => this.selected = selected),
            radius: SmoothBorderRadius.vertical(
              bottom: SmoothRadius(
                cornerRadius: 10,
                cornerSmoothing: 1,
              ),
            ),
          ),
          VariationsExample(
            key: Key('Left: 10 0.5'),
            selected: selected,
            onSelected: (selected) => setState(() => this.selected = selected),
            radius: SmoothBorderRadius.horizontal(
              left: SmoothRadius(
                cornerRadius: 10,
                cornerSmoothing: 1,
              ),
            ),
          ),
          VariationsExample(
            key: Key('Right: 10 0.5'),
            selected: selected,
            onSelected: (selected) => setState(() => this.selected = selected),
            radius: SmoothBorderRadius.horizontal(
              right: SmoothRadius(
                cornerRadius: 10,
                cornerSmoothing: 1,
              ),
            ),
          ),
          VariationsExample(
            key: Key('Only-TopRight: 10 0.5'),
            selected: selected,
            onSelected: (selected) => setState(() => this.selected = selected),
            radius: SmoothBorderRadius.only(
              topRight: SmoothRadius(
                cornerRadius: 10,
                cornerSmoothing: 1,
              ),
            ),
          ),
          VariationsExample(
            key: Key('Only-BottomRight: 10 0.5'),
            selected: selected,
            onSelected: (selected) => setState(() => this.selected = selected),
            radius: SmoothBorderRadius.only(
              bottomRight: SmoothRadius(
                cornerRadius: 10,
                cornerSmoothing: 1,
              ),
            ),
          ),
          VariationsExample(
            key: Key('Only-BottomLeft: 10 0.5'),
            selected: selected,
            onSelected: (selected) => setState(() => this.selected = selected),
            radius: SmoothBorderRadius.only(
              bottomLeft: SmoothRadius(
                cornerRadius: 10,
                cornerSmoothing: 1,
              ),
            ),
          ),
          VariationsExample(
            key: Key('Only-TopLeft: 10 0.5'),
            selected: selected,
            onSelected: (selected) => setState(() => this.selected = selected),
            radius: SmoothBorderRadius.only(
              topLeft: SmoothRadius(
                cornerRadius: 10,
                cornerSmoothing: 1,
              ),
            ),
          ),
          VariationsExample(
            key: Key('Mixed'),
            selected: selected,
            onSelected: (selected) => setState(() => this.selected = selected),
            radius: SmoothBorderRadius.only(
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
          ),
          Center(
            child: ClipSmoothRect(
              radius: SmoothBorderRadius(
                cornerRadius: 10,
                cornerSmoothing: 1,
              ),
              child: Container(
                color: Colors.red,
                width: 100,
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedExample extends StatefulWidget {
  const AnimatedExample({
    Key? key,
  }) : super(key: key);

  @override
  _AnimatedExampleState createState() => _AnimatedExampleState();
}

class _AnimatedExampleState extends State<AnimatedExample> {
  int radius = 0;
  List<SmoothBorderRadius> animateRadius = [
    SmoothBorderRadius(
      cornerRadius: 10,
      cornerSmoothing: 1,
    ),
    SmoothBorderRadius(
      cornerRadius: 50,
      cornerSmoothing: 1,
    ),
    SmoothBorderRadius(
      cornerRadius: 50,
      cornerSmoothing: 0.5,
    ),
    SmoothBorderRadius(
      cornerRadius: 25,
      cornerSmoothing: 0.5,
    ),
    SmoothBorderRadius(
      cornerRadius: 25,
      cornerSmoothing: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.elasticOut,
                height: 200,
                width: 200,
                decoration: ShapeDecoration(
                  gradient: niceGradient,
                  shape: SmoothRectangleBorder(
                    borderRadius: animateRadius[radius],
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                radius = (radius + 1) % animateRadius.length;
              });
            },
            child: Text('${animateRadius[radius]}'),
          )
        ],
      ),
    );
  }
}

class EditorExample extends StatefulWidget {
  const EditorExample({
    Key? key,
  }) : super(key: key);

  @override
  _EditorExampleState createState() => _EditorExampleState();
}

class _EditorExampleState extends State<EditorExample> {
  double cornerRadius = 0;
  double cornerSmoothing = 1.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.elasticOut,
                height: 200,
                width: 200,
                decoration: ShapeDecoration(
                  gradient: niceGradient,
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: cornerRadius,
                      cornerSmoothing: cornerSmoothing,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
              'radius: ${cornerRadius.toStringAsFixed(1)}, smoothing: ${cornerSmoothing.toStringAsFixed(1)}'),
          Slider(
            min: 0,
            max: 300,
            value: cornerRadius,
            onChanged: (v) => setState(() => cornerRadius = v),
          ),
          Slider(
            min: 0,
            max: 1,
            value: cornerSmoothing,
            onChanged: (v) => setState(() => cornerSmoothing = v),
          ),
        ],
      ),
    );
  }
}

class TilesExample extends StatelessWidget {
  const TilesExample({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.all(8),
          height: 100,
          decoration: ShapeDecoration(
            gradient: niceGradient,
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 25,
                cornerSmoothing: 1,
              ),
            ),
          ),
        ),
        for (var i = 0; i < 100; i++)
          Theme(
            data: ThemeData.dark(),
            child: Card(
              child: ListTile(
                title: Text('Tile $i'),
                subtitle: Text(i % 2 == 1 ? 'Circular' : 'Smooth'),
              ),
              shape: i % 2 == 1
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))
                  : SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 25,
                      ),
                    ),
            ),
          )
      ],
    );
  }
}

class CompareExample extends StatelessWidget {
  const CompareExample({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(8),
          width: 200,
          height: 200,
          decoration: ShapeDecoration(
            gradient: niceGradient,
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 25,
                cornerSmoothing: 1,
              ),
            ),
          ),
          child: Center(
            child: Text(
              'Smooth (25,1)',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8),
          width: 200,
          height: 200,
          decoration: ShapeDecoration(
            gradient: niceGradient,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Center(
            child: Text(
              'Continuous (50)',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8),
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            gradient: niceGradient,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              'Circular (25)',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class VariationsExample extends StatelessWidget {
  const VariationsExample({
    Key? key,
    required this.radius,
    required this.selected,
    required this.onSelected,
  }) : super(key: key);

  final List<Mode> selected;
  final SmoothBorderRadius radius;
  final ValueChanged<List<Mode>> onSelected;

  Widget _rectangle() {
    return Container(
      height: 100,
      width: 100,
      color: Colors.blue.withValues(alpha: 0.25),
    );
  }

  Widget _circular() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.75),
        borderRadius: radius,
      ),
    );
  }

  Widget _continuous() {
    return Container(
      height: 100,
      width: 100,
      decoration: ShapeDecoration(
        color: Colors.red.withValues(alpha: 0.75),
        shape: ContinuousRectangleBorder(
          borderRadius: radius,
        ),
      ),
    );
  }

  Widget _smooth() {
    return Container(
      height: 100,
      width: 100,
      decoration: ShapeDecoration(
        color: Colors.red.withValues(alpha: 0.75),
        shape: SmoothRectangleBorder(
          borderRadius: radius,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (selected.contains(Mode.rectangle)) _rectangle(),
              if (selected.contains(Mode.circular)) _circular(),
              if (selected.contains(Mode.continuous)) _continuous(),
              if (selected.contains(Mode.smooth)) _smooth(),
            ],
          ),
        ),
        Wrap(
          children: [
            ModeChip(
              mode: Mode.rectangle,
              selected: selected,
              onSelected: onSelected,
            ),
            ModeChip(
              mode: Mode.circular,
              selected: selected,
              onSelected: onSelected,
            ),
            ModeChip(
              mode: Mode.smooth,
              selected: selected,
              onSelected: onSelected,
            ),
            ModeChip(
              mode: Mode.continuous,
              selected: selected,
              onSelected: onSelected,
            ),
          ],
        )
      ],
    );
  }
}

enum Mode {
  rectangle,
  smooth,
  circular,
  continuous,
}

class ModeChip extends StatelessWidget {
  ModeChip({
    required this.mode,
    required this.selected,
    required this.onSelected,
  }) : super(key: ValueKey(mode));

  final Mode mode;
  final List<Mode> selected;
  final ValueChanged<List<Mode>> onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(mode.toString()),
      selected: selected.contains(mode),
      onSelected: (bool value) {
        onSelected([
          ...selected.where((x) => x != mode),
          if (value) mode,
        ]);
      },
    );
  }
}
