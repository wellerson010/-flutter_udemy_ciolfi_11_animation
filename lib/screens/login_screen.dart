import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin{
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _formContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        child: Column(
          children: <Widget>[
            _buildInput(
                icon: Icons.person_outline, obscure: false, hint: 'Username'),
            _buildInput(
                icon: Icons.lock_outline, obscure: true, hint: 'Password')
          ],
        ),
      ),
    );
  }

  Widget _buildInput({IconData icon, String hint, bool obscure}) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.white24, width: 0.5))),
      child: TextFormField(
        obscureText: obscure,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            icon: Icon(icon, color: Colors.white),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(fontSize: 15, color: Colors.white),
            contentPadding:
                EdgeInsets.only(top: 30, right: 30, bottom: 30, left: 5)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 4;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 70, bottom: 32),
                      child: Image.asset('images/tickicon.png',
                          width: 150, height: 150, fit: BoxFit.contain),
                    ),
                    _formContainer(),
                    FlatButton(
                      padding: EdgeInsets.only(top: 160),
                      onPressed: () {},
                      child: Text('Não possui uma conta? Cadastre-se!',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 12,
                          letterSpacing: 1
                        ),
                      ),
                    )
                  ],
                ),
                StaggerAnimation(_animationController.view)
              ],
            )
          ],
        ),
      ),
    );
  }

}

class StaggerAnimation extends StatelessWidget {
  final AnimationController controller;

  final Animation<double> buttonSqueeze;

  StaggerAnimation(this.controller): buttonSqueeze = Tween<double>(
    begin: 320,
    end: 60
  ).animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.150)));

  Widget _buildInside(BuildContext context){
    if (buttonSqueeze.value > 75){
      return Text(
        'Sign In',
        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300, letterSpacing: 0.3),
      );
    }

    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      strokeWidth: 1,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child){
    return Padding(
      padding: EdgeInsets.only(bottom: 50),
      child: InkWell(
        onTap: (){
          controller.forward();
        },
        child: Container(
          width: buttonSqueeze.value,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromRGBO(247, 64, 106, 1),
            borderRadius: BorderRadius.all(Radius.circular(30))
          ),
          child: _buildInside(context)
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
