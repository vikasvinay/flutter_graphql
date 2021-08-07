import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/model/mission.dart';
import 'package:flutter_task/repository/launch.dart';
part 'event.dart';

part 'state.dart';

class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
  LaunchBloc() : super(LaunchState.loading());

  final MissionsRepository _missionsRepository = MissionsRepository();

  @override
  Stream<LaunchState> mapEventToState(LaunchEvent event) async* {
    if (event is GetMissionsList) {
      yield* mapMissionsToState(event);
    } else if (event is SortMissions) {
      yield* mapSortMissionsToState(event);
    } else {
      yield LaunchState.loading();
    }
  }

  Stream<LaunchState> mapMissionsToState(LaunchEvent event) async* {
    yield LaunchState.loading();
    var list = await _missionsRepository.getMissionsRepo();
    if (list != null) {
      yield LaunchState.hasMissionsList(list);
    } else {
      yield LaunchState.error();
    }
  }

  Stream<LaunchState> mapSortMissionsToState(SortMissions event) async* {
    yield LaunchState.loading();
    var list = await _missionsRepository.sortMissions(type: event.type);
    if (list != null) {
      yield LaunchState.hasMissionsList(list);
    } else {
      yield LaunchState.error();
    }
  }
}
