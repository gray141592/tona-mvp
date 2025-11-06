import 'package:flutter/material.dart';

class SlidePageTransition extends PageTransitionsBuilder {
  const SlidePageTransition();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeOutCubic;

    var tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );

    return SlideTransition(
      position: animation.drive(tween),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}

class ScalePageTransition extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const curve = Curves.easeOutCubic;
    
    return ScaleTransition(
      scale: animation.drive(
        Tween(begin: 0.8, end: 1.0).chain(
          CurveTween(curve: curve),
        ),
      ),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}

class FadePageTransition extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation.drive(
        Tween(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: Curves.easeOut),
        ),
      ),
      child: child,
    );
  }
}

