import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  final String gmail;
  final String user_name;
  final String image_url;
  final String astrologer_name;
  final bool loading;

  const ChatState(
      {required this.gmail,
      required this.astrologer_name,
      required this.loading,
      required this.image_url,
      required this.user_name});

  ChatState copyWith({
    String? gmail_uuid,
    String? astrologer_name,
    String? image_url,
    String? user_name,
    bool? loading,
  }) {
    return ChatState(
        gmail: gmail_uuid ?? this.gmail,
        astrologer_name: astrologer_name ?? this.astrologer_name,
        loading: loading ?? this.loading,
        image_url: image_url ?? this.image_url,
        user_name: user_name ?? this.user_name);
  }

  @override
  List<Object> get props =>
      [gmail, astrologer_name, loading, image_url, user_name];
}
