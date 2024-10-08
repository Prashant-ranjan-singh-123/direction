import 'package:equatable/equatable.dart';

class HomePageState extends Equatable{
  int totalBalance;
  bool isLoading;
  bool isIndia;

  HomePageState({required this.totalBalance, required this.isLoading, required this.isIndia});

  HomePageState copyWith({
    int totalBalance=0,
    bool isLoading = true,
    bool isIndia = false,
}){
    return HomePageState(
        totalBalance: totalBalance ?? this.totalBalance,
        isLoading: isLoading ?? this.isLoading,
        isIndia: isLoading ?? this.isLoading
    );
  }

  @override
  List<Object?> get props => [
    totalBalance,
    isLoading,
    isIndia
  ];

}