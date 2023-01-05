import "package:flutter/material.dart";
import 'package:kanvalorant/extensions/elo_enum_extension.dart';
import 'package:kanvalorant/utils/elo_images.dart';
import 'package:transparent_image/transparent_image.dart';

import '../enums/elo_enum.dart';
import '../models/account_model.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.account});

  final AccountModel account;

  String imageSrcFromElo() {
    switch (account.elo) {
      case Elo.unranked:
        return unrankedSrc;
      case Elo.iron:
        return ironSrc;
      case Elo.bronze:
        return bronzeSrc;
      case Elo.silver:
        return silverSrc;
      case Elo.gold:
        return goldSrc;
      case Elo.platinum:
        return platinumSrc;
      case Elo.diamond:
        return diamondSrc;
      case Elo.immortal:
        return immortalSrc;
      case Elo.ascendant:
        return ascendantSrc;
      case Elo.radiant:
        return radiantSrc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FadeInImage.memoryNetwork(
          width: 40,
          height: 40,
          placeholder: kTransparentImage,
          image: imageSrcFromElo(),
          fit: BoxFit.cover,
        ),
        title: Text("Login: ${account.login}"),
        subtitle: Text(
            "Nível: ${account.level}\nElo: ${account.elo.toFormatedString()}"),
        trailing: const Icon(Icons.list),
      ),
    );
  }
}
