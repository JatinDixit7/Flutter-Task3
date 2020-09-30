import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MaterialButton(
                child: Text("show image"),
                onPressed: () => showRevealImageDialog(context),
                color: Colors.black12,
              ),
              SizedBox(height: 12),
              MaterialButton(
                child: Text("show text "),
                onPressed: () => showRevealTextDialog(context),
                color: Colors.black12,
              ),
              SizedBox(height: 12),
              SizedBox(height: 12),
              CircularRevealAnimation(
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Lamborghini_Veneno.jpg/1200px-Lamborghini_Veneno.jpg',
                  width: 300,
                  height: 300,
                ),
                animation: animation,
//                centerAlignment: Alignment.centerRight,
                centerOffset: Offset(130, 100),
//                minRadius: 12,
//                maxRadius: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showRevealImageDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Lamborghini_Veneno.jpg/1200px-Lamborghini_Veneno.jpg'),
            ),
            margin: EdgeInsets.only(top: 50, left: 12, right: 12, bottom: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return CircularRevealAnimation(
          child: child,
          animation: anim1,
          centerAlignment: Alignment.bottomCenter,
        );
      },
    );
  }

  void showRevealTextDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 400.0),
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Hello lambo",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "My name is Jatin ",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("OK"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            margin: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return CircularRevealAnimation(
          child: child,
          animation: anim1,
          centerAlignment: Alignment.center,
        );
      },
    );
  }
}
