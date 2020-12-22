import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController;
  int _page = 0;
  String _title = "MyApp";
  Color _appBarColor = Colors.pink;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_title),
        backgroundColor: _appBarColor,
      ),
      body: PageView(
        children: <Widget>[
          Container(
            child: Center(child: Text("People")),
          ),
          Container(
            child: Center(child: Text("Timeline")),
          ),
          Container(
            child: Center(child: Text("Stats")),
          ),
        ],
        controller: _pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text("People"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            title: Text("Timeline"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            title: Text("Stats"),
          ),
        ],
        onTap: navigateToPage,
        currentIndex: _page,
      ),
    );
  }

  void navigateToPage(int page) {
    _pageController.animateToPage(page, duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    String _temptitle = "";
    Color _tempColor;
    switch (page) {
      case 0:
        _temptitle = "People";
        _tempColor = Colors.pink;
        break;
      case 1:
        _temptitle = "Timeline";
        _tempColor = Colors.green;
        break;
      case 2:
        _temptitle = "Stats";
        _tempColor = Colors.deepPurple;
        break;
    }
    setState(() {
      this._page = page;
      this._title = _temptitle;
      this._appBarColor = _tempColor;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
    _title = "People";
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
