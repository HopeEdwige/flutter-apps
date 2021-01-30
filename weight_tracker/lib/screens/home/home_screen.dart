import 'package:flutter/material.dart';
import 'package:weight_tracker/models/user.dart';
import 'package:weight_tracker/models/weight.dart';
import 'package:weight_tracker/screens/home/widgets/bmi_calculator/index.dart';
import 'package:weight_tracker/screens/home/widgets/chart/index.dart';
import 'package:weight_tracker/screens/home/widgets/header/index.dart';
import 'package:weight_tracker/screens/home/widgets/history/index.dart';
import 'package:weight_tracker/screens/home/widgets/progress/index.dart';
import 'package:weight_tracker/services/db_service.dart';
import 'package:weight_tracker/util/bmi_utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User currentUser;
  bool isLoadingData;
  DBService dbService;
  List<Weight> historyItems;

  double get currentWeight => historyItems.isNotEmpty ? historyItems.first.value : 70;

  @override
  void initState() {
    historyItems = [];
    isLoadingData = true;
    dbService = DBService();

    Future.delayed(Duration.zero, () => fetchData()).catchError((e) async {
      // todo remove me :(
      final DBService db = new DBService();
      final User user = new User("Wali", 1, 25, convertHeightFromFtToMeters(5.7), 90.50, 75);
      await db.saveUser(user);
      await fetchData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    if (currentUser == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: theme.scaffoldBackgroundColor,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  icon: Icon(
                    Icons.refresh,
                    size: 28,
                  ),
                  onPressed: () {}),
            )
          ],
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Header(name: currentUser.name),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Stack(
          children: [
            ListView(
              children: <Widget>[
                Chart(history: historyItems),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Progress(
                    current: historyItems.length > 0 ? historyItems[0].value : 0,
                    target: currentUser.targetWeight,
                    initial: currentUser.initialWeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: BMICalculator(
                    height: currentUser.height,
                    weight: currentWeight,
                    graphWidth: size.width - 325,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: History(historyItems),
                ),
              ],
            ),
            Positioned(
              height: 100,
              width: size.width,
              bottom: 0,
              child: new Container(
                height: 100.0,
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    begin: const Alignment(0.0, -1.0),
                    end: const Alignment(0.0, 0.2),
                    colors: <Color>[
                      theme.colorScheme.background.withOpacity(.3),
                      theme.colorScheme.background.withOpacity(.6),
                      theme.colorScheme.background.withOpacity(.9),
                      // Colors.red,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 0),
        width: MediaQuery.of(context).size.width / 1.5,
        height: 55,
        child: FloatingActionButton.extended(
          onPressed: () => _handleNewWeightPress(),
          label: Text(
            'NEW WEIGHT',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }

  void _handleNewWeightPress() async {
    var shouldRefresh = await Navigator.pushNamed(
      context,
      '/new',
      arguments: {'selectedWeight': 70.0},
    );

    if (shouldRefresh == true) {
      refreshData();
    }
  }

  fetchData() async {
    final Map currentUserMap = await dbService.currentUser();
    final List<Weight> results = await dbService.listWeight(userId: currentUserMap['id']);

    setState(() {
      isLoadingData = false;
      historyItems = results;
      currentUser = User.fromMap(currentUserMap);
    });
  }

  void refreshData() async {
    final List<Weight> results = await dbService.listWeight(userId: currentUser.id);

    setState(() {
      historyItems = results;
    });
  }
}
