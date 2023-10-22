import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

///Animated text button
class AnimatedTextButton extends StatefulWidget {
  final Function()? onTap;
  final String buttonText;
  final TextStyle buttonStyle;
  final EdgeInsets? padding;

  const AnimatedTextButton(
      {Key? key,
      required this.onTap,
      required this.buttonText,
      required this.buttonStyle,
      this.padding})
      : super(key: key);

  @override
  State<AnimatedTextButton> createState() => _AnimatedTextButtonState();
}

class _AnimatedTextButtonState extends State<AnimatedTextButton>
    with AnimationMixin<AnimatedTextButton> {
  late TextStyle style;

  @override
  void initState() {
    super.initState();
    style = widget.buttonStyle;
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      style = style.copyWith(color: style.color?.withOpacity(0.4));
    });
  }

  void _onTapUp(TapUpDetails details) {
    Future.delayed(const Duration(milliseconds: 80)).whenComplete(() {
      setState(() {
        style = widget.buttonStyle;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap == null
          ? null
          : () async {
              await Future.delayed(const Duration(milliseconds: 20));
              widget.onTap!.call();
            },
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () {
        setState(() {
          style = widget.buttonStyle;
        });
      },
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: Text(
          widget.buttonText,
          style: style,
        ),
      ),
    );
  }
}
