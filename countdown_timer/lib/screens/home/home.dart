import 'package:flutter/material.dart';
import 'package:countdown_timer/models/countdown_item.dart';

import 'widgets/countdown_title/countdown_title.dart';
import 'widgets/countdown_duration/countdown_duration.dart';

class Home extends StatefulWidget {
  final List<CountdownItem> countdownItems;

  Home({Key key, @required this.countdownItems}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new HomeState();
}

class HomeState extends State<Home> {
  int _currentPageIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = _buildAppBar(context);
    Widget body = _buildBody(context, appBar);
    Widget floatingActionButton = _buildFloatingActionButton();

    return new Scaffold(
      body: body,
      appBar: appBar,
      extendBodyBehindAppBar: true,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      actions: [
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.list),
            )),
      ],
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildBody(BuildContext context, AppBar appBar) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (int page) => setState(() {
        this._currentPageIndex = page;
      }),
      scrollDirection: Axis.vertical,
      itemCount: widget.countdownItems.length,
      itemBuilder: (BuildContext context, int index) => _buildCountdown(widget.countdownItems[index], appBar.preferredSize.height),
    );
  }

  Widget _buildCountdown(CountdownItem item, double appBarHeight) {
    return Container(
      decoration: BoxDecoration(color: item.shadeCard.background),
      padding: EdgeInsets.only(top: appBarHeight, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CountdownTitle(
            kind: item.kind,
            title: item.label,
            backgroundColor: item.shadeCard.labelBackground,
          ),
          SizedBox(height: 20),
          CountdownDuration(
            endDate: item.endDate,
            backgroundColor: item.shadeCard.durationBackground,
          )
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      elevation: 0.0,
      child: Icon(
        isLastPage ? Icons.arrow_circle_up : Icons.arrow_circle_down,
        size: 40,
      ),
      foregroundColor: Colors.white70,
      backgroundColor: Colors.transparent,
      onPressed: () => _navigateToNextPage(),
    );
  }

  void _navigateToNextPage() {
    int nextPageIndex = isLastPage ? _currentPageIndex - 1 : _currentPageIndex + 1;

    _pageController.animateToPage(
      nextPageIndex,
      curve: Curves.ease,
      duration: Duration(milliseconds: 300),
    );
  }

  get isLastPage {
    return _currentPageIndex == (widget.countdownItems.length - 1);
  }
}
