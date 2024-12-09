import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  final String gmail_uuid;
  final String astrologer_name;
  final bool loading;

  const ChatState({
    required this.gmail_uuid,
    required this.astrologer_name,
    required this.loading,
  });

  ChatState copyWith({
    String? gmail_uuid,
    String? astrologer_name,
    bool? loading,
  }) {
    return ChatState(
      gmail_uuid: gmail_uuid ?? this.gmail_uuid,
      astrologer_name: astrologer_name ?? this.astrologer_name,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [gmail_uuid, astrologer_name, loading];
}
