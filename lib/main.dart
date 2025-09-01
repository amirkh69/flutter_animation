import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainScreen(),
    );
  }
}

class AnimatedContainerExample extends StatefulWidget {
  const AnimatedContainerExample({super.key});

  @override
  State<AnimatedContainerExample> createState() => _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(duration: Duration(seconds: 2), width: isExpanded ? 400 : 100, height: isExpanded ? 400 : 100, color: isExpanded ? Colors.red: Colors.blue, curve: Curves.easeIn,),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            setState(() {
              isExpanded = !isExpanded;
            });
          }, child: Text('Animate Container'))
        ],
      ),
    );
  }
}


class AnimatedOpacityExample extends StatefulWidget {
  const AnimatedOpacityExample({super.key});

  @override
  State<AnimatedOpacityExample> createState() => _AnimatedOpacityExampleState();
}

class _AnimatedOpacityExampleState extends State<AnimatedOpacityExample> {

  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(opacity: _opacity, duration: Duration(seconds: 2),child: Container(
            height: 100, width: 100, color: Colors.redAccent,
          ),),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            setState(() {
              _opacity = _opacity == 1.0 ? 0.2 : 1.0;
            });
          }, child: Text('Change Opacity'))
        ],
      ),
    );
  }
}



class AnimationControllerExample extends StatefulWidget {
  const AnimationControllerExample({super.key});

  @override
  State<AnimationControllerExample> createState() => _AnimationControllerExampleState();
}

class _AnimationControllerExampleState extends State<AnimationControllerExample> with SingleTickerProviderStateMixin{
  late AnimationController animationController; //to manage timing of animation
  late Animation<double> animation; //to change values
  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(animationController);
    colorAnimation = ColorTween(begin: Colors.red, end: Colors.yellow).animate(animationController);
    animationController.forward();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(animation: animation, builder: (context, child){
        return Container(
          width: animation.value,
          height: 100,
          color: colorAnimation.value,
        );
      }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }


}


class GestureAnimationExample extends StatefulWidget {
  const GestureAnimationExample({super.key});

  @override
  State<GestureAnimationExample> createState() => _GestureAnimationExampleState();
}

class _GestureAnimationExampleState extends State<GestureAnimationExample> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late Animation<double> animation;
  double dragValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 100, end: 300).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture Animation'),
      ),
      body: Center(
        child: GestureDetector(
          onHorizontalDragUpdate: (details){
            setState(() {
              dragValue += details.primaryDelta ?? 0;
              animationController.value = dragValue/300;
            });
          },
          child: AnimatedBuilder(animation: animation, builder: (context, child){
            return Container(
              width: animation.value,
              height: animation.value,
              color: Colors.blue,
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }
}



//Hero Animation
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Screen'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondScreen()));
          },
          child: Hero(tag: 'hero-example', child: Container(height: 100,width: 100,color: Colors.blue,)),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Screen'),),
      body: Center(
        child: Hero(tag: 'hero-example', child: ClipRRect(borderRadius: BorderRadius.circular(50),
          child: Container(
            height: 300,width: 300,color: Colors.green,
          ),)),
      ),
    );
  }
}



//New Example//

//Custom Widget(Button)
class AnimatedButton extends StatefulWidget {
  final double height;
  final double width;

  const AnimatedButton({super.key, required this.height, required this.width});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(duration: Duration(seconds: 2), vsync: this);
    _sizeAnimation = Tween(begin: widget.width, end: widget.width+150).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _colorAnimation = ColorTween(begin:Colors.blue, end: Colors.red).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _controller, builder: (context,child){
      return Container(
        width: _sizeAnimation.value,
        height: _sizeAnimation.value,
        decoration: BoxDecoration(
          color: _colorAnimation.value,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Center(
          child: Text('Animated Button',style: TextStyle(fontSize: 12,color: Colors.white),),
        ),
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Screen'),),
      body: Center(
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondaryScreen()));
          },
          child: Hero(tag: 'hero-button', child: AnimatedButton(height: 50,width: 150,)),
        ),
      ),
    );
  }
}


class SecondaryScreen extends StatelessWidget {
  const SecondaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Secondary Screen'),),
      body: Center(
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
          },
          child: Hero(tag: 'hero-button', child: AnimatedButton(height: 100,width: 250,)),
        ),
      ),
    );
  }
}





















