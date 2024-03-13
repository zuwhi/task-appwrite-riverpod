import 'package:appwrite/appwrite.dart';
import 'package:appwrite_todo/constants/app_constants.dart';

class NetworkClientHelper {
  static final Client _appwriteClient = Client()
      .setEndpoint(Appconstants.endpoint)
      .setProject(Appconstants.projectid)
      .setSelfSigned(status: true);
  NetworkClientHelper._();

  static final instance = NetworkClientHelper._();

  Client get appwriteClient => _appwriteClient;
}
