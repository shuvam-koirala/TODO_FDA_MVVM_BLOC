import 'package:flutter/material.dart';
import 'package:todo_fda_mvvm_bloc/core/views/splash_page.dart';
import 'package:todo_fda_mvvm_bloc/core/views/unknown_page.dart';
import 'package:todo_fda_mvvm_bloc/features/todo/presentation/views/todo_page.dart';

class NavigationRoutes {
  static const String splashPage = "/";
  static const String todoPage = "/todo";
  static const String unknownPage = "/unknown";
}

class NavigationRouter {
  static _getArguments({required dynamic settings}) {
    return settings.arguments == null ? "" : settings.arguments as String;
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final String args = _getArguments(settings: settings);
    switch (settings.name) {
      case NavigationRoutes.splashPage:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case NavigationRoutes.todoPage:
        return MaterialPageRoute(builder: (context) => const TodoPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) => const UnknownPage());
  }
}
