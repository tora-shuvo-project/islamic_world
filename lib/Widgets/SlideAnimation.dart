import 'package:flutter/material.dart';

enum SlideDirection{fromTop,fromLeft,fromRight,fromBottom}

class SlideAnimation extends StatefulWidget {

  final int position;
  final int itemCount;
  final Widget child;
  final SlideDirection singleDirection;
  final AnimationController animationController;

  SlideAnimation({ @required this.position,
    @required this.itemCount,
    @required this.child,
    @required this.singleDirection ,
    @required this.animationController});

  @override
  _SlideAnimationState createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation> {



  @override
  Widget build(BuildContext context) {
    var _xDirection=8.8, _yDirection=8.8;

    var _animation = Tween(begin: 0.0,end: 1.0).animate(
      CurvedAnimation(parent: widget.animationController,
          curve: Interval((1/ widget.itemCount)* widget.position,1.0, curve: Curves.fastLinearToSlowEaseIn)),
    );
    return AnimatedBuilder(
        animation: widget.animationController,
      builder: (context, child){

          if(widget.singleDirection==SlideDirection.fromTop){
            _yDirection=-58*(1.0-_animation.value);
          }else if(widget.singleDirection==SlideDirection.fromBottom){
            _yDirection= 58*(1.0-_animation.value);
          }else if(widget.singleDirection==SlideDirection.fromRight){
            _yDirection= 488*(1.0-_animation.value);
          }else{
            _yDirection= -488*(1.0-_animation.value);
          }

          return FadeTransition(
            opacity: _animation,
            child: Transform(transform: Matrix4.translationValues(_xDirection, _yDirection, 8.0)),
          );
      }
    );

  }
}
