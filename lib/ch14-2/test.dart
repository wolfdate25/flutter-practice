import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: MyRouterDelegate(),
      routeInformationParser: MyRouteInformationParser(),
    );
  }
}

class MyRoutePath {
  String? id;

  MyRoutePath.home() : this.id = null;

  MyRoutePath.detail(this.id);
}

class MyRouteInformationParser extends RouteInformationParser<MyRoutePath> {
  @override
  Future<MyRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '/');
    if (uri.pathSegments.length >= 2) {
      var remaining = uri.pathSegments[1];
      return MyRoutePath.detail(remaining);
    } else {
      return MyRoutePath.home();
    }
  }

  @override
  RouteInformation restoreRouteInformation(MyRoutePath path) {
    if (path.id == null) {
      return RouteInformation(location: '/');
    } else {
      return RouteInformation(location: '/detail/${path.id}');
    }
  }
}

class MyRouterDelegate extends RouterDelegate<MyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoutePath> {
  String? selectId;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  MyRoutePath get currentConfiguration {
    if (selectId == null) {
      return MyRoutePath.home();
    } else {
      return MyRoutePath.detail(selectId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(child: HomeScreen(_handleOnPressed)),
        if (selectId != null) MaterialPage(child: DetailScreen(selectId))
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        selectId = null;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(MyRoutePath configuration) async {
    if (configuration.id != null) {
      selectId = configuration.id;
    }
  }

  void _handleOnPressed(String id) {
    selectId = id;
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  final ValueChanged<String> onPressed;

  HomeScreen(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => onPressed('1'),
              child: Text('1'),
            ),
            TextButton(
              onPressed: () => onPressed('2'),
              child: Text('2'),
            ),
            TextButton(
              onPressed: () => onPressed('3'),
              child: Text('3'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  String? id;

  DetailScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Detail $id'),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
