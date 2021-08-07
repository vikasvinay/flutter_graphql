// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_task/bloc/launch/bloc.dart';
// import 'package:flutter_task/model/mission.dart';
// import 'package:flutter_task/repository/launch.dart';
// import 'package:flutter_task/ui/details_screen.dart';
// import 'package:flutter_task/utilities/navigator_key.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class Try extends StatefulWidget {
//   const Try({Key? key}) : super(key: key);

//   @override
//   _TryState createState() => _TryState();
// }

// class _TryState extends State<Try> {
//   String name = "vinay";

//   MissionsRepository _repository = MissionsRepository();
//   TextEditingController _typeAheadController = TextEditingController();

//   @override
//   void initState() {
//     BlocProvider.of<LaunchBloc>(context).add(LaunchEvent.getMissionsList());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             // var list = await _repository.getMissionsRepo();
//             // _repository.getMission(name: 'A');
//             print("presed");

//             // print(list);
//           },
//         ),
//         appBar: AppBar(
//           title: Text("Try"),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             BlocBuilder<LaunchBloc, LaunchState>(
//               builder: (context, state) {
//                 if (state is ErrorState) {
//                   return Container(
//                     alignment: Alignment.center,
//                     child: Text(name),
//                   );
//                 } else if (state is HasMissonsList) {
//                   return Center(
//                     child: Text("${state.missions.length}"),
//                   );
//                 } else {
//                   return Center(
//                     child: Text("error"),
//                   );
//                 }
//               },
//             ),
//             searchBar()
//           ],
//         ));
//   }

//   Widget searchBar() {
//     return Container(
//       height: 0.06.sh,
//       padding: EdgeInsets.only(left: 10.w, right: 20.w),
//       child: TypeAheadField(
//         textFieldConfiguration: TextFieldConfiguration(
//           controller: _typeAheadController,
//           decoration: InputDecoration(
//               suffixIcon: IconButton(
//                 icon: Icon(Icons.close),
//                 onPressed: () {
//                   // _search.value = false;
//                   _typeAheadController.clear();
//                 },
//               ),
//               border:
//                   OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
//               labelText: 'Search'),
//           // onChanged: (name) {
//           //   getProductByName(name);
//           // },
//           // onSubmitted: (name) {

//           //   getProductByName(name);
//           // }
//         ),
//         suggestionsCallback: (pattern) async {
//           if (pattern.length > 1) {
//             return await _getSuggestions(pattern);
//           }
//           throw "";
//         },
//         itemBuilder: (context, hint) {
//           hint as Mission;
//           return ListTile(
//             title: Text("Mission name: ${hint.missionName}"),
//             subtitle: Text("Launch site: ${hint.launchSiteName}"),
//           );
//         },
//         onSuggestionSelected: (suggestion) {
//           suggestion as Mission;
//           getProductByName(suggestion);
//         },
//       ),
//     );
//   }

//   _getSuggestions(String name) async {
//     var missions = await _repository.getByName(name: name);

//     return missions;
//   }

//   getProductByName(Mission pattern) async {
//     NavigatorKey.navigatorKey.currentState!.push(MaterialPageRoute(
//         builder: (_) => DetailsScreen(
//               mission: pattern,
//             )));
//   }
// }
