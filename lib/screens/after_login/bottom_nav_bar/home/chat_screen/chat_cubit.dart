import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../../services/app_user_data_logic.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit()
      : super(ChatState(gmail_uuid: '', astrologer_name: '', loading: true));

  Future<void> getData({required String astrologer_name}) async {
    emit(state.copyWith(loading: true));
    // _gmail_name = await AppUserDataLogic.get_name() ?? '';
    String _gmail_uuid = await AppUserDataLogic.get_uuid() ?? '';
    String _astrologer_name =
        astrologer_name.toLowerCase().replaceAll(' ', '_');
    emit(state.copyWith(
        loading: false,
        gmail_uuid: _gmail_uuid,
        astrologer_name: _astrologer_name));
  }

  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) {
      return 'Sending...';
    }
    final dateTime = timestamp.toDate();
    return DateFormat('hh:mm a').format(dateTime);
  }

  // void _sendMessageFromAstrologer({required String text}) async {
  //   print('text is: ${text}');
  //   if (text.isNotEmpty) {
  //     try {
  //       await FirebaseFirestore.instance
  //           .collection(
  //               _astrologer_name) // Collection representing the user's messages
  //           .doc(_gmail_uuid) // Document for this astrologer
  //           .collection('messages') // Sub-collection for messages
  //           .add({
  //         'text': text,
  //         'timestamp': FieldValue.serverTimestamp(),
  //         'sender': 'astrologer',
  //       });
  //       print('Message sent from astrologer successfully.');
  //       _textEditingController.clear(); // Clear the input field on success
  //     } catch (e) {
  //       print('Error sending message from astrologer: $e');
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Error'),
  //             content:
  //                 Text('Failed to send astrologer message. Please try again.'),
  //             actions: [
  //               TextButton(
  //                 onPressed: () => Navigator.pop(context),
  //                 child: Text('OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   }
  // }

  void sendMessage({required TextEditingController text_controller}) async {
    final text = text_controller.text.trim();

    if (text.isEmpty) return; // Early return if the message is empty

    try {
      await FirebaseFirestore.instance
          .collection(state.astrologer_name) // Astrologer's collection
          .doc(state.gmail_uuid) // Document representing the user
          .collection('messages') // Sub-collection for messages
          .add({
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
        'sender': 'user', // Added field to identify the sender
      });

      text_controller.clear(); // Clear the input field on success
    } catch (e) {
      // _showErrorDialog(
      //     'Failed to send message. Please try again.'); // Reusable error dialog
      // print('Error sending message: $e');
    }
  }
}
