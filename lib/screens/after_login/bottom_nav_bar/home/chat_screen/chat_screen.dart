import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:direction/main.dart';
import 'package:direction/screens/after_login/bottom_nav_bar/home/chat_screen/chat_state.dart';
import 'package:direction/screens/splash_screen/splash_screen.dart';
import 'package:direction/utils/app_asset.dart';
import 'package:direction/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../../services/app_user_data_logic.dart';
import '../../../../../shared/app_bar.dart';
import '../../../../../shared/circular_progress_indicator.dart';
import '../../../../../utils/text_style.dart';
import 'chat_cubit.dart';

class ChatScreen extends StatefulWidget {
  String astrologer_name;
  String image;
  @override
  ChatScreen({required this.astrologer_name, required this.image});
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  late ChatCubit cubit;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    cubit = context.read<ChatCubit>();
    cubit.getData(astrologer_name: widget.astrologer_name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppAppBar.afterLoginAppBar(
            title: widget.astrologer_name,
            is_high_icon: false,
            imageUrl: widget.image),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            return state.loading
                ? AdaptiveCircularProgressIndicator()
                : SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection(
                                    state.astrologer_name) // Main collection
                                .doc(cubit.makeUserName(
                                    username: state
                                        .gmail)) // Specific document for the user
                                .collection(
                                    'messages') // Sub-collection for the user's messages
                                .orderBy('timestamp',
                                    descending: true) // Order by timestamp
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                print(snapshot.error);
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              }

                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              // Extracting messages from the snapshot
                              List<QueryDocumentSnapshot<Object?>> messages =
                                  snapshot.data!.docs;

                              return _chat_show_area(
                                  messages:
                                      messages); // Pass messages to your UI widget
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.black.withOpacity(0.2)),
                                borderRadius: BorderRadius.circular(10)),
                            // color: AppColor.secondary,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                      controller: _textEditingController,
                                      decoration: InputDecoration(
                                        hintText: 'Message...',
                                        // prefixIcon: , // Leading icon
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: AppColor.white),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: AppColor.white),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors
                                                  .white), // Border when focused
                                        ),
                                      )),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      color: AppColor.primary,
                                    ),
                                    onPressed: () {
                                      cubit.sendMessage(
                                          text_controller:
                                              _textEditingController);
                                      // print('hello');
                                      // _sendMessageFromAstrologer(
                                      //     text: _textEditingController.text.toString());
                                    }),
                                // IconButton(
                                //     icon: Icon(
                                //       Icons.send,
                                //       color: AppColor.black,
                                //     ),
                                //     onPressed: () {
                                //       cubit.sendMessageFromAstrologer(
                                //           text_controller:
                                //               _textEditingController,
                                //           context: context);
                                //       // print('hello');
                                //       // _sendMessageFromAstrologer(
                                //       //     text: _textEditingController.text.toString());
                                //     }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ));
  }

  /// Helper function to show an error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
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

  Widget _message({
    required String message,
    required Timestamp? time_stemp,
    String sender = 'user', // Default sender is 'user'
  }) {
    bool isSender = sender == 'user';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isSender) ...[
            // Receiver's Avatar
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                radius: 18,
                child: ClipOval(
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6,
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: isSender
                    ? AppColor.secondary.withOpacity(1)
                    : AppColor.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft:
                      isSender ? Radius.circular(16) : Radius.circular(0),
                  bottomRight:
                      isSender ? Radius.circular(0) : Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message,
                    style: AppTextStyle.h1(
                        fontSize: 18, fontColor: AppColor.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    cubit.formatTimestamp(time_stemp),
                    style: AppTextStyle.body1(
                        fontColor: AppColor.white.withOpacity(0.6),
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chat_show_area(
      {required List<QueryDocumentSnapshot<Object?>> messages}) {
    if (messages.isEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.svg_empty_chat),
          SizedBox(height: 30),
          Text(
            'Start your conversation',
            style: AppTextStyle.body1(),
          ),
        ],
      );
    } else {
      return ListView.builder(
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return _message(
            message: message['text'],
            time_stemp: message['timestamp'],
            sender: message['sender'] ?? 'user',
          );
        },
      );
    }
  }
}
