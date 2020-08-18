
import 'package:dynamic_link_lab/src/activities/home_act.dart';
import 'package:dynamic_link_lab/src/services/dynamicLinks.dart';
import 'package:dynamic_link_lab/src/services/dynamic_link_provider.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DynamicLinkProvider())],
      child: MyApp()));
}

DynamicLinks dynamicLinks = new DynamicLinks();
String str;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initialazeDynamicLinks();
    print('init: $str');
    super.initState();
  }

  Future<dynamic> initialazeDynamicLinks() async {
    Uri deepLink;
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          deepLink = dynamicLink?.link;

          if (deepLink != null) {
            print('deepPath_ ${deepLink.path}');
            str = deepLink.path;
            Provider.of<DynamicLinkProvider>(context, listen: false).dynamicLink =
                deepLink.path;
            print('str: $str');
          }
        }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    return deepLink.path;
  }

  @override
  Widget build(BuildContext context) {
    print(str.toString());
    List<String> mat = str.toString().split('/');
    for (int i = 0; i < mat.length; i++) {
      print(mat[i]);
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeAct('hello'),
      },
    );
  }
}