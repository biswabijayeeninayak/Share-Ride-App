import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

class ConversationBubble extends StatefulWidget {
  final bool isRightMessage;

  const ConversationBubble({super.key, required this.isRightMessage});

  @override
  State<ConversationBubble> createState() => _ConversationBubbleState();
}

class _ConversationBubbleState extends State<ConversationBubble> {
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      setState((){ });
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {


    return Column(crossAxisAlignment: widget.isRightMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start, children: [
      Padding(padding: widget.isRightMessage ? const EdgeInsets.fromLTRB(20, 5, 5, 5) : const EdgeInsets.fromLTRB(5, 5, 20, 5),
        child: Column(
          crossAxisAlignment: widget.isRightMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: widget.isRightMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Text(widget.isRightMessage ?
                "customer".tr :"driver".tr,
                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                  ),
                ),
              ],
            ),
            SizedBox(height:Dimensions.fontSizeExtraSmall),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: widget.isRightMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                widget.isRightMessage ?
                const SizedBox() :
                Column(
                  children: [
                    ClipRRect(borderRadius: BorderRadius.circular(50),
                      child: const CustomImage(
                        height: 30,
                        width: 30,
                        image: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bWFsZSUyMHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60',
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: Dimensions.paddingSizeSmall,),
                Flexible(
                  child: Column(crossAxisAlignment: widget.isRightMessage?CrossAxisAlignment.end:CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, children: [
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.isRightMessage?Theme.of(context).colorScheme.onPrimaryContainer:Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                            child: Text('Please give us some time to review. We will contact as soon as possible after review.'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10,),
                widget.isRightMessage ?
                ClipRRect(borderRadius: BorderRadius.circular(50),
                    child: const CustomImage(height: 30, width: 30,
                        image: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
                    )
                )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),

      Padding(
          padding: widget.isRightMessage ? const EdgeInsets.fromLTRB(5, 0, 50, 5) : const EdgeInsets.fromLTRB(50, 0, 5, 5),
          child: Text(
              "Dec 12,2023",
              textDirection: TextDirection.ltr,
              style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)
          )
      ),
    ],
    );
  }
}


