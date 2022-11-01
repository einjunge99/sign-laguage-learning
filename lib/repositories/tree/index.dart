import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_language_learning/api/resources_api.dart';
import 'package:sign_language_learning/models/badge.dart';
import 'package:sign_language_learning/repositories/tree/base.dart';

final treeProvider = Provider<Tree>((ref) => Tree());

class Tree extends BaseTree {
  final _resources = GetIt.instance<ResourcesApi>();

  //TODO: Use HttpResponse.fail metadata to show error messages
  @override
  Future<List<Badge>> getBadges() async {
    final response = await _resources.getLectures();

    final lectures = List<Map<String, dynamic>>.from(response.data);

    return lectures.map((e) => Badge.fromMap(e)).toList();
  }
}
