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
      case "ironI":
        elo = Elo.ironI;
        break;
      case "ironII":
        elo = Elo.ironII;
        break;
      case "ironIII":
        elo = Elo.ironIII;
        break;
      case "bronzeI":
        elo = Elo.bronzeI;
        break;
      case "bronzeII":
        elo = Elo.bronzeII;
        break;
      case "bronzeIII":
        elo = Elo.bronzeIII;
        break;
      case "silverI":
        elo = Elo.silverI;
        break;
      case "silverII":
        elo = Elo.silverII;
        break;
      case "silverIII":
        elo = Elo.silverIII;
        break;
      case "goldI":
        elo = Elo.goldI;
        break;
      case "goldII":
        elo = Elo.goldII;
        break;
      case "goldIII":
        elo = Elo.goldIII;
        break;
      case "platinumI":
        elo = Elo.platinumI;
        break;
      case "platinumII":
        elo = Elo.platinumII;
        break;
      case "platinumIII":
        elo = Elo.platinumIII;
        break;
      case "diamondI":
        elo = Elo.diamondI;
        break;
      case "diamondII":
        elo = Elo.diamondII;
        break;
      case "diamondIII":
        elo = Elo.diamondIII;
        break;
      case "ascendantI":
        elo = Elo.ascendantI;
        break;
      case "ascendantII":
        elo = Elo.ascendantII;
        break;
      case "ascendantIII":
        elo = Elo.ascendantIII;
        break;
      case "immortalI":
        elo = Elo.immortalI;
        break;
      case "immortalII":
        elo = Elo.immortalII;
        break;
      case "immortalIII":
        elo = Elo.immortalIII;
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
