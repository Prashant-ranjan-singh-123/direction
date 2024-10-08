import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarState(currentIndex: 0));

  void updatePage(int index) {
    emit(BottomNavBarState(currentIndex: index));
  }
}

class BottomNavBarState {
  final int currentIndex;
  BottomNavBarState({required this.currentIndex});
}
