import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../commons/themes/text_styel.dart';

class OverlaySnackBar extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onDismissed;

  const OverlaySnackBar({
    super.key,
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    required this.onDismissed,
  });

  @override
  State<OverlaySnackBar> createState() => _OverlaySnackBarState();
}

class _OverlaySnackBarState extends State<OverlaySnackBar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: -100, end: 50).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      _controller.reverse().then((_) {
        widget.onDismissed();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          top: _animation.value,
          left: 10,
          right: 10,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.all(12.w),
                child: Text(
                  widget.message,
                  style: whiteTextStyle.copyWith(
                    fontSize: 13.sp,
                    color: widget.textColor,
                    fontWeight: medium,
                    fontFamily: 'Inter',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
