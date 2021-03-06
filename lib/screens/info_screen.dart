// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ios_utsname_ext/extension.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:word_word/boxes.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:word_word/screens/license.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> with TickerProviderStateMixin {
  final blogUrl = 'https://velog.io/@bargoloft';
  final dicKoreanUrl = 'https://stdict.korean.go.kr/main/main.do';
  final dicUrimalUrl = 'https://opendict.korean.go.kr/main';
  final instaUrl = 'https://www.instagram.com/2cup_2/';
  late final AnimationController _controller;
  final Completer<WebViewController> webController = Completer<WebViewController>();

  bool _autoFocus = false;
  bool _isLeftHanded = false;
  //bool _method = true;
  late SharedPreferences _prefs;

  bool _isInstaVisible = false;

  Widget webView(String url) {
    return SafeArea(
      child: WebView(
        initialUrl: url,
        onWebViewCreated: (WebViewController _controller) async {
          webController.isCompleted ? '' : webController.complete(_controller);
        },
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _loadCounter();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _loadCounter() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _autoFocus = _prefs.getBool('autoFocus') ?? false;
      //_method = _prefs.getBool('method') ?? true;
      _isLeftHanded = _prefs.getBool('left') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = TextButton.styleFrom(
      padding: EdgeInsets.zero,
      minimumSize: const Size(50, 42),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      alignment: Alignment.centerLeft,
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              //color: const Color(0xffa1df6e),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  )),
              child: Center(
                child: Text(
                  '????????????',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                      fontFamily: 'KoPubBatang',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorDark,
                      letterSpacing: 4),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: TextButton(
            //     style: ButtonStyle(
            //       foregroundColor: MaterialStateProperty.all(textColor),
            //       padding: MaterialStateProperty.all(EdgeInsets.zero),
            //     ),
            //     onPressed: () {
            //       Navigator.pop(context);
            //     },
            //     child: const Icon(
            //       Icons.arrow_back,
            //       color: Colors.grey,
            //     ),
            //   ),
            // ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, top: 8, bottom: 8),
              child: Text('????????????'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: TextButton(
                style: buttonStyle,
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => webView(dicKoreanUrl)));
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    '????????????????????? ????????????',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 17, color: Theme.of(context).primaryColorDark),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => webView(dicUrimalUrl)));
                },
                style: buttonStyle,
                child: SizedBox(
                  height: 20,
                  width: double.infinity,
                  child: Text(
                    '????????? ??? ????????????',
                    style: TextStyle(fontSize: 17, color: Theme.of(context).primaryColorDark),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, top: 8, bottom: 8),
              child: Text('????????????'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: TextButton(
                onPressed: () {
                  //Navigator.push(
                  //    context, MaterialPageRoute(builder: (context) => const Setting()));
                  showBottomSheet(context);
                },
                style: buttonStyle,
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    '???????????? ??????',
                    style: TextStyle(fontSize: 17, color: Theme.of(context).primaryColorDark),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: TextButton(
                style: buttonStyle,
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: const Text(
                          '???????????? ?????????',
                          style: TextStyle(fontSize: 17, color: Colors.red),
                        ),
                        content: const Text('??????????????? ????????? ???????????????????'),
                        actions: [
                          CupertinoDialogAction(
                              child: const Text(
                                '??????',
                                //style: TextStyle(color: Colors.red), // ??? ?????? ?????????
                              ),
                              onPressed: () => Navigator.pop(context)),
                          CupertinoDialogAction(
                            child: const Text(
                              '?????????',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () async {
                              RecentWordBoxes.getWords().clear();
                              WordBoxes.getWords().clear();
                              SharedPreferences preferences = await SharedPreferences.getInstance();
                              await preferences.clear();
                              Navigator.pop(context);
                              showToast('??????????????? ????????? ???????????????!');
                            },
                          )
                        ],
                      );
                    },
                    barrierDismissible: true,
                  );
                },
                child: Text(
                  '???????????? ?????????',
                  style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Theme.of(context).primaryColorDark),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, top: 8.0, bottom: 8),
              child: Text('????????? ??????'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: TextButton(
                style: buttonStyle,
                onPressed: () {
                  _sendEmail();
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    '???????????? ?????????',
                    style: TextStyle(fontSize: 17, color: Theme.of(context).primaryColorDark),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: TextButton(
                    style: buttonStyle,
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => webView(blogUrl)));
                      // _openUrl(blogUrl);
                      setState(() {
                        _isInstaVisible = true;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          '????????? ?????????',
                          style: TextStyle(fontSize: 17, color: Theme.of(context).primaryColorDark),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Image(
                            width: 20,
                            height: 20,
                            image: AssetImage('assets/images/greenfavicon.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_isInstaVisible)
                  // const Padding(
                  //   padding: EdgeInsets.all(5),
                  //   child: Image(
                  //     width: 17,
                  //     height: 17,
                  //     image: AssetImage('assets/images/instagram_icon.png'),
                  //   ),
                  // ),
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(20, 20),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      _openUrl(instaUrl);
                    },
                    child: const Image(
                      alignment: Alignment.centerLeft,
                      width: 20,
                      height: 20,
                      image: AssetImage('assets/images/instagram_icon.png'),
                    ),
                  ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: TextButton(
                style: buttonStyle,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Licence()));
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    '???????????? ????????????',
                    style: TextStyle(fontSize: 17, color: Theme.of(context).primaryColorDark),
                  ),
                ),
              ),
            ),
            //SizedBox(height: 100),
            //const Divider(height: 1, indent: 10, endIndent: 10),

            //Expanded(child: SizedBox(height: 0)),
            Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    Text('?????? ?????? ????????? ??????\n???????????? ???????????? ????????? ???????????? ???????????????.'),
                  ],
                )),
            // Center(
            //   child: Lottie.asset(
            //     'assets/lottie/lf30_editor_to6nvmre.json',
            //     repeat: true,
            //     height: 100,
            //     controller: _controller,
            //     onLoaded: (composition) {
            //       // Configure the AnimationController with the duration of the
            //       // Lottie file and start the animation.
            //       _controller
            //         ..duration = composition.duration
            //         ..forward();
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Consumer(
                builder: (context, appModel, child) => Container(
                  height: 230,
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '??? ????????? ?????? ??????',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  CupertinoSwitch(
                                    value: _autoFocus,
                                    onChanged: <bool>(value) {
                                      setState(() {
                                        _autoFocus = value;
                                        _prefs.setBool('autoFocus', _autoFocus);
                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       '?????? ?????? ??????',
                              //       style: Theme.of(context).textTheme.bodyLarge,
                              //     ),
                              //     CupertinoSlidingSegmentedControl(
                              //       padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                              //       groupValue: _method,
                              //       children: const {
                              //         'exact': Text(' ?????? '),
                              //         'include': Text(' ?????? '),
                              //       },
                              //       onValueChanged: <bool>(newValue) {
                              //         setState(() {
                              //           _method = newValue;
                              //           _prefs.setString('method', _method);
                              //         });
                              //       },
                              //       thumbColor: Theme.of(context).primaryColorLight,
                              //       backgroundColor: CupertinoColors.extraLightBackgroundGray,
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '??????????????????????',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  CupertinoSwitch(
                                    value: _isLeftHanded,
                                    onChanged: <bool>(value) {
                                      setState(() {
                                        _isLeftHanded = value;
                                        _prefs.setBool('left', _isLeftHanded);
                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                  ),
                                  // CupertinoSlidingSegmentedControl(
                                  //   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                                  //   groupValue: _isLeftHanded,
                                  //   children: const {
                                  //     true: Text(' ??? '),
                                  //     false: Text('?????????'),
                                  //   },
                                  //   onValueChanged: <bool>(newValue) {
                                  //     setState(() {
                                  //       _isLeftHanded = newValue;
                                  //       _prefs.setBool('left', _isLeftHanded);
                                  //     });
                                  //   },
                                  //   thumbColor: Theme.of(context).primaryColorLight,
                                  // ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                '?????? ?????? ??? ?????? ????????? ????????????',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          child: const Text('??????'),
                          onPressed: () => Navigator.pop(context),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Theme.of(context).primaryColorDark),
                            backgroundColor:
                                MaterialStateProperty.all(Theme.of(context).primaryColor),
                            shadowColor: MaterialStateProperty.all(Colors.transparent),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  //url ??????
  void _openUrl(String url) async {
    await launch(url, forceWebView: false, forceSafariVC: false);
  }

  //?????? ????????????
  void _sendEmail() async {
    String body = await _getEmailBody();

    final Email email = Email(
      body: body,
      subject: '[???????????? ??????]',
      recipients: ['qmak01@naver.com'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      // String title = '????????? ?????? ??????!';
      // String message = '';
      // _showErrorAlert(title: title, message: message);
    } catch (error) {
      debugPrint(error.toString());
      String title =
          '?????? ?????? ?????? ????????? ??? ?????? ????????? ????????? ?????? ????????? ???????????? ????????? ???????????????.\n\n?????? ???????????? ??????????????? ????????????????????????. \n\nqmak01@naver.com';
      String message = '';
      _showErrorAlert(title: title, message: message);
    }
  }

  void _showErrorAlert({required String title, required String message}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(title,
              style: const TextStyle(
                fontSize: 15,
              )),
        );
      },
    );
  }

  Future<String> _getEmailBody() async {
    Map<String, dynamic> deviceInfo = await _getDeviceInfo();
    Map<String, dynamic> appInfo = await _getAppInfo();

    String body = '';

    body += "==========================\n";
    body += '?????? ????????? ?????? ??????????????? ??? ????????? ????????? \n';

    deviceInfo.forEach((key, value) {
      body += '$key: $value \n';
    });
    appInfo.forEach((key, value) {
      body += '$key: $value \n';
    });

    body += "==========================\n";
    return body;
  }

  Future<Map<String, dynamic>> _getAppInfo() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    return {'???????????? ??????': info.version};
  }

  Future<Map<String, dynamic>> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidDeviceInfo(await deviceInfo.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfo.iosInfo);
      }
    } catch (error) {
      deviceData = {"Error": "Failed to get platform version"};
    }

    return deviceData;
  }

  Map<String, dynamic> _readAndroidDeviceInfo(AndroidDeviceInfo info) {
    var release = info.version.release;
    var sdkInt = info.version.sdkInt;
    var manufacturer = info.manufacturer;
    var model = info.model;

    return {'OS ??????': 'Android $release (SKD $sdkInt)', '??????': '$manufacturer $model'};
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo info) {
    var systemName = info.systemName;
    var version = info.systemVersion;
    var machine = info.utsname.machine?.iOSProductName;

    //print('${info.toMap()}');
    return {'OS ??????': '$systemName $version', '??????': '$machine'};
  }

  void showToast(String msg) => Fluttertoast.showToast(
        msg: msg,
        //msg: '?????? ??????????????? Open API??? ?????????\n ?????? ????????? ?????? ????????? ??????????????? ?????? ????????????.!',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Theme.of(context).primaryColorLight,
        textColor: Theme.of(context).primaryColorDark,
        fontSize: 12.0,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        webShowClose: false,
      );
}
