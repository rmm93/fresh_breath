import 'package:flutter/material.dart';

class AirFirstPage extends StatefulWidget {
  const AirFirstPage({
    Key key,
    this.fromValue = 1,
    @required this.toValue,
    this.duration = const Duration(milliseconds: 1500),
  })  : assert(fromValue != null),
        assert(toValue != null),
        assert(fromValue <= toValue),
        assert(duration != null),
        super(key: key);

  final double fromValue;
  final double toValue;
  final Duration duration;

  @override
  State<StatefulWidget> createState() => _AirFirstPageState();
}

class _AirFirstPageState extends State<AirFirstPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  String _number;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: widget.fromValue, end: widget.toValue)
        .animate(_controller)
          ..addListener(() {
            setState(() {
              _number = _animation.value.toStringAsFixed(0);
            });
          });
    _controller.forward();
  }

  @override
  Future<void> dispose() async {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Text(
        '$_number',
        style: textTheme.headline1.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
