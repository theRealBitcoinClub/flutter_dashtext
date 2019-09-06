import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
const _kFontFam = 'MyFlutterApp';

const IconData facebook = const IconData(0xf300, fontFamily: _kFontFam);
const IconData facebook_rect = const IconData(0xf301, fontFamily: _kFontFam);
const IconData twitter = const IconData(0xf302, fontFamily: _kFontFam);
const IconData twitter_bird = const IconData(0xf303, fontFamily: _kFontFam);
const IconData instagram = const IconData(0xf31e, fontFamily: _kFontFam);
const IconData instagram_filled = const IconData(0xf31f, fontFamily: _kFontFam);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final TEXT_COLOR = Colors.white;
    return MaterialApp(
      title: 'DashText',
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
        primarySwatch: Colors.blue, // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default font family.
        fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(
              fontSize: 36.0, fontWeight: FontWeight.w400, color: TEXT_COLOR),
          button: TextStyle(
              fontSize: 28.0, fontWeight: FontWeight.w300, color: TEXT_COLOR),
          title: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.w500, color: TEXT_COLOR),
          body1: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              fontFamily: 'Hind',
              color: TEXT_COLOR),
        ),
      ),
      home: MyHomePage(title: 'DashText'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

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

  var _selectedIndex = 0;

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

  void navigate(String content) {
    setState(() {});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.title,
        ),
        leading: Builder(
          builder: (context) => IconButton(
            tooltip: "MENU",
            padding: EdgeInsets.all(6.0),
            alignment: Alignment.centerRight,
            icon: Image.asset("images/home.png"),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(twitter_bird),
            title: Text('Twitter'),
          ),
          BottomNavigationBarItem(
            icon: Icon(facebook),
            title: Text('Facebook'),
          ),
          BottomNavigationBarItem(
            icon: Icon(instagram),
            title: Text('Instagram'),
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.grey[400],
        selectedFontSize: 12.0,
        onTap: (index) {
          switch (_selectedIndex) {
            case 0: _launchURL("https://www.facebook.com/Dash-Text-1825509330867292/"); break;
            case 1: _launchURL("https://twitter.com/dash_text"); break;
            case 2: _launchURL("https://www.instagram.com/dashtext/"); break;
          }
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset("images/drawer.png"),
              decoration: BoxDecoration(color: Colors.white),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(16.0),
              leading: Image.asset("images/venezuela.png"),
              trailing: Icon(Icons.arrow_forward_ios),
              title: buildDrawerItemText(context, 'Venezuela'),
              onTap: () {
                navigate("v");
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.all(16.0),
              leading: Image.asset("images/colombia.png"),
              trailing: Icon(Icons.arrow_forward_ios),
              title: buildDrawerItemText(context, 'Colombia'),
              onTap: () {
                navigate("c");
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.all(16.0),
              leading: Image.asset("images/usa.png"),
              trailing: Icon(Icons.arrow_forward_ios),
              title: buildDrawerItemText(context, 'U.S.A.'),
              onTap: () {
                navigate("u");
              },
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(96.0, 32.0, 32.0, 32.0),
              leading: Image.asset("images/venezuela.png"),
              title: buildDrawerItemText(context, 'Venezuela'),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(96.0, 32.0, 32.0, 32.0),
              leading: Image.asset("images/colombia.png"),
              title: buildDrawerItemText(context, 'Colombia'),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(96.0, 32.0, 32.0, 32.0),
              leading: Image.asset("images/usa.png"),
              title: buildDrawerItemText(context, 'U.S.A.'),
              onTap: () {},
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Text buildDrawerItemText(BuildContext context, String txt) => Text(
        txt,
        style: Theme.of(context).textTheme.button,
      );
}
