import 'package:flutter/material.dart';
import 'package:give_me_visa/db/Database.dart';
import 'package:give_me_visa/entity/Country.dart';

class CountriesListPage extends StatefulWidget {
  @override
  _CountriesListPageState createState() => _CountriesListPageState();
}

class _CountriesListPageState extends State<CountriesListPage> {

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
                        );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
