import 'dart:async';

import 'package:flutter_task/model/mission.dart';
import 'package:flutter_task/services/graphql_config.dart';
import 'package:flutter_task/services/query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MissionsRepository {
  GraphQLClient _config = GraphQlConfig().qlClient();
  Map<String, dynamic> json = {};

  Future<List<Mission>> getByName({required String name}) async {
    var list = <Mission>[];

    QueryResult result = await _config
        .query(QueryOptions(document: gql(Myquery().getMission(name))));

    if (result.hasException) {
      print("error");
    } else if (result.isLoading) {
      print("is loading");
    } else {
      var data = await result.data!['launches'] as List;
      data.forEach((element) {
        list.add(Mission.fromJson(data: element));
      });
    }

    return list;
  }

  Future<List<Mission>>? sortMissions({required String type}) async {
    var list = <Mission>[];

    QueryResult result = await _config
        .query(QueryOptions(document: gql(Myquery().sortBy(type))));

    if (result.hasException) {
      print("error");
    } else if (result.isLoading) {
      print("is loading");
    } else {
      print(result.data);
      var data = await result.data!['launches'] as List;
      data.forEach((element) {
        list.add(Mission.fromJson(data: element));
      });
    }

    return list;
  }

  Future<List<Mission>>? getMissionsRepo() async {
    var list = <Mission>[];

    QueryResult result =
        await _config.query(QueryOptions(document: gql(Myquery().getAll())));

    if (result.hasException) {
      print("error");
    } else if (result.isLoading) {
      print("is loading");
    } else {
      print(result.data);
      var data = await result.data!['launches'] as List;
      data.forEach((element) {
        list.add(Mission.fromJson(data: element));
      });
    }
    return list;
  }
}

  // inFuture() async {
  //   QueryResult result =
  //       await _config.query(QueryOptions(document: gql(Myquery().getAll())));

  //   if (result.hasException) {
  //     print("error");
  //   } else if (result.isLoading) {
  //     print("is loading");
  //   } else {
  //     print(result.data);
  //   }
  // }