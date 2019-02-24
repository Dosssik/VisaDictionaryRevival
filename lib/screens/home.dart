import 'package:flutter/material.dart';
import 'package:give_me_visa/db/database.dart';
import 'package:give_me_visa/screens/country_description.dart';
import 'package:give_me_visa/entity/country.dart';

class CountriesListRoute extends StatefulWidget {
  @override
  _CountriesListRouteState createState() => _CountriesListRouteState();
}

class _CountriesListRouteState extends State<CountriesListRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Дайте визу"),
      ),
      body: FutureBuilder<List<Country>>(
          future: DBProvider.db.getCountries(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Country>> snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemCount: snapshot.data.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    var country = snapshot.data[index];
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        width: 48,
                        height: 48,
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  country.getAssetImagePath(),
                                ))),
                      ),
                      title: Text(country.countryName),
                      subtitle: Text(country.flag),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CountryDescription(country)),
                        );
                      },
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
