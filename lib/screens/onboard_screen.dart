import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> with TickerProviderStateMixin {
  final introKey = GlobalKey<IntroductionScreenState>();
  //late final AnimationController _controller;

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const Home()),
    );
  }

  Widget _buildLottie(String assetName, [double width = 350]) {
    AnimationController _lottieController = AnimationController(vsync: this);
    return Lottie.asset(
      'assets/lottie/$assetName',
      repeat: true,
      height: width,
      controller: _lottieController,
      onLoaded: (composition) {
        // Configure the AnimationController with the duration of the
        // Lottie file and start the animation.
        _lottieController
          ..duration = composition.duration
          ..forward();
      },
    );
  }

  _storeOnboardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  void initState() {
    //_controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle bodyStyle = const TextStyle(fontSize: 18.0, color: Colors.grey);

    ButtonStyle buttonStyle = TextButton.styleFrom(
      padding: EdgeInsets.zero,
      minimumSize: const Size(30, 20),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      alignment: Alignment.centerLeft,
    );

    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      // globalHeader: Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 16, right: 16),
      //       child: _buildImage('flutter.png', 100),
      //     ),
      //   ),
      // ),
      // globalFooter: SizedBox(
      //   width: double.infinity,
      //   height: 60,
      //   child: ElevatedButton(
      //     child: const Text(
      //       '?????? ????????? ???',
      //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      //     ),
      //     onPressed: () {
      //       _storeOnboardInfo();
      //       _onIntroEnd(context);
      //     },
      //   ),
      // ),
      pages: [
        PageViewModel(
          title: '????????? ???????????????',
          body: '??????????????? ????????????????????? ?????? API???\n'
              '????????? ?????? ????????????!',
          image: _buildLottie('search.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: '????????? ???????????????',
          body: '?????? ????????? ?????? ??? ?????????\n'
              '????????? ?????? ????????? ???????????????!',
          image: _buildLottie('empty_box.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: '????????? ???????????????',
          body: '????????? ?????? ????????? ?????? ??? ???????????????!\n\n'
              '?????? ???????????? ????????? ???????????? \n'
              '???????????? ?????? ???????????? ?????? ???????????????.',
          image: _buildLottie('write.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: '????????? ???????????? ????????? ?????????!',
          body: '??? ?????? ???????????? ????????? ???????????????',
          image: _buildLottie('smartphone.json'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () {
        _storeOnboardInfo();
        _onIntroEnd(context);
      },
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showNextButton: false,
      showBackButton: false,
      back: const Icon(Icons.arrow_back),
      skip: const Text(
        '??????',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      next: Icon(
        Icons.arrow_forward,
        color: Theme.of(context).primaryColor,
      ),
      done: Text(
        '??????',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryColorDark,
          height: 0,
        ),
      ),
      doneStyle: buttonStyle,
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      controlsPadding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(20.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          )),
      dotsContainerDecorator: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
