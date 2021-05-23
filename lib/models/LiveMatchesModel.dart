import 'dart:convert';

List<LiveMatchesModel> modelUserFromJson(String str) =>
    List<LiveMatchesModel>.from(
        json.decode(str).map((x) => LiveMatchesModel.fromMap(x)));
String modelUserToJson(List<LiveMatchesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class LiveMatchesModel {
  LiveMatchesModel({
    this.activateTime,
    this.deactivateTime,
    this.serverSteamId,
    this.lobbyId,
    this.leagueId,
    this.lobbyType,
    this.gameTime,
    this.delay,
    this.spectators,
    this.gameMode,
    this.averageMmr,
    this.matchId,
    this.seriesId,
    this.sortScore,
    this.lastUpdateTime,
    this.radiantLead,
    this.radiantScore,
    this.direScore,
    this.players,
    this.buildingState,
    this.customGameDifficulty,
  });

  int activateTime;
  int deactivateTime;
  String serverSteamId;
  String lobbyId;
  int leagueId;
  int lobbyType;
  int gameTime;
  int delay;
  int spectators;
  int gameMode;
  int averageMmr;
  String matchId;
  int seriesId;
  int sortScore;
  int lastUpdateTime;
  int radiantLead;
  int radiantScore;
  int direScore;
  List<dynamic> players;
  int buildingState;
  int customGameDifficulty;

  factory LiveMatchesModel.fromMap(Map<String, dynamic> json) =>
      LiveMatchesModel(
        activateTime: json["activate_time"] ?? null,
        deactivateTime: json["deactivate_time"] ?? null,
        serverSteamId: json["server_steam_id"] ?? "",
        lobbyId: json["lobby_id"] ?? "",
        leagueId: json["league_id"] ?? null,
        lobbyType: json["lobby_type"] ?? null,
        gameTime: json["game_time"] ?? null,
        delay: json["delay"] ?? null,
        spectators: json["spectators"] ?? null,
        gameMode: json["game_mode"] ?? null,
        averageMmr: json["average_mmr"] ?? null,
        matchId: json["match_id"] ?? "",
        seriesId: json["series_id"] ?? null,
        sortScore: json["sort_score"] ?? null,
        lastUpdateTime: json["last_update_time"] ?? null,
        radiantLead: json["radiant_lead"] ?? null,
        radiantScore: json["radiant_score"] ?? null,
        direScore: json["dire_score"] ?? null,
        players:
            List<Player>.from(json["players"].map((x) => Player.fromMap(x))) ??
                null,
        buildingState: json["building_state"] ?? null,
        customGameDifficulty: json["custom_game_difficulty"] ?? null,
      );

  Map<String, dynamic> toMap() => {
        "activate_time": activateTime,
        "deactivate_time": deactivateTime,
        "server_steam_id": serverSteamId,
        "lobby_id": lobbyId,
        "league_id": leagueId,
        "lobby_type": lobbyType,
        "game_time": gameTime,
        "delay": delay,
        "spectators": spectators,
        "game_mode": gameMode,
        "average_mmr": averageMmr,
        "match_id": matchId,
        "series_id": seriesId,
        "sort_score": sortScore,
        "last_update_time": lastUpdateTime,
        "radiant_lead": radiantLead,
        "radiant_score": radiantScore,
        "dire_score": direScore,
        "players": List<dynamic>.from(players.map((x) => x.toMap())),
        "building_state": buildingState,
        "custom_game_difficulty": customGameDifficulty,
      };
}

class Player {
  Player({
    this.accountId,
    this.heroId,
    this.name,
    this.country_code,
    this.fantasyRole,
    this.teamId,
    this.teamName,
    this.teamTag,
    this.isLocked,
    this.isPro,
    this.lockedUntil,
  });

  int accountId;
  int heroId;
  String name;
  String country_code;
  int fantasyRole;
  int teamId;
  String teamName;
  String teamTag;
  bool isLocked;
  bool isPro;
  dynamic lockedUntil;

  factory Player.fromMap(Map<String, dynamic> json) => Player(
        accountId: json["account_id"] ?? null,
        heroId: json["hero_id"] ?? null,
        name: json["name"] == null ? "" : json["name"],
        country_code: json["country_code"] == null ? "" : json["country_code"],
        fantasyRole: json["fantasy_role"] == null ? null : json["fantasy_role"],
        teamId: json["team_id"] == null ? null : json["team_id"],
        teamName: json["team_name"] == null ? "" : json["team_name"],
        teamTag: json["team_tag"] == null ? "" : json["team_tag"],
        isLocked: json["is_locked"] == null ? null : json["is_locked"],
        isPro: json["is_pro"] == null ? null : json["is_pro"],
        lockedUntil: json["locked_until"] ?? null,
      );

  Map<String, dynamic> toMap() => {
        "account_id": accountId == null ? null : accountId,
        "hero_id": heroId == null ? null : heroId,
        "name": name == null ? null : name,
        "country_code": country_code == null ? null : country_code,
        "fantasy_role": fantasyRole == null ? null : fantasyRole,
        "team_id": teamId == null ? null : teamId,
        "team_name": teamName == null ? null : teamName,
        "team_tag": teamTag == null ? null : teamTag,
        "is_locked": isLocked == null ? null : isLocked,
        "is_pro": isPro == null ? null : isPro,
        "locked_until": lockedUntil == null ? null : lockedUntil,
      };
}
