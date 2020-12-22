import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemColor {
  const ItemColor({
    this.background,
    this.labelBackground,
    this.durationBackground,
  })  : assert(background != null),
        assert(labelBackground != null),
        assert(durationBackground != null);

  final dynamic background;
  final dynamic labelBackground;
  final dynamic durationBackground;
}

List<int> last3ItemColorIndexes = [];
List<ItemColor> itemColors = [
  new ItemColor(
    background: Colors.brown,
    labelBackground: Colors.brown[700],
    durationBackground: Colors.brown[700],
  ),
  new ItemColor(
    background: Colors.deepPurple,
    labelBackground: Colors.deepPurple[800],
    durationBackground: Colors.deepPurple[800],
  ),
  new ItemColor(
    background: Colors.teal,
    labelBackground: Colors.teal[800],
    durationBackground: Colors.teal[800],
  ),
  new ItemColor(
    background: Colors.amber,
    labelBackground: Colors.amber[800],
    durationBackground: Colors.amber[800],
  ),
  new ItemColor(
    background: Colors.blue,
    labelBackground: Colors.blue[800],
    durationBackground: Colors.blue[800],
  ),
  new ItemColor(
    background: Colors.pink,
    labelBackground: Colors.pink[800],
    durationBackground: Colors.pink[800],
  ),
];

ItemColor generateItemColor() {
  ItemColor color = (itemColors.toList()..shuffle()).first;
  int colorIndex = itemColors.indexOf(color);

  if (last3ItemColorIndexes.indexOf(colorIndex) != -1) {
    return generateItemColor();
  }

  if (last3ItemColorIndexes.length >= 3) {
    last3ItemColorIndexes.removeAt(0);
  }

  last3ItemColorIndexes.add(colorIndex);

  return color;
}

class Item {
  final int endDate;
  final String kind;
  final String label;
  final ItemColor color = generateItemColor();

  Item(this.label, this.kind, this.endDate);
}

List<Item> items = [
  new Item('Corona Virus', 'ending', 1609459201),
  new Item('New year', 'starting', 1609459201),
  new Item('New Television', 'arriving', 1609459201),
];

class CountDown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CountDownState();
  }
}

class CountDownState extends State<CountDown> {
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
    AppBar appBar = AppBar(
      elevation: 0.0,
      actions: _appBarActions(),
      backgroundColor: Colors.transparent,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: onPageChanged,
        scrollDirection: Axis.vertical,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) => _buildPage(items[index], appBar.preferredSize.height),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToNextPage();
        },
        elevation: 0.0,
        child: Icon(
          isLastPage ? Icons.arrow_circle_up : Icons.arrow_circle_down,
          size: 40,
        ),
        foregroundColor: Colors.white70,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  List<Widget> _appBarActions() {
    Widget layoutModeButton = Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () {},
          child: Icon(Icons.list),
        ));

    return [layoutModeButton];
  }

  Widget _buildPage(Item item, double appBarHeight) {
    return Container(
      decoration: BoxDecoration(color: item.color.background),
      padding: EdgeInsets.only(top: appBarHeight, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildTitle(item),
          SizedBox(height: 20),
          _buildDuration(item),
        ],
      ),
    );
  }

  Widget _buildTitle(Item item) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            item.label,
            style: TextStyle(
              fontSize: 50,
              fontStyle: FontStyle.italic,
              backgroundColor: item.color.labelBackground,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '${toBeginningOfSentenceCase(item.kind)} in:',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ],
    );
  }

  Widget _buildDuration(Item item) {
    return new Container(
      width: 400,
      height: 400,
      margin: const EdgeInsets.all(10),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: item.color.durationBackground,
      ),
      child: StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 1), (i) => i),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          DateTime now = DateTime.now();
          DateTime endDate = DateTime.fromMillisecondsSinceEpoch(item.endDate * 1000);
          Duration remaining = Duration(milliseconds: endDate.millisecondsSinceEpoch - now.millisecondsSinceEpoch);

          return _buildRemainingDateAndTime(remaining);
        },
      ),
    );
  }

  Widget _buildRemainingDateAndTime(Duration remaining) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${remaining.inDays}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 100),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              'Days',
              style: TextStyle(fontSize: 40, fontStyle: FontStyle.italic),
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                      text: formattedTimeString('hh', remaining),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
                      children: <TextSpan>[
                        TextSpan(text: ' : '),
                      ]),
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  'Hours',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      text: formattedTimeString('mm', remaining),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
                      children: <TextSpan>[
                        TextSpan(text: ' : '),
                      ]),
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  'Minutes',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                  text: formattedTimeString('ss', remaining),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
                )),
                SizedBox(
                  width: 7,
                ),
                Text(
                  'Seconds',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._currentPageIndex = page;
    });
  }

  void navigateToNextPage() {
    int nextPageIndex = isLastPage ? _currentPageIndex - 1 : _currentPageIndex + 1;

    _pageController.animateToPage(
      nextPageIndex,
      curve: Curves.ease,
      duration: Duration(milliseconds: 300),
    );
  }

  get isLastPage {
    return _currentPageIndex == (items.length - 1);
  }
}

String formattedTimeString(String format, Duration remaining) {
  return DateFormat(format).format(
    DateTime.fromMillisecondsSinceEpoch(
      remaining.inMilliseconds,
    ),
  );
}
