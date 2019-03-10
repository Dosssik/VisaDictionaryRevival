import 'package:flutter/material.dart';
import 'package:give_me_visa/db/database.dart';
import 'package:give_me_visa/screens/country_description.dart';
import 'package:give_me_visa/entity/country.dart';

// ROAD MAP
// DONE - Кешировать страны после доставния из базы
// - Прикрутить фильтры
// - Поправить верстку на экране с подробностями
// - Прикрутить оставшующся инфу на экран с подробностями
// DONE - Поиск
// - Алерт диалоги
// - Обновить БД
// - Запустить на iOS
// - Разобраться с публикацией iOS
// - РЕЛИЗ!

class CountriesListRoute extends StatefulWidget {
  @override
  _CountriesListRouteState createState() => _CountriesListRouteState();
}

class _CountriesListRouteState extends State<CountriesListRoute> {
  var _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = Text("Дайте визу");
  final TextEditingController _filter = new TextEditingController();
  String searchText = "";

  _CountriesListRouteState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        searchText = "";
        setState(() {});
      } else {
        searchText = _filter.text;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle, // TODO Сделать файлик со стрингами
        actions: <Widget>[
          IconButton(icon: _searchIcon, onPressed: _searchPressed)
        ],
      ),
      body: FutureBuilder<List<Country>>(
          future: DBProvider.db.getCountries(searchText),
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

  _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Поиск страны...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Дайте визу');
      }
    });
  }
}
