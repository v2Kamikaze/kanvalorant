import 'package:kanvalorant/enums/elo_enum.dart';

class AccountModel {
  String login = "";
  int level = 0;
  Elo elo = Elo.unranked;

  AccountModel(this.login, this.level, this.elo);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["login"] = login;
    data["level"] = level;
    data["elo"] = elo.name;
    return data;
  }

  AccountModel.fromJson(Map<String, dynamic> json) {
    Elo elo = Elo.unranked;
    switch (json["elo"]) {
      case "unraked":
        elo = Elo.unranked;
        break;
      case "iron":
        elo = Elo.iron;
        break;
      case "bronze":
        elo = Elo.bronze;
        break;
      case "silver":
        elo = Elo.silver;
        break;
      case "gold":
        elo = Elo.gold;
        break;
      case "platinum":
        elo = Elo.platinum;
        break;
      case "diamond":
        elo = Elo.diamond;
        break;
      case "ascendant":
        elo = Elo.ascendant;
        break;
      case "immortal":
        elo = Elo.immortal;
        break;
      case "radiant":
        elo = Elo.radiant;
        break;
    }

    login = json["login"];
    level = json["level"];
    this.elo = elo;
  }

  @override
  String toString() {
    return "($login | $elo | $level)";
  }
}
