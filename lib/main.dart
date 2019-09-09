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
          caption: TextStyle(
              fontSize: 42.0, fontWeight: FontWeight.w400, color: TEXT_COLOR),
          headline: TextStyle(
              fontSize: 36.0, fontWeight: FontWeight.w400, color: TEXT_COLOR),
          button: TextStyle(
              fontSize: 28.0, fontWeight: FontWeight.w300, color: TEXT_COLOR),
          title: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.w500, color: TEXT_COLOR),
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _homeState = "HOME";
  void _navigate(String id) {
    updateHomeState(id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              _launchURL("https://twitter.com/dash_text");
              break;
            case 1:
              _launchURL(
                  "https://www.facebook.com/Dash-Text-1825509330867292/");
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
      body: Scrollbar(
        child: ListView(children: _buildContent()),
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
            context, "venezuela", 'Venezuela', "HOME", "+58"));
        rtv.add(buildListTileCaption("¡Elige tú provedor!"));
        rtv.add(_buildListTileNumber("movilnet", "424-291-72-09", "+58"));
        rtv.add(_buildListTileNumber("digitel", "99-10", "+58"));
        rtv.add(_buildListTileNumber("movistar", "34-57", "+58"));
        break;
      case "COP":
        rtv.add(_buildListTileHomeContent(
            context, "colombia", 'Colombia', "HOME", "+57"));
        rtv.add(buildListTileCaption("¡Toca el número!"));
        rtv.add(_buildListTileNumber("drawer", "89-99-79", "+57"));
        break;
      case "USD":
        rtv.add(
            _buildListTileHomeContent(context, "usa", 'U.S.A.', "HOME", "+1"));
        rtv.add(buildListTileCaption("Touch the number!"));
        rtv.add(_buildListTileNumber("drawer", "607-307-32-74", "+1"));
        break;
    }

    return rtv;
  }

  ListTile buildListTileCaption(String msg) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 16.0),
      title: Text(
        msg,
        style: Theme.of(context)
            .textTheme
            .caption
            .copyWith(color: Colors.yellow[700]),
      ),
    );
  }

  ListTile _buildListTileNumber(
      String img, String phoneNumber, String countryCode) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
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
        _launchURL("sms:" + countryCode + phoneNumber);
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showSnackBar(context, 'Could not launch $url');
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

  void _showSnackBar(ctx, String msg, {String additionalText = ""}) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: Duration(milliseconds: 3000),
      content: Text(
        /*FlutterI18n.translate(ctx, msgId)*/ msg + additionalText,
        style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: Colors.grey[900]),
      ),
      backgroundColor: Colors.yellow[700],
    ));
  }
}
