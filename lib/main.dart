import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/ui/list_screen.dart';
import 'package:flutter_task/utilities/navigator_key.dart';

import 'bloc/launch/bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<LaunchBloc>(
      create: (context) => LaunchBloc()..add(LaunchEvent.getMissionsList()),
    )
  ], child: Main()));
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(builder: () {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigatorKey.navigatorKey,
          home: ListScreen());
    });
  }
}


 // GraphQLProvider(
      //   client: Global().graphQlData,
      //   child: MaterialApp(
      //     navigatorKey: NavigatorKey.navigatorKey,
      //     debugShowCheckedModeBanner: false,
      //     home:ListScreen()

      //   ),
      // );