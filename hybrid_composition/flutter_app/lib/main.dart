import 'package:flutter/material.dart';
import 'package:flutter_app/vulkan_native_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hybrid composition',
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
      ),
      home: MyHomePage(title: 'Hybrid composition Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaInfo = MediaQuery.of(context);

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      //appBar: AppBar(
     //   title: Text(widget.title),
   //   ),
      body: SafeArea(
        left: true,
        top: true,
        right: true,
        bottom: true,
        minimum: const EdgeInsets.all(100.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              //height: mediaInfo.size.height,
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: SingleChildScrollView(
                child: new Stack(
                alignment: Alignment.topLeft,
                  children: <Widget>[
                    Container(
                      color: Colors.green,
                      child: Column(
                      children:
                        List<Widget>.generate(100, (int index) => Text("ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ")),
                      ),
                    ),
                    new Positioned(
                      left: 0,
                      top: 100,
                      //bottom: 0,
                      height: 300,
                      width: constraints.maxWidth,
                      //child: Container(
                      //  color: Colors.blue,
                      //),
                      child: SizedBox(
                        height: 300,
                        width: 200,
                        child: VulkanNativeView(),
                      ),
                    ),
                  ],
                ),
              ),
              //https://stackoverflow.com/questions/49838021/how-do-i-stack-widgets-overlapping-each-other-in-flutter
            );
          },
        ),
      ),
    );
  }
}
