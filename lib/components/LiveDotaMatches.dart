import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:praktikum_5/models/LiveMatchesModel.dart';
import 'package:praktikum_5/services/SteamApiService.dart';
import 'package:responsive_grid/responsive_grid.dart';

class LiveDotaMatches extends StatefulWidget {
  @override
  _LiveDotaMatchesState createState() => _LiveDotaMatchesState();
}

class _LiveDotaMatchesState extends State<LiveDotaMatches> {
  List<LiveMatchesModel> filter({dynamic data, String countryCode}) {
    List<LiveMatchesModel> _liveMatches = [];
    List<LiveMatchesModel> _result = [];

    var result = jsonDecode(data);

    for (Map i in result) {
      _liveMatches.add(LiveMatchesModel.fromMap(i));
    }

    _liveMatches.forEach((match) {
      List<Player> players = [];

      match.players.forEach((player) {
        if (player.country_code != "" && player.country_code == countryCode) {
          players.add(Player(name: player.name, teamTag: player.teamTag));
        }
      });

      _result.add(LiveMatchesModel(matchId: match.matchId, players: players));
    });

    return _result.where((item) => item.players.length > 0).toList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: SteamApiService.getLiveMatch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return NeumorphicButton(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(Icons.sync,
                    color: NeumorphicTheme.defaultTextColor(context)),
                SizedBox(
                  width: 10,
                ),
                Text('Fetch data',
                    style: TextStyle(
                        color: NeumorphicTheme.defaultTextColor(context)))
              ],
            ),
            onPressed: null,
          );
        } else {
          List<LiveMatchesModel> matches =
              filter(data: snapshot.data.body, countryCode: 'id');
          return CarouselSlider(
            options: CarouselOptions(
              height: 260.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              enableInfiniteScroll: false,
              viewportFraction: 0.8,
            ),
            items: matches.map((match) {
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        // alignment: Alignment(0, 0),
                        child: Neumorphic(
                            child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(7),
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Text('Match ID:',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: NeumorphicTheme
                                                    .defaultTextColor(
                                                        context))),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(match.matchId ?? "-",
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                                color: NeumorphicTheme
                                                    .defaultTextColor(context)))
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.all(7),
                                    child: Text('Player List:',
                                        style: TextStyle(
                                            color: NeumorphicTheme
                                                .defaultTextColor(context)))),
                                Padding(
                                    padding: EdgeInsets.all(7),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                          match.players.length, (indexPlayer) {
                                        return Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: NeumorphicTheme
                                                  .defaultTextColor(context),
                                              size: 14.0,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                                match.players[indexPlayer]
                                                            .teamTag +
                                                        "." ??
                                                    "-",
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: NeumorphicTheme
                                                        .defaultTextColor(
                                                            context))),
                                            Text(
                                                match.players[indexPlayer]
                                                        .name ??
                                                    "-",
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: NeumorphicTheme
                                                        .defaultTextColor(
                                                            context))),
                                          ],
                                        );
                                      }),
                                    ))
                              ]),
                        )),
                      ));
                },
              );
            }).toList(),
          );
          //   return Container(
          //       width: double.infinity,
          //       height: double.infinity,
          //       child: SingleChildScrollView(
          //           child: ResponsiveGridRow(
          //         children: List.generate(
          //           matches.length,
          //           (index) {
          //             return ResponsiveGridCol(
          //               lg: 12,
          //               child: ,
          //             );
          //           },
          //         ),
          //       )));
        }
      },
    );
  }
}
