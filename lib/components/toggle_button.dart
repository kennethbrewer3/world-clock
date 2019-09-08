import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final IconData onIcon;
  final IconData offIcon;
  final Color onColor;
  final Color offColor;
  final Function onAction;
  final Function offAction;

  ToggleButton(
      {this.onIcon,
      this.offIcon,
      this.onColor,
      this.offColor,
      this.onAction,
      this.offAction});

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool _status = false;
  IconData _currentIcon;
  Color _currentColor;

  @override
  void initState() {
    super.initState();
    _status = false;
    _currentIcon = widget.offIcon;
    _currentColor = widget.offColor;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _currentIcon,
        color: _currentColor,
      ),
      onPressed: () {
        setState(() {
          _status = !_status;
          _currentIcon = _status == true ? widget.onIcon : widget.offIcon;
          _currentColor = _status == true ? widget.onColor : widget.offColor;
          _status == true ? widget.onAction() : widget.offAction();
        });
      },
    );
  }
}
