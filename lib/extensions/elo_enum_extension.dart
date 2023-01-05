import '../enums/elo_enum.dart';

extension EloExtension on Elo {
  String toFormatedString() {
    switch (this) {
      case Elo.unranked:
        return "Unranked";
      case Elo.iron:
        return "Ferro";
      case Elo.bronze:
        return "Bronze";
      case Elo.silver:
        return "Prata";
      case Elo.gold:
        return "Ouro";
      case Elo.platinum:
        return "Platina";
      case Elo.diamond:
        return "Diamante";
      case Elo.immortal:
        return "Imortal";
      case Elo.ascendant:
        return "Ascendente";
      case Elo.radiant:
        return "Radiante";
    }
  }
}
