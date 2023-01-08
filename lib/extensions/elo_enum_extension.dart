import '../enums/elo_enum.dart';

extension EloExtension on Elo {
  String toFormatedString() {
    switch (this) {
      case Elo.unranked:
        return "Unranked";
      case Elo.ironI:
        return "Ferro I";
      case Elo.ironII:
        return "Ferro II";
      case Elo.ironIII:
        return "Ferro III";
      case Elo.bronzeI:
        return "Bronze I";
      case Elo.bronzeII:
        return "Bronze II";
      case Elo.bronzeIII:
        return "Bronze III";
      case Elo.silverI:
        return "Prata I";
      case Elo.silverII:
        return "Prata II";
      case Elo.silverIII:
        return "Prata III";
      case Elo.goldI:
        return "Ouro I";
      case Elo.goldII:
        return "Ouro II";
      case Elo.goldIII:
        return "Ouro III";
      case Elo.platinumI:
        return "Platina I";
      case Elo.platinumII:
        return "Platina II";
      case Elo.platinumIII:
        return "Platina III";
      case Elo.diamondI:
        return "Diamante I";
      case Elo.diamondII:
        return "Diamante II";
      case Elo.diamondIII:
        return "Diamante III";
      case Elo.ascendantI:
        return "Ascendente I";
      case Elo.ascendantII:
        return "Ascendente II";
      case Elo.ascendantIII:
        return "Ascendente III";
      case Elo.immortalI:
        return "Imortal I";
      case Elo.immortalII:
        return "Imortal II";
      case Elo.immortalIII:
        return "Imortal III";
      case Elo.radiant:
        return "Radiante";
    }
  }
}
