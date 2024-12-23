import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../services/app_user_data_logic.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit()
      : super(ChatState(
            gmail: '',
            astrologer_name: '',
            loading: true,
            image_url: '',
            user_name: ''));

  Future<void> getData({required String astrologer_name}) async {
    emit(state.copyWith(loading: true));
    String _user_name = await AppUserDataLogic.get_name() ?? '';
    String _gmail_email = await AppUserDataLogic.get_email() ?? '';
    String _image_url = await AppUserDataLogic.get_image_url() ?? '';
    String _astrologer_name =
        astrologer_name.toLowerCase().replaceAll(' ', '_');
    // 'hello';
    emit(state.copyWith(
        loading: false,
        gmail_uuid: _gmail_email,
        image_url: _image_url,
        user_name: _user_name,
        astrologer_name: _astrologer_name));
  }

  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) {
      return 'Sending...';
    }
    final dateTime = timestamp.toDate();
    return DateFormat('hh:mm a').format(dateTime);
  }

  void sendMessageFromAstrologer(
      {required TextEditingController text_controller,
      required BuildContext context}) async {
    if (text_controller.text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection(state
                .astrologer_name) // Collection representing the user's messages
            .doc(makeUserName(
                username: state.gmail)) // Document for this astrologer
            .collection('messages') // Sub-collection for messages
            .add({
          'text': text_controller.text.toString(),
          'timestamp': FieldValue.serverTimestamp(),
          'sender': 'astrologer',
        });
        print('Message sent from astrologer successfully.');
        text_controller.clear(); // Clear the input field on success
      } catch (e) {
        print('Error sending message from astrologer: $e');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content:
                  Text('Failed to send astrologer message. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void sendMessage({required TextEditingController text_controller}) async {
    final text = text_controller.text.trim();

    if (text.isEmpty) return; // Early return if the message is empty

    try {
      await FirebaseFirestore.instance
          .collection(state.astrologer_name) // Astrologer's collection
          .doc(makeUserName(
              username: state.gmail)) // Document representing the user
          .set({'image': state.image_url, 'user_name': state.user_name},
              SetOptions(merge: true));

      await FirebaseFirestore.instance
          .collection(state.astrologer_name) // Astrologer's collection
          .doc(makeUserName(
              username: state.gmail)) // Document representing the user
          .collection('messages') // Sub-collection for messages
          .add({
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
        'sender': 'user', // Added field to identify the sender
      },);

      text_controller.clear(); // Clear the input field on success
    } catch (e) {
      print('error: $e');
    }
  }

  String makeUserName({required String username}) {
    return username.split('@').first;
  }
}
