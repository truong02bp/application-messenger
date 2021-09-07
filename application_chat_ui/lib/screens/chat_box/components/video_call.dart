// /// Create agora sdk instance and initialize
// Future<void> _initAgoraRtcEngine() async {
//   await AgoraRtcEngine.create(APP_ID);
//   await AgoraRtcEngine.enableVideo();
// }
//
// /// Add agora event handlers
// void _addAgoraEventHandlers() {
//   AgoraRtcEngine.onError = (dynamic code) {
//     setState(() {
//       final info = 'onError: $code';
//       _infoStrings.add(info);
//     });
//   };
//
//   AgoraRtcEngine.onJoinChannelSuccess = (
//       String channel,
//       int uid,
//       int elapsed,
//       ) {
//     setState(() {
//       final info = 'onJoinChannel: $channel, uid: $uid';
//       _infoStrings.add(info);
//     });
//   };
//
//   AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
//     setState(() {
//       final info = 'onUserJoined: $uid';
//       _infoStrings.add(info);
//       _users.add(uid);
//     });
//   };
//
//   AgoraRtcEngine.onUpdatedUserInfo = (AgoraUserInfo userInfo, int i) {
//     setState(() {
//       final info = 'onUpdatedUserInfo: ${userInfo.toString()}';
//       _infoStrings.add(info);
//     });
//   };
//
//   AgoraRtcEngine.onRejoinChannelSuccess = (String string, int a, int b) {
//     setState(() {
//       final info = 'onRejoinChannelSuccess: $string';
//       _infoStrings.add(info);
//     });
//   };
//
//   AgoraRtcEngine.onUserOffline = (int a, int b) {
//     callMethods.endCall(call: widget.call);
//     setState(() {
//       final info = 'onUserOffline: a: ${a.toString()}, b: ${b.toString()}';
//       _infoStrings.add(info);
//     });
//   };
//
//   AgoraRtcEngine.onRegisteredLocalUser = (String s, int i) {
//     setState(() {
//       final info = 'onRegisteredLocalUser: string: s, i: ${i.toString()}';
//       _infoStrings.add(info);
//     });
//   };
//
//   AgoraRtcEngine.onLeaveChannel = () {
//     setState(() {
//       _infoStrings.add('onLeaveChannel');
//       _users.clear();
//     });
//   };
//
//   AgoraRtcEngine.onConnectionLost = () {
//     setState(() {
//       final info = 'onConnectionLost';
//       _infoStrings.add(info);
//     });
//   };
//
//   AgoraRtcEngine.onUserOffline = (int uid, int reason) {
//     // if call was picked
//
//     setState(() {
//       final info = 'userOffline: $uid';
//       _infoStrings.add(info);
//       _users.remove(uid);
//     });
//   };
//
//   AgoraRtcEngine.onFirstRemoteVideoFrame = (
//       int uid,
//       int width,
//       int height,
//       int elapsed,
//       ) {
//     setState(() {
//       final info = 'firstRemoteVideo: $uid ${width}x $height';
//       _infoStrings.add(info);
//     });
//   };
// }
//
// /// Helper function to get list of native views
// List<Widget> _getRenderViews() {
//   final List<AgoraRenderWidget> list = [
//     AgoraRenderWidget(0, local: true, preview: true),
//   ];
//   _users.forEach((int uid) => list.add(AgoraRenderWidget(uid)));
//   return list;
// }
