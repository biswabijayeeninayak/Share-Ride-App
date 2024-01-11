import 'package:ride_sharing_user_app/data/api_client.dart';


class MessageRepo {

  final ApiClient apiClient;
  MessageRepo({required this.apiClient});

  // Future<Response> createChannel(String userID,String referenceID) async {
  //   return await apiClient.postData(AppConstants.CREATE_CHANNEL, {"to_user": userID,"reference_id":referenceID, "reference_type":"booking_id"});
  // }
  //
  // Future<Response> getChannelList(int offset) async {
  //   return await apiClient.getData('${AppConstants.GET_CHANNEL_LIST}offset=$offset');
  // }
  //
  // Future<Response> getChannelListBasedOnReferenceId(int offset,String referenceID) async {
  //   return await apiClient.getData('${AppConstants.GET_CHANNEL_LIST}offset=$offset&reference_id=$referenceID&reference_type=booking_id');
  // }
  //
  // Future<Response> getConversation(String channelID,int offset) async {
  //   return await apiClient.getData('${AppConstants.GET_CONVERSATION}?channel_id=$channelID&offset=$offset');
  // }
  //
  // Future<Response> sendMessage(String message,String channelID,  List<MultipartBody> file, PlatformFile? platformFile) async {
  //   return await apiClient.postMultipartDataConversation(
  //       AppConstants.SEND_MESSAGE,
  //       {"message": message,"channel_id" : channelID},
  //       file ,
  //       otherFile: platformFile
  //   );
  // }
}