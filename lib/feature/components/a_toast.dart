import 'dart:async';
import 'package:doc_test/feature/components/tappable.dart';
import 'package:doc_test/feature/theme/app_theme.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';

class AToast extends StatefulWidget {
  final String title;

  final Function onPress;

  const AToast({
    Key key,
    this.title,
    this.onPress,
  }) : super(key: key);

  @override
  AToastState createState() => AToastState();
}

class AToastState extends State<AToast> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  Timer _timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        if (_animationController.value == 0.0) {
        } else if (_animationController.value == 1.0) {
          startLifecycle();
        }
      } else {
        cancelLifecycle();
      }
    });
    _animationController.forward();
  }

  Future<void> startLifecycle() async {
    if (_timer != null) {
      return;
    }
    _animationController.forward();
    _timer = Timer(Duration(seconds: 5), () {
      _animationController.reverse();
    });
  }

  Future<void> cancelLifecycle() async {
    if (_timer == null) {
      return;
    }
    _timer.cancel();
    _timer = null;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: FractionalTranslation(
            translation: Offset(0.0, -1.0 + _animation.value),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          widget.onPress?.call();
          _animationController.animateTo(0.0);
        },
        onVerticalDragUpdate: (details) {
          final animValueOffset = details.primaryDelta / 300;
          _animationController.value += animValueOffset;
        },
        onVerticalDragEnd: (details) {
          final velocityY = details.velocity.pixelsPerSecond.dy;
          if (velocityY < 300.0 && velocityY > -300.0) {
            if (_animationController.value > 0.5) {
              _animationController.animateTo(1.0);
            } else {
              _animationController.animateTo(0.0);
            }
          } else {
            final rawDuration = 300 - velocityY.abs() ~/ 10;
            final duration = Duration(
              milliseconds: rawDuration < 0.0 ? 100 : rawDuration,
            );
            if (velocityY > 0.0) {
              _animationController.animateTo(1.0, duration: duration);
            } else {
              _animationController.animateTo(0.0, duration: duration);
            }
          }
        },
        onVerticalDragCancel: () {
          if (_animationController.value > 0.5) {
            _animationController.animateTo(1.0);
          } else {
            _animationController.animateTo(0.0);
          }
        },
        child: Container(
          padding: EdgeInsets.only(
            left: 30.0,
            right: 20.0,
            top: 14.0,
            bottom: 14.0,
          ),
          decoration: BoxDecoration(
            color: Thm.of(context).primary,
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (widget.title != null) ...[
                    Expanded(
                      child: Text(
                        widget.title,
                        style: Thm.of(context).ubantu14WhiteNormal,
                      ),
                    ),
                  ],
                  Tappable(
                    padding: EdgeInsets.all(10),
                    onTap: () {
                      _animationController.animateTo(0.0);
                    },
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

void showToast(BuildContext context, AToast toast) {
  final OverlayState overlayState = Overlay.of(context);
  OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(builder: (context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: toast,
    );
  });

  overlayState.insert(overlayEntry);
}
