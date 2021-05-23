import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart';
import 'package:praktikum_5/models/SteamUserModel.dart';
import 'package:praktikum_5/services/SteamApiService.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchSteamUser extends StatefulWidget {
  @override
  _SearchSteamUser createState() => _SearchSteamUser();
}

class _SearchSteamUser extends State<SearchSteamUser> {
  String steamID = '';
  Profile accountProfile;
  int mmrEstimate = 0;
  bool loading;
  bool error = false;

  Future<dynamic> searchAccount({String steamId}) async {
    try {
      Map<String, dynamic> account;
      Response res = await SteamApiService.findSteamID(steam_id: steamId);
      var data = jsonDecode(res.body);
      return SteamAccountModel.fromMap(data as Map<String, dynamic>);
    } catch (error) {
      return error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      width: double.infinity,
      height: double.infinity,
      child: Neumorphic(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _TextField(
                  label: 'Steam ID',
                  hint: 'Input your Steam ID',
                  onChanged: (steamID) {
                    setState(() {
                      this.steamID = steamID;
                    });
                  }),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: NeumorphicButton(
                  child: Text('Search',
                      style: TextStyle(
                          color: NeumorphicTheme.defaultTextColor(context))),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });

                    var steamAccount;

                    try {
                      steamAccount = await searchAccount(steamId: steamID);
                      setState(() {
                        error = false;
                      });
                    } catch (e) {
                      print(e);
                      setState(() {
                        error = true;
                        loading = false;
                      });
                    } finally {
                      setState(() {
                        accountProfile = steamAccount.profile;
                        mmrEstimate = steamAccount.mmrEstimate.estimate;
                        loading = false;
                      });
                    }
                  },
                ),
              ),
              Conditional.single(
                context: context,
                conditionBuilder: (BuildContext context) => loading,
                widgetBuilder: (BuildContext context) => Center(
                  child: Text('Please wait...'),
                ),
                fallbackBuilder: (BuildContext context) => Conditional.single(
                    context: context,
                    conditionBuilder: (BuildContext context) =>
                        accountProfile != null,
                    widgetBuilder: (BuildContext context) => AccountWidget(
                        profile: accountProfile, mmrEstimate: mmrEstimate),
                    fallbackBuilder: (BuildContext context) =>
                        Center(child: Text(''))),
              ),
            ]),
      ),
    );
  }
}

class AccountWidget extends StatefulWidget {
  final Profile profile;
  final int mmrEstimate;

  AccountWidget({@required this.profile, this.mmrEstimate});

  @override
  _AccountWidget createState() => _AccountWidget();
}

class _AccountWidget extends State<AccountWidget> {
  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      // height: double.infinity,
      child: Padding(
          padding: EdgeInsets.all(7),
          child: Neumorphic(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Image.network(
                  widget.profile.avatarfull,
                  width: 60,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.profile.personaname,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: NeumorphicTheme.defaultTextColor(context))),
                    GestureDetector(
                      onTap: () {
                        _launchURL(widget.profile.profileurl);
                      },
                      child: Text('See Profile on Web',
                          style: TextStyle(
                              color:
                                  NeumorphicTheme.defaultTextColor(context))),
                    ),
                  ],
                ),
                SizedBox(width: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('MMR',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: NeumorphicTheme.defaultTextColor(context))),
                    Text('${widget.mmrEstimate}',
                        style: TextStyle(
                            color: NeumorphicTheme.defaultTextColor(context)))
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class _TextField extends StatefulWidget {
  final String label;
  final String hint;

  final ValueChanged<String> onChanged;

  _TextField({@required this.label, @required this.hint, this.onChanged});

  @override
  __TextFieldState createState() => __TextFieldState();
}

class __TextFieldState extends State<_TextField> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            this.widget.label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
        ),
        Neumorphic(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          style: NeumorphicStyle(
            depth: NeumorphicTheme.embossDepth(context),
            boxShape: NeumorphicBoxShape.stadium(),
          ),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: TextField(
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
            onChanged: this.widget.onChanged,
            controller: _controller,
            decoration: InputDecoration.collapsed(
                hintText: this.widget.hint,
                hintStyle: TextStyle(
                    color: NeumorphicTheme.defaultTextColor(context))),
          ),
        )
      ],
    );
  }
}
