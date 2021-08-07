part of 'bloc.dart';

class LaunchEvent extends Equatable {
  const LaunchEvent();

  factory LaunchEvent.getMissionsList() => GetMissionsList();
  factory LaunchEvent.sortMissions(String type) => SortMissions(type: type);

  @override
  List<Object?> get props => [];
}

class GetMissionsList extends LaunchEvent {}

class SortMissions extends LaunchEvent {
  final String type;
  SortMissions({required this.type});
  @override
  List<String> get props => [type];
}
