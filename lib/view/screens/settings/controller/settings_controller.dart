import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/auth/repository/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});



}