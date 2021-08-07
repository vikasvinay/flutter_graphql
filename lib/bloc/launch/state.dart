part of 'bloc.dart';

class LaunchState extends Equatable {
  const LaunchState();

  factory LaunchState.emptyState() => EmptyState();
  factory LaunchState.loading() => LoadingState();
  factory LaunchState.error() => ErrorState();
  factory LaunchState.hasMissionsList(List<Mission> list) =>
      HasMissonsList(missions: list);

  @override
  List<Object?> get props => [];
}

class EmptyState extends LaunchState {}

class LoadingState extends LaunchState {}

class ErrorState extends LaunchState {}

class HasMissonsList extends LaunchState {
  final List<Mission> missions;

  HasMissonsList({required this.missions});
  @override
  List<Object?> get props => [missions];
}
