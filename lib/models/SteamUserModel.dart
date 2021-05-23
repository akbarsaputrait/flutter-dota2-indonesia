class SteamAccountModel {
  SteamAccountModel({
    this.trackedUntil,
    this.soloCompetitiveRank,
    this.competitiveRank,
    this.leaderboardRank,
    this.profile,
    this.rankTier,
    this.mmrEstimate,
  });

  dynamic trackedUntil;
  dynamic soloCompetitiveRank;
  dynamic competitiveRank;
  dynamic leaderboardRank;
  Profile profile;
  int rankTier;
  MmrEstimate mmrEstimate;

  factory SteamAccountModel.fromMap(Map<String, dynamic> json) =>
      SteamAccountModel(
        trackedUntil: json["tracked_until"] ?? null,
        soloCompetitiveRank: json["solo_competitive_rank"] ?? null,
        competitiveRank: json["competitive_rank"] ?? null,
        leaderboardRank: json["leaderboard_rank"] ?? null,
        profile: Profile.fromMap(json["profile"]) ?? null,
        rankTier: json["rank_tier"] ?? null,
        mmrEstimate: MmrEstimate.fromMap(json["mmr_estimate"]) ?? null,
      );

  Map<String, dynamic> toMap() => {
        "tracked_until": trackedUntil,
        "solo_competitive_rank": soloCompetitiveRank,
        "competitive_rank": competitiveRank,
        "leaderboard_rank": leaderboardRank,
        "profile": profile.toMap(),
        "rank_tier": rankTier,
        "mmr_estimate": mmrEstimate.toMap(),
      };
}

class MmrEstimate {
  MmrEstimate({
    this.estimate,
  });

  int estimate;

  factory MmrEstimate.fromMap(Map<String, dynamic> json) => MmrEstimate(
        estimate: json["estimate"],
      );

  Map<String, dynamic> toMap() => {
        "estimate": estimate,
      };
}

class Profile {
  Profile({
    this.accountId,
    this.personaname,
    this.name,
    this.plus,
    this.cheese,
    this.steamid,
    this.avatar,
    this.avatarmedium,
    this.avatarfull,
    this.profileurl,
    this.lastLogin,
    this.loccountrycode,
    this.isContributor,
  });

  int accountId;
  String personaname;
  dynamic name;
  bool plus;
  int cheese;
  String steamid;
  String avatar;
  String avatarmedium;
  String avatarfull;
  String profileurl;
  dynamic lastLogin;
  String loccountrycode;
  bool isContributor;

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
        accountId: json["account_id"] ?? null,
        personaname: json["personaname"] ?? "",
        name: json["name"] ?? null,
        plus: json["plus"] ?? null,
        cheese: json["cheese"] ?? null,
        steamid: json["steamid"] ?? "",
        avatar: json["avatar"] ?? "",
        avatarmedium: json["avatarmedium"] ?? "",
        avatarfull: json["avatarfull"] ?? "",
        profileurl: json["profileurl"] ?? "",
        lastLogin: json["last_login"] ?? null,
        loccountrycode: json["loccountrycode"] ?? "",
        isContributor: json["is_contributor"] ?? null,
      );

  Map<String, dynamic> toMap() => {
        "account_id": accountId,
        "personaname": personaname,
        "name": name,
        "plus": plus,
        "cheese": cheese,
        "steamid": steamid,
        "avatar": avatar,
        "avatarmedium": avatarmedium,
        "avatarfull": avatarfull,
        "profileurl": profileurl,
        "last_login": lastLogin,
        "loccountrycode": loccountrycode,
        "is_contributor": isContributor,
      };
}
