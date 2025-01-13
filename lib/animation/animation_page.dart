import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});
  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMixin は、アニメーションを効率的に動かすための「1つのティッカー」を提供する仕組み。
  // これを使うと、バッテリーやパフォーマンスを節約しながらスムーズなアニメーションを実現可能。
  // ティッカーは、時間の経過を定期的に通知してくれる。たとえば、1秒間に60回（60fps）画面を更新したい場合に、「今、何ミリ秒経ったよ！」と教えてくれる役割。アニメーションを動かすためには、この「時間の通知」が必要。

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
