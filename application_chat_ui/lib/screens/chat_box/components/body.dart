import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/chat_box_bloc.dart';
import 'package:messenger_ui/bloc/message_bloc.dart';
import 'package:messenger_ui/bloc_event/chat_box_event.dart';
import 'package:messenger_ui/bloc_event/message_event.dart';
import 'package:messenger_ui/bloc_state/chat_box_state.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/model/dto/message_dto.dart';
import 'package:messenger_ui/model/message.dart';
import 'package:messenger_ui/screens/chat_box/components/message_card.dart';

class Body extends StatefulWidget {
  final ChatBox chatBox;

  Body({required this.chatBox});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late ChatBox chatBox;
  late ChatBoxBloc _chatBoxBloc;
  late MessageBloc _messageBloc;
  List<Message> messages = [];
  int size = 18;
  int page = 0;
  int updateIndex = -1;
  ScrollController _scrollController = ScrollController(keepScrollOffset: true);
  Set<int> idsNeedAvatar = Set();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatBox = widget.chatBox;
    _chatBoxBloc = BlocProvider.of<ChatBoxBloc>(context);
    _messageBloc = BlocProvider.of<MessageBloc>(context);
    _chatBoxBloc.add(GetMessage(chatBoxId: chatBox.id, size: size, page: page));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _chatBoxBloc.add(GetMessage(
            page: page + 1, size: size, chatBoxId: widget.chatBox.id));
        setState(() {
          page = page + 1;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messages.clear();
  }

  @override
  Widget build(BuildContext context) {
    Set<int> idsNeedBuild = Set();
    return Column(
      children: [
        BlocListener(
          bloc: _chatBoxBloc,
          listener: (context, state) {
            // get message
            if (state is GetMessageSuccess) {
              setState(() {
                messages.addAll(state.messages);
              });
              // if not the latest message is not of currentUser => update seen message not seen before
              if (state.messages.isNotEmpty &&
                  page == 0 &&
                  state.messages[0].sender.id != chatBox.currentUser.id) {
                MessageDto messageDto = MessageDto(
                    messageId: messages[0].id,
                    messengerId: chatBox.currentUser.id,
                    chatBoxId: chatBox.id);
                _messageBloc.add(
                    UpdateMessageEvent(messageDto: messageDto, option: "seen"));
              }
            }

            if (state is NewMessageState && state.chatBoxId == chatBox.id) {
              setState(() {
                if (state.message.sender.id == chatBox.currentUser.id)
                  idsNeedBuild.add(state.message.id);
                else
                  idsNeedAvatar.add(state.message.id);
                messages.insert(0, state.message);
              });
              // if not the latest message is not of currentUser => update seen new message
              if (state.message.sender.id != chatBox.currentUser.id) {
                MessageDto messageDto = MessageDto(
                    messageId: state.message.id,
                    messengerId: chatBox.currentUser.id,
                    chatBoxId: chatBox.id);
                _messageBloc.add(
                    UpdateMessageEvent(messageDto: messageDto, option: "seen"));
              }
            }

            if (state is UpdateMessageSeenSuccess &&
                state.chatBoxId == widget.chatBox.id) {
              if (state.messages.isNotEmpty &&
                  state.messages[0].sender.id == chatBox.currentUser.id) {
                setState(() {
                  messages.replaceRange(
                      0, state.messages.length, state.messages);
                });
              }
            }

            if (state is UpdateMessageReactionSuccess &&
                state.chatBoxId == widget.chatBox.id) {
              updateIndex = state.message.id;
              for (int i = 0; i < messages.length; i++) {
                if (messages[i].id == state.message.id) {
                  setState(() {
                    messages.replaceRange(
                        i, i + 1, [state.message]);
                  });
                  break;
                }
              }
            }
          },
          child: Expanded(
            child: ListView.builder(
              // key: UniqueKey(),
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              reverse: true,
              itemCount: messages.length,
              addAutomaticKeepAlives: false,
              // cacheExtent: 1000,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                bool showDate = false;
                Message message = messages[index];
                if (index == messages.length - 1)
                  showDate = true;
                else {
                  int minute = message.createdDate
                      .difference(messages[index + 1].createdDate)
                      .inMinutes;
                  if (minute > 10) showDate = true;
                }
                if (widget.chatBox.currentUser.id != message.sender.id) {
                  if (index == 0)
                    idsNeedAvatar.add(message.id);
                  else {
                    if (messages[index - 1].sender.id == message.sender.id) {
                      int minute = messages[index - 1]
                          .createdDate
                          .difference(message.createdDate)
                          .inMinutes;
                      if (minute > 10) idsNeedAvatar.add(message.id);
                    } else
                      idsNeedAvatar.add(message.id);
                  }
                }
                if (widget.chatBox.currentUser.id == message.sender.id &&
                    !idsNeedBuild.contains(-1)) {
                  idsNeedBuild.add(message.id);
                  if (message.details.indexWhere((element) =>
                          element.seenBy.id != chatBox.currentUser.id) !=
                      -1) {
                    idsNeedBuild.add(-1);
                  }
                } else {
                  idsNeedBuild.add(-1);
                }
                bool needMessageStatus = idsNeedBuild.contains(message.id);
                bool needAvatar = idsNeedAvatar.contains(message.id);
                if (updateIndex == message.id) {
                  return Padding(
                    key: UniqueKey(),
                    padding: const EdgeInsets.only(bottom: 7),
                    child: MessageCard(
                      message: message,
                      chatBox: chatBox,
                      needMessageStatus: needMessageStatus,
                      showDate: showDate,
                      needAvatar: needAvatar,
                    ),
                  );
                }
                return Padding(
                  key: ValueKey(message.id),
                  padding: const EdgeInsets.only(bottom: 7),
                  child: MessageCard(
                    message: message,
                    chatBox: chatBox,
                    needMessageStatus: needMessageStatus,
                    showDate: showDate,
                    needAvatar: needAvatar,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
