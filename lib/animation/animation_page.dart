import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});
  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        // addListenerはアニメーションが新しい数字（例えば、大きさの値）を作るたびに、「絵を描き直して！」ってアプリにお願いする仕組み
        // この「絵を描き直して！」をお願いするのが、setState()の役割
        setState(() {});
      });
    controller.forward();
  }

  @override
  void dispose() {
    // アニメーションを作るための「コントローラー」（controller）は、ずっと動かしておくとスマホやパソコンのメモリを無駄に使ってしまいます
    // だから、「もうこのアニメーションいらないよ」となったら片付ける必要があります。それをやっているのが、dispose()という関数
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: animation.value,
          width: animation.value,
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}
