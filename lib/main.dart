import 'package:flutter/material.dart';
import 'package:flutter_table/routes/router.dart';
import 'package:fps_monitor/widget/custom_widget_inspector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GlobalKey<NavigatorState> globalKey = GlobalKey();
    WidgetsBinding.instance.addPostFrameCallback((t) {
      //overlayState 为 fps_monitor 内提供变量，用于overlay.insert
      overlayState = globalKey.currentState.overlay;
    });
    return MaterialApp(
      navigatorKey: globalKey,
      showPerformanceOverlay: false, //帧率检测
      onGenerateRoute: CusRouter.generateRoute,
      title: 'Flutter Table',
      builder: (ctx, child) => CustomWidgetInspector(
        child: child,
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Table'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String s;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     s = "学习2222222255555555555555553333333332学习2222222255555555555555553333333ASD1";//46.24630541871922
    Size size =_getTextSize(
       s,TextStyle(
        color: Colors.blueAccent,
        fontSize: 12.0,),textMaxWidth: 100.0
    );
    print("width:${size.width}  height:${size.height}");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body:Column(
          children: [
            Center(
              child: RaisedButton(
                child: Text("表格"),
                onPressed: (){
                  Navigator.of(context).pushNamed(RouteName.table);
                  // print("表格");
                },
              ),
            ),

            Container(
              width: 100.0,
              height: 106.0,
              child: Text(s,style:TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 12.0) ,),
            )
          ],
        ) 
        
    );
  }


  Size _getTextSize(String text,TextStyle style,
      {textMaxWidth = double.infinity,int textMaxLines = null}) {
    final TextPainter textPainter = TextPainter(
        maxLines:textMaxLines,
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: textMaxWidth);
    return textPainter.size;
  }
}
