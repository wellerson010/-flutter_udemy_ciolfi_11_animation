import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart' show timeDilation;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> containerGrow;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredAnimation(
      controller: _controller.view,
    );
  }
}

class StaggeredAnimation extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> containerGrow;
  final Animation<EdgeInsets> listSlidePosition;
  final Animation<Color> fadeAnimation;

  StaggeredAnimation({this.controller})
      : containerGrow = CurvedAnimation(parent: controller, curve: Curves.ease),
        listSlidePosition = EdgeInsetsTween(
                begin: EdgeInsets.only(bottom: 0),
                end: EdgeInsets.only(bottom: 80))
            .animate(CurvedAnimation(
                parent: controller, curve: Interval(0.325, 0.8))),
        fadeAnimation = ColorTween(
                begin: Color.fromRGBO(247, 64, 106, 1), end: Color.fromRGBO(247, 64, 106, 0))
            .animate(
                CurvedAnimation(parent: controller, curve: Curves.easeInExpo));

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Stack(children: [
      ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          HomeTop(
            controller: controller,
          ),
          AnimatedListView(listSlidePosition)
        ],
      ),
      _fadeContainer()
    ]);
  }

  Widget _fadeContainer() {
    return IgnorePointer(
      child: Hero(
        tag: 'fade',
        child: Container(
          decoration: BoxDecoration(color: fadeAnimation.value),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: AnimatedBuilder(animation: controller, builder: _buildAnimation),
      ),
    );
  }
}

class HomeTop extends StatelessWidget {
  final Animation<double> controller;

  HomeTop({this.controller});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * 0.4,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Bem-vindo, Wellerson!',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
            Container(
              alignment: Alignment.topRight,
              width: controller.value * 120,
              height: controller.value * 120,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('images/perfil.jpg'),
                      fit: BoxFit.cover)),
              child: Container(
                width: controller.value * 35,
                height: controller.value * 35,
                margin: EdgeInsets.only(left: 80),
                child: Center(
                    child: Text(
                  '2',
                  style: TextStyle(
                      fontSize: controller.value * 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                )),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(80, 210, 194, 1)),
              ),
            ),
            CategoryView()
          ],
        ),
      ),
    );
  }
}

class CategoryView extends StatefulWidget {
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<String> _text = ['Estudos', 'Lista', 'Grupos'];
  int _countText = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _countText--;

              if (_countText < 0) {
                _countText = _text.length - 1;
              }
            });
          },
        ),
        Expanded(
          child: Text(
            _text[_countText],
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _countText++;

              if (_countText == _text.length) {
                _countText = 0;
              }
            });
          },
        )
      ],
    );
  }
}

class AnimatedListView extends StatelessWidget {
  final Animation<EdgeInsets> listSlidePosition;

  AnimatedListView(this.listSlidePosition);

  Widget _buildTile(
      String title, String subTitle, ImageProvider image, EdgeInsets edge) {
    return Container(
      margin: edge,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: Colors.grey, width: 1),
              bottom: BorderSide(color: Colors.grey, width: 1))),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle, image: DecorationImage(image: image)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                subTitle,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _buildTile('Estudar Flutter', 'Com Udemy',
            AssetImage('images/background.jpg'), listSlidePosition.value * 3),
        _buildTile('Estudar Flutter', 'Com Udemy',
            AssetImage('images/background.jpg'), listSlidePosition.value * 2),
        _buildTile('Estudar Flutter', 'Com Udemy',
            AssetImage('images/background.jpg'), listSlidePosition.value * 1),
        _buildTile('Estudar Flutter', 'Com Udemy',
            AssetImage('images/background.jpg'), listSlidePosition.value * 0),
      ],
    );
  }
}
