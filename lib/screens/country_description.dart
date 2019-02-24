import 'package:flutter/material.dart';
import 'package:give_me_visa/entity/country.dart';

class CountryDescription extends StatelessWidget {
  final Country country;

  CountryDescription(this.country);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Image.asset(
                  country.getAssetImagePath(),
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(country.countryName, textScaleFactor: 2),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  child: Text(country.description, textScaleFactor: 1.2),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}