import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_language_learning/api/resources_api.dart';
import 'package:sign_language_learning/models/user.dart';
import 'package:sign_language_learning/repositories/profile/base.dart';

final profileProvider = Provider<Profile>((ref) => Profile());

class Profile extends BaseProfile {
  final _resources = GetIt.instance<ResourcesApi>();

  //TODO: Use HttpResponse.fail metadata to show error messages
  @override
  Future<LocalUser> getUserInfo() async {
    final response = await _resources.getUserInfo();

    final user = Map<String, dynamic>.from(response.data);

    return LocalUser.fromMap(user);
  }
}
