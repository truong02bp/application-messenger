import 'package:flutter/material.dart';

class PopupMenuWidget<T> extends PopupMenuEntry<T> {

  @override
  final Widget child;

  @override
  final double height;

  @override
  bool get enabled => false;

  @override
  _PopupMenuWidgetState createState() => new _PopupMenuWidgetState();

  @override
  bool represents(T? value) {
    // TODO: implement represents
    throw UnimplementedError();
  }

  PopupMenuWidget({required this.child, required this.height});
}

class _PopupMenuWidgetState extends State<PopupMenuWidget> {
  @override
  Widget build(BuildContext context) => widget.child;
}
