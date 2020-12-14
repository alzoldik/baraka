import 'package:baraka/models/city.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

class SelectCity extends StatefulWidget {
  @override
  _SelectCityState createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  List<City> cities;
  String selectedCity;
  selectCity(String val) {
    setState(() => selectedCity = val);
  }

  @override
  void initState() {
    super.initState();
    cities = [
      City(id: "1", name: "المدينة"),
      City(id: "2", name: "جده"),
      City(id: "3", name: "الرياض")
    ];
    setState(() {
      selectedCity = cities.first.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(child: General.buildTxt(txt: "المدينة", isBold: true)),
        SearchChoices.single(
          items: cities.map((country) {
            return DropdownMenuItem(
              child: General.buildTxt(txt: country.name),
              value: country.name,
            );
          }).toList(),
          value: selectedCity,
          hint: "المدينة",
          closeButton: "اغلاق",
          searchHint: "ابحث عن المدينة",
          rightToLeft: true,
          style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat'),
          onChanged: (value) => selectCity(value),
          icon: Container(
            child: Container(
              width: 0.0,
              height: 0.0,
            ),
          ),
          isExpanded: true,
          underline: Container(
            padding: EdgeInsets.all(20.0),
            height: 1.0,
            color: Color(General.getColorHexFromStr('#757474')),
          ),
          displayClearIcon: false,
        ),
        Positioned(
            left: 0.0,
            top: 20.0,
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black54,
            ))
      ],
    );
  }
}
