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
  @override
  Widget build(BuildContext context) {
    final TEXT_COLOR = Colors.white;
    return MaterialApp(
      title: 'DashText',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Montserrat',
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
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _homeState = "HOME";
  void _navigate(String id) {
    updateHomeState(id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
      bottomSheet: BottomNavigationBar(
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
        fixedColor: Colors.grey[400],
        selectedFontSize: 12.0,
        onTap: (index) {
          switch (index) {
            case 0:
              _launchURL(
                  "https://www.facebook.com/Dash-Text-1825509330867292/");
              break;
            case 1:
              _launchURL("https://twitter.com/dash_text");
              break;
            case 2:
              _launchURL("https://www.instagram.com/dashtext/");
              break;
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
            _buildListTileMenu(context, "venezuela", 'Venezuela', "VES"),
            _buildListTileMenu(context, "colombia", 'Colombia', "COP"),
            _buildListTileMenu(context, "usa", 'U.S.A.', "USD"),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildContent(),
      ),
    );
  }

  ListTile _buildListTileHomeContent(BuildContext context, String img,
      String text, String id, String countryCode) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(48.0, 32.0, 48.0, 32.0),
      leading: _drawImage(img),
      trailing: Text(
        countryCode,
        style: Theme.of(context).textTheme.title,
      ),
      title: _buildHomeItemText(context, text),
      onTap: () {
        updateHomeState(id);
      },
    );
  }

  void updateHomeState(String id) {
    setState(() {
      _homeState = id;
    });
  }

  Image _drawImage(String img) => Image.asset("images/" + img + ".png");

  ListTile _buildListTileMenu(
      BuildContext context, String img, String text, String id) {
    return ListTile(
      contentPadding: EdgeInsets.all(16.0),
      leading: _drawImage(img),
      trailing: Icon(Icons.arrow_forward_ios),
      title: _buildDrawerItemText(context, text),
      onTap: () {
        _navigate(id);
      },
    );
  }

  List<Widget> _buildContent() {
    List<Widget> rtv = [];

    switch (_homeState) {
      case "HOME":
        rtv.add(Padding(padding: EdgeInsets.all(30.0)));
        rtv.add(_buildListTileHomeContent(
            context, "venezuela", 'Venezuela', "VES", "+58"));
        rtv.add(_buildListTileHomeContent(
            context, "colombia", 'Colombia', "COP", "+57"));
        rtv.add(
            _buildListTileHomeContent(context, "usa", 'U.S.A.', "USD", "+1"));
        break;
      case "VES":
        rtv.add(_buildListTileHomeContent(
            context, "venezuela", 'Venezuela', "", ""));
        rtv.add(_buildListTileNumber("movilnet", "0424-291-72-09"));
        rtv.add(_buildListTileNumber("digitel", "99-10"));
        rtv.add(_buildListTileNumber("movistar", "34-57"));
        break;
      case "COP":
        rtv.add(
            _buildListTileHomeContent(context, "colombia", 'Colombia', "", ""));
        break;
      case "USD":
        rtv.add(_buildListTileHomeContent(context, "usa", 'U.S.A.', "", ""));
        break;
    }

    return rtv;
  }

  ListTile _buildListTileNumber(String img, String phoneNumber) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 24.0),
      leading: Image.asset(
        "images/" + img + ".png",
        width: 100.0,
      ),
      title: Text(
        phoneNumber,
        style: Theme.of(context).textTheme.title,
      ),
      trailing: Icon(
        Icons.sms,
        size: 36.0,
      ),
      onTap: () {
        _launchURL("sms:" + phoneNumber);
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Text _buildDrawerItemText(BuildContext context, String txt) => Text(
        txt,
        style: Theme.of(context).textTheme.button,
      );

  Text _buildHomeItemText(BuildContext context, String txt) => Text(
        txt,
        style: Theme.of(context).textTheme.headline,
      );
}
