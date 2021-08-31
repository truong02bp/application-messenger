import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
      // if (_counter%4==0)
      //   values.insert(0,Test(message : "$_counter", isSender : true));
      // else
      //   values.insert(0,Test(message : "$_counter", isSender : false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
          ),
          SizedBox(
            height: 20,
          ),
          // Expanded(
          //   child: ListView.builder(
          //       itemCount: values.length,
          //       reverse: true,
          //       itemBuilder: (context, index) => Row(
          //         mainAxisAlignment: values[index].isSender == true? MainAxisAlignment.end : MainAxisAlignment.start,
          //         children: [
          //           Container(
          //               margin: EdgeInsets.all(5),
          //               color: Colors.red,
          //               height: 20,
          //               width: 100,
          //               child: Text(values[index].message)
          //           ),
          //         ],
          //       )),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
