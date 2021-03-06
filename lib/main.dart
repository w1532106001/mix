import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:mix/common/baseStatelessWidget.dart';
import 'package:mix/ui/view/login_view.dart';
import 'package:mix/ui/view/mine_view.dart';
import 'package:mix/ui/view/videoHomePage.dart';
import 'package:mix/viewModel/BaseViewModel.dart';
import 'package:mix/viewModel/VideoHomePageViewModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        builder: BotToastInit(),
        //BotToastInit移动到此处
        navigatorObservers: [BotToastNavigatorObserver()],
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
            // This makes the visual density adapt to the platform that you run
            // the app on. For desktop platforms, the controls will be smaller and
            // closer together (more dense) than on mobile platforms.
            visualDensity: VisualDensity.adaptivePlatformDensity,
            backgroundColor: Color.fromARGB(255, 43, 42, 50)),
        home: MultiProvider(
            providers: [
              ChangeNotifierProvider<VideoHomePageViewModel>(
                  create: (context) => VideoHomePageViewModel()),
              ChangeNotifierProvider<BaseViewModel>(
                  create: (context) => BaseViewModel()),
            ],
            child: SafeArea(
                top: true,
                child: Scaffold(
                  backgroundColor: Color.fromARGB(255, 43, 42, 50),
                  body: MineView(),
                )))
//      ChangeNotifierProvider(
//          create: (_) => VideoHomePageViewModel(), child: BaseStatelessWidget()),
        );
  }
}
