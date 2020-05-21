import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutteranimado/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class AnimatedSetState extends StatefulWidget {
  @override
  _AnimatedSetStateState createState() => _AnimatedSetStateState();
}

class _AnimatedSetStateState extends State<AnimatedSetState>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animation = Tween<double>(begin: 0, end: 300).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        }

        if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: _animation.value,
        width: _animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}

class MyAnimatedWidget extends StatefulWidget {
  @override
  _MyAnimatedWidgetState createState() => _MyAnimatedWidgetState();
}

class _MyAnimatedWidgetState extends State<MyAnimatedWidget>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animation = Tween<double>(begin: 0, end: 400).animate(_animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        }

        if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _MyAnimatedWidgetStateWidget(_animation);
  }
}

class _MyAnimatedWidgetStateWidget extends AnimatedWidget {
  _MyAnimatedWidgetStateWidget(Animation<double> animation)
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    return Center(
      child: Container(
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}

class MyAnimatedBuilder extends StatefulWidget {
  @override
  _MyAnimatedBuilderState createState() => _MyAnimatedBuilderState();
}

class _MyAnimatedBuilderState extends State<MyAnimatedBuilder>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _animation = Tween<double>(begin: 0, end: 200).animate(_animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        }

        if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    _animation2 =
        Tween<double>(begin: 0, end: 400).animate(_animationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            }

            if (status == AnimationStatus.dismissed) {
              _animationController.forward();
            }
          });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GrowTransition(
          child: FlutterLogo(),
          animation: _animation,
        ),
        GrowTransition(
          child: FlutterLogo(),
          animation: _animation2,
        )
      ],
    );
  }
}

class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  GrowTransition({this.child, this.animation});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: this.animation,
        builder: (context, child) {
          return Container(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}

class MyAnimatedBuilder2 extends StatefulWidget {
  @override
  _MyAnimatedBuilderState2 createState() => _MyAnimatedBuilderState2();
}

class _MyAnimatedBuilderState2 extends State<MyAnimatedBuilder2>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        }

        if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:  WellTransition(
        child: FlutterLogo(),
        animation: _animation,
      ),
    );
  }
}

class WellTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  final sizeTween = Tween<double>(begin: 0, end: 300);
  final opacityTween = Tween<double>(begin: 0, end: 1);

  WellTransition({this.child, this.animation});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: this.animation,
        builder: (context, child) {
          return Opacity(
            opacity: opacityTween.evaluate(animation),
            child: Container(
              height: sizeTween.evaluate(animation),
              width: sizeTween.evaluate(animation),
              child: child,
            ),
          );
        },
        child: child,
      ),
    );
  }
}
