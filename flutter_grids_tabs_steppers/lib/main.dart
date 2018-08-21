import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController?.dispose();
    tabController = null;
    super.dispose();
  }

  TabBar _makeTabBar() {
    return TabBar(
      tabs: <Tab>[
        Tab(icon: Icon(Icons.home)),
        Tab(icon: Icon(Icons.settings_power)),
      ],
      controller: tabController,
    );
  }

  TabBarView _makTabBarView(tabs) {
    return TabBarView(
      children: tabs,
      controller: tabController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tabs Demo"),
        backgroundColor: Colors.brown,
        bottom: _makeTabBar(),
      ),
      body: _makTabBarView(<Widget>[TheGridView(), SimpleWidget()]),
    );
  }
}

class SimpleWidget extends StatefulWidget {
  SimpleWidgetState createState() => SimpleWidgetState();
}

class SimpleWidgetState extends State<SimpleWidget> {
  int stepCounter = 0;
  final List<Step> steps = [
    Step(
        title: Text("Step One"),
        content: Text("This is the first step"),
        isActive: true),
    Step(
        title: Text("Step Two"),
        content: Text("This is the second step"),
        isActive: true),
    Step(
        title: Text("Step Three"),
        state: StepState.editing,
        content: Text("This is the third step"),
        isActive: true),
    Step(
        title: Text("Step Four"),
        content: Text("This is the fourth step"),
        isActive: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stepper(
        currentStep: this.stepCounter,
        steps: steps,
        type: StepperType.vertical,
        onStepCancel: () {
          setState(() {
            stepCounter > 0 ? stepCounter -= 1 : stepCounter = 0;
          });
        },
        onStepContinue: () {
          setState(() {
            stepCounter < steps.length - 1 ? stepCounter += 1 : stepCounter = 0;
          });
        },
        onStepTapped: (step) {
          setState(() {
            stepCounter = step;
          });
        },
      ),
    );
  }
}

class TheGridView extends StatelessWidget {
  Widget makeGridCell(String name, IconData icon) {
    return Card(
      elevation: 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[Icon(icon), Text(name)],
      ),
    );
  }

  @override
  Widget build(BuildContext covariant) {
    var widgets = <Widget>[
      makeGridCell("Home", Icons.home),
      makeGridCell("Email", Icons.email),
      makeGridCell("Chat", Icons.chat_bubble),
      makeGridCell("New", Icons.new_releases),
      makeGridCell("Network", Icons.network_wifi),
      makeGridCell("Options", Icons.settings)
    ].expand((e) => [e, e]).toList();

    return GridView.count(
      primary: true,
      padding: EdgeInsets.all(1.0),
      crossAxisCount: 2,
      childAspectRatio: 1.0,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: widgets,
    );
  }
}
