import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

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
          Example(
            key: Key('Uniform: 10 1'),
            selected: selected,
            onSelected: (selected) => setState(() => this.selected = selected),
            radius: SmoothBorderRadius(
              cornerRadius: 10,
              cornerSmoothing: 1,
            ),
          ),
          Example(
            key: Key('Uniform: 10 0.5'),
            selected: selected,
            onSelected: (selected) => setState(() => this.selected = selected),
            radius: SmoothBorderRadius(
              cornerRadius: 10,
              cornerSmoothing: 0.5,
            ),
          ),
          Example(
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
          Example(
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
          Example(
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
          Example(
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
          Example(
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
          Example(
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
          Example(
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
          Example(
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
          Example(
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

class Example extends StatelessWidget {
  const Example({
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
      color: Colors.blue.withOpacity(0.25),
    );
  }

  Widget _circular() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.75),
        borderRadius: radius,
      ),
    );
  }

  Widget _continuous() {
    return Container(
      height: 100,
      width: 100,
      decoration: ShapeDecoration(
        color: Colors.red.withOpacity(0.75),
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
        color: Colors.red.withOpacity(0.75),
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
