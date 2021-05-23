import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:praktikum_5/constants.dart';
import 'package:praktikum_5/models/LiveMatchesModel.dart';
import 'package:praktikum_5/models/SteamUserModel.dart';

class SteamApiService {
  static Future<http.Response> findSteamID({String steam_id}) async {
    try {
      return await http
          .get(Uri.parse('https://api.opendota.com/api/players/${steam_id}'));
    } catch (error) {
      return error;
    }
  }

  static Future<http.Response> getLiveMatch() async {
    try {
      return await http.get(Uri.parse('https://api.opendota.com/api/live'));
    } catch (error) {
      return error;
    }
  }
}
