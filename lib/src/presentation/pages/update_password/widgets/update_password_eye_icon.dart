import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';

class UpdatePasswordEycIcon extends StatefulWidget {
  const UpdatePasswordEycIcon({
    Key? key,
    required this.name,
    required this.visible,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final bool visible;
  final Function() onTap;

  @override
  _UpdatePasswordEycIconState createState() => _UpdatePasswordEycIconState();
}

class _UpdatePasswordEycIconState extends State<UpdatePasswordEycIcon> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: widget.visible
          ? Icon(Icons.visibility_off, color: AppTheme.black40)
          : Icon(Icons.visibility, color: AppTheme.black40),
    );
  }
}
