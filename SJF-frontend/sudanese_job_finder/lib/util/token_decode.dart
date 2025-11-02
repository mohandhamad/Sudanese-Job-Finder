import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sudanese_job_finder/constant/app_strings.dart';
import 'package:sudanese_job_finder/util/secure_storage.dart';

class TokenDecode {
  getUserID() async {
    String? tempToken = await SecureStorage.readSecureData(AppStrings.accessTokenKey);
    if (tempToken == null) return -1;
    Map<String, dynamic> decodeToken = JwtDecoder.decode(tempToken);
    int id = decodeToken['user_id'];
    return id;
  }
}
