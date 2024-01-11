import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/offer/repository/offer_repo.dart';

class OfferController extends GetxController implements GetxService{
  final OfferRepo offerRepo;
  OfferController({required this.offerRepo});



}