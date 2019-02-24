import 'package:flutter/material.dart';
import 'package:give_me_visa/db/database.dart';
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
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    var country = snapshot.data[index];
                        return ListTile(
                          title: Text(country.countryName),
                          subtitle: Text(country.flag),
                          onTap: _openDescriptionScreen(country.id),
                        );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  _openDescriptionScreen(int id) {

  }

}
