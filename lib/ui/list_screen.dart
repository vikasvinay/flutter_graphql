import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/bloc/launch/bloc.dart';
import 'package:flutter_task/model/mission.dart';
import 'package:flutter_task/repository/launch.dart';
import 'package:flutter_task/utilities/constants.dart';
import 'package:flutter_task/utilities/images.dart';
import 'package:flutter_task/utilities/navigator_key.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:lottie/lottie.dart';
import 'details_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  ValueNotifier<bool> _showSort = ValueNotifier<bool>(false);
  ValueNotifier<bool> _showSearch = ValueNotifier<bool>(false);
  MissionsRepository _repository = MissionsRepository();
  TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: menuButton(),
        body: CustomScrollView(
          slivers: [
            ValueListenableBuilder(
                valueListenable: _showSearch,
                builder: (context, value, _) {
                  return SliverAppBar(
                    floating: true,
                    actions: [
                      Hero(
                          tag: 'Search',
                          child: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              _showSearch.value = !_showSearch.value;
                              _showSort.value = false;
                            },
                          ))
                    ],
                    centerTitle: true,
                    title: _showSearch.value
                        ? searchBar("title")
                        : Hero(tag: 'title', child: Text("Missions")),
                  );
                }),
            SliverList(
                delegate: SliverChildListDelegate([
              BlocBuilder<LaunchBloc, LaunchState>(
                builder: (context, state) {
                  if (state is ErrorState || state is LoadingState) {
                    return loadindWidget();
                  } else if (state is HasMissonsList) {
                    return listOfMissions(state);
                  } else {
                    return loadindWidget();
                  }
                },
              )
            ]))
          ],
        ));
  }

  Widget menuButton() {
    return ValueListenableBuilder(
        valueListenable: _showSort,
        builder: (context, value, _) {
          return Column(
            key: ValueKey(value),
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (_showSort.value)
                FloatingActionButton(
                  heroTag: 'a-z',
                  onPressed: () {
                    BlocProvider.of<LaunchBloc>(context)
                      ..add(LaunchEvent.sortMissions(SortBy.missionName));
                    _showSort.value = false;
                    _showSearch.value = false;
                  },
                  child: Text('A-Z'),
                ),
              if (_showSort.value)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: FloatingActionButton(
                    heroTag: '1-2',
                    onPressed: () {
                      BlocProvider.of<LaunchBloc>(context)
                        ..add(LaunchEvent.sortMissions(SortBy.date));
                      _showSort.value = false;
                      _showSearch.value = false;
                    },
                    child: Text("1-2"),
                  ),
                ),
              FloatingActionButton(
                heroTag: 'menu',
                onPressed: () {
                  _showSort.value = !_showSort.value;
                  _showSearch.value = false;
                },
                child: Icon(_showSort.value ? Icons.close : Icons.menu),
              )
            ],
          );
        });
  }

  Widget loadindWidget() {
    return Center(
        child: AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: Lottie.asset(Json.rocketLaunch)));
  }

  Widget listOfMissions(HasMissonsList state) {
    return AnimatedSwitcher(
      duration: Duration(seconds: 1),
      child: Container(
        height: 0.9.sh,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: state.missions.length,
            itemBuilder: (context, index) {
              var mission = state.missions[index];
              return Padding(
                padding: EdgeInsets.only(top: 10.h, right: 10.w, left: 10.w),
                child: Card(
                  child: ListTile(
                    title: Text(mission.missionName!),
                    subtitle: Text(mission.launchDate!),
                    leading: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r)),
                        height: 0.2.sh,
                        width: 0.18.sw,
                        child: FadeInImage.assetNetwork(
                          placeholder: LocalAssets.placeholder,
                          image: mission.images!.length > 0
                              ? mission.images!.first
                              : defaultImage,
                          fit: BoxFit.cover,
                        )),
                    onTap: () {
                      NavigatorKey.navigatorKey.currentState!
                          .push(MaterialPageRoute(
                              builder: (_) => DetailsScreen(
                                    mission: mission,
                                  )));
                    },
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget searchBar(String key) {
    return Hero(
      tag: key,
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 0.05.sh,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
        padding: EdgeInsets.only(left: 10.w, right: 20.w),
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: _typeAheadController,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _typeAheadController.clear();
                  },
                ),
                labelText: 'Search'),
          ),
          suggestionsCallback: (pattern) async {
            if (pattern.length > 1) {
              return await _getSuggestions(pattern);
            }
            throw "";
          },
          itemBuilder: (context, hint) {
            hint as Mission;
            return ListTile(
              title: Text("Mission name: ${hint.missionName}"),
              subtitle: Text("Launch site: ${hint.launchSiteName}"),
            );
          },
          onSuggestionSelected: (suggestion) {
            suggestion as Mission;
            getProductByName(suggestion);
            _typeAheadController.clear();
          },
        ),
      ),
    );
  }

  _getSuggestions(String name) async {
    var missions = await _repository.getByName(name: name);

    return missions;
  }

  getProductByName(Mission pattern) async {
    NavigatorKey.navigatorKey.currentState!.push(MaterialPageRoute(
        builder: (_) => DetailsScreen(
              mission: pattern,
            )));
  }
}

// Query(
        //     options: QueryOptions(document: gql(Myquery().sortBy(SortBy.missionName))), //mission_name  launch_date_unix
        //     builder: (result, {refetch, fetchMore}) {
        //       if (result.hasException) {
        //         return Center(
        //           child: IconButton(
        //               onPressed: () {
        //                 NavigatorKey.navigatorKey.currentState!.pop(context);
        //               },
        //               icon: Icon(
        //                 Icons.replay_outlined,
        //                 size: 30.r,
        //               )),
        //         );
        //       }
        //       if (result.isLoading) {
        //         return Center(
        //             child: AnimatedSwitcher(
        //                 duration: Duration(seconds: 1),
        //                 child: Lottie.asset(Json.rocketLaunch)));
        //       }
        //       var rawData = result.data!['launches'] as List;

        //       return AnimatedSwitcher(
        //         duration: Duration(seconds: 1),
        //         child: Container(
        //           height: 0.9.sh,
        //           child: ListView.builder(
        //               shrinkWrap: true,
        //               itemCount: rawData.length,
        //               itemBuilder: (context, index) {
        //                 var mission = Mission.fromJson(data: rawData[index]);
        //                 return Padding(
        //                   padding:
        //                       EdgeInsets.only(top: 10.h, right: 10.w, left: 10.w),
        //                   child: Card(
        //                     child: ListTile(
        //                       title: Text(mission.missionName!),
        //                       subtitle: Text(mission.launchDate!),
        //                       leading: Container(
        //                           clipBehavior: Clip.hardEdge,
        //                           decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(20.r)),
        //                           height: 0.2.sh,
        //                           width: 0.18.sw,
        //                           child: FadeInImage.assetNetwork(
        //                             placeholder: LocalAssets.placeholder,
        //                             image: mission.images!.length > 0
        //                                 ? mission.images!.first
        //                                 : defaultImage,
        //                             fit: BoxFit.cover,
        //                           )),
        //                       onTap: () {
        //                         NavigatorKey.navigatorKey.currentState!
        //                             .push(MaterialPageRoute(
        //                                 builder: (_) => DetailsScreen(
        //                                       mission: mission,
        //                                     )));
        //                       },
        //                     ),
        //                   ),
        //                 );
        //               }),
        //         ),
        //       );
        //     }),
