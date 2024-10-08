import 'package:equatable/equatable.dart';

class BottomNavBarState extends Equatable {
  final int currentIndex;

  const BottomNavBarState({required this.currentIndex});

  BottomNavBarState copyWith({int? currentIndex}) {
    return BottomNavBarState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
  @override
  List<Object?> get props => [currentIndex];
}
