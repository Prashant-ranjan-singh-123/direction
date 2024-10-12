import 'package:equatable/equatable.dart';

class ProfileScreenAfterLoginState extends Equatable {
  final bool loading;
  final String name;
  final String? photo;

  ProfileScreenAfterLoginState({
    required this.loading,
    name,
    this.photo
  }) : name = name ?? 'Sagar Dattatrey';

  ProfileScreenAfterLoginState copyWith({
    bool? loading,
    String? name,
    String? photo
  }) {
    return ProfileScreenAfterLoginState(
      loading: loading ?? this.loading,
      name: name ?? this.name,
      photo: photo ?? this.photo
    );
  }

  @override
  List<Object?> get props => [loading, name, photo];
}
