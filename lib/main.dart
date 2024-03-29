import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
              fontSize: 42.0, fontWeight: FontWeight.w300, color: TEXT_COLOR),
          headline: TextStyle(
              fontSize: 34.0, fontWeight: FontWeight.w300, color: TEXT_COLOR),
          button: TextStyle(
              fontSize: 32.0, fontWeight: FontWeight.w300, color: TEXT_COLOR),
          title: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.w300, color: TEXT_COLOR),
          display1: TextStyle(
              fontSize: 32.0, fontWeight: FontWeight.w200, color: TEXT_COLOR),
          display2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w200),
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
  String _launchSmsLink;
  String _selectedProviderNumber;
  String _selectedProviderImage;
  String _lastSelectedHomeState;
  var _edgeInsetsActionTile = EdgeInsets.fromLTRB(64.0, 16.0, 64.0, 16.0);

  void _navigate(String id) {
    _updateState(id);
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
        fixedColor: Colors.grey[100],
        iconSize: 28,
        selectedLabelStyle: Theme.of(context).textTheme.display2,
        unselectedLabelStyle: Theme.of(context).textTheme.display2,
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
      String text, String stateId, String countryCode) {
    return ListTile(
      contentPadding: EdgeInsets.all(32.0),
      leading: _drawImage(img),
      trailing: Text(
        countryCode,
        style: Theme.of(context).textTheme.display1,
      ),
      title: _buildHomeItemText(context, text),
      onTap: () {
        _lastSelectedHomeState = stateId;
        _updateState(stateId);
      },
    );
  }

  void _updateState(String id) {
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
      case "ACTION":
        rtv.add(_buildListTileActionHeader());
        rtv.add(_buildListTileCreate());
        rtv.add(_buildListTileSend());
        rtv.add(_buildListTileSaldo());
        rtv.add(_buildListTileRate());
        break;
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

    rtv.add(ListTile(contentPadding: EdgeInsets.all(32.0)));
    return rtv;
  }

  ListTile buildListTileCaption(String msg) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      title: AutoSizeText(
        msg,
        maxLines: 1,
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
      contentPadding: EdgeInsets.all(16.0),
      leading: Image.asset(
        "images/" + img + ".png",
        width: 100.0,
      ),
      title: AutoSizeText(
        phoneNumber,
        maxLines: 1,
        style: Theme.of(context).textTheme.title,
      ),
      trailing: Icon(
        Icons.arrow_right,
        size: 48.0,
      ),
      onTap: () {
        _selectedProviderImage = img;
        _selectedProviderNumber = countryCode + "-" + phoneNumber;
        _launchSmsLink = "sms:" + countryCode + phoneNumber;
        _updateState("ACTION");
      },
    );
  }

  ListTile _buildListTileActionHeader() {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
      leading: Image.asset(
        "images/" + _selectedProviderImage + ".png",
        width: 100.0,
      ),
      title: AutoSizeText(
        _selectedProviderNumber,
        maxLines: 1,
        style: Theme.of(context).textTheme.display1,
      ),
      onTap: () {
        _updateState(_lastSelectedHomeState);
      },
    );
  }

  ListTile _buildListTileRate() {
    return ListTile(
      contentPadding: _edgeInsetsActionTile,
      leading: Icon(
        Icons.account_balance,
        size: 32.0,
      ),
      title: AutoSizeText(
        _lastSelectedHomeState == "USD" ? "CURRENT RATE" : "TASA ACTUAL",
        maxLines: 1,
        style: Theme.of(context).textTheme.title,
      ),
      onTap: () {
        _launchURL(_launchSmsLink +
            "?body=" +
            (_lastSelectedHomeState == "USD" ? "PRICE" : "TASA"));
      },
    );
  }

  ListTile _buildListTileSaldo() {
    return ListTile(
      contentPadding: _edgeInsetsActionTile,
      leading: Icon(
        Icons.account_balance_wallet,
        size: 32.0,
      ),
      title: AutoSizeText(
        (_lastSelectedHomeState == "USD" ? "CHECK BALANCE" : "REVISA SALDO"),
        maxLines: 1,
        style: Theme.of(context).textTheme.title,
      ),
      onTap: () {
        _launchURL(_launchSmsLink +
            "?body=" +
            (_lastSelectedHomeState == "USD" ? "BALANCE" : "SALDO"));
      },
    );
  }

  ListTile _buildListTileSend() {
    return ListTile(
      contentPadding: _edgeInsetsActionTile,
      leading: Icon(
        Icons.send,
        size: 32.0,
      ),
      title: AutoSizeText(
        (_lastSelectedHomeState == "USD" ? "SEND COINS" : "ENVIAR MONEDA"),
        maxLines: 1,
        style: Theme.of(context).textTheme.title,
      ),
      onTap: () {
        _launchURL(_launchSmsLink +
            "?body=" +
            (_lastSelectedHomeState == "USD"
                ? "SEND [amount] USD [receiver]"
                : "ENVIAR [monto] BS 04xxxxxxxxx"));
      },
    );
  }

  ListTile _buildListTileCreate() {
    return ListTile(
      contentPadding: _edgeInsetsActionTile,
      leading: Icon(
        Icons.account_circle,
        size: 32.0,
      ),
      title: AutoSizeText(
        (_lastSelectedHomeState == "USD" ? "CREATE ACCOUNT" : "CREAR CUENTA"),
        maxLines: 1,
        style: Theme.of(context).textTheme.title,
      ),
      onTap: () {
        _launchURL(_launchSmsLink +
            "?body=" +
            (_lastSelectedHomeState == "USD" ? "CREATE" : "CREAR"));
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

  AutoSizeText _buildDrawerItemText(BuildContext context, String txt) =>
      AutoSizeText(
        txt,
        maxLines: 1,
        style: Theme.of(context).textTheme.button,
      );

  AutoSizeText _buildHomeItemText(BuildContext context, String txt) =>
      AutoSizeText(
        txt,
        maxLines: 1,
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
