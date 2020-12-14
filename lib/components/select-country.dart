import 'package:baraka/models/country.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

class SelectCountry extends StatefulWidget {
  @override
  _SelectCountryState createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  List<Country> countries;
  String selectedCountry;
  selectCountry(String val) {
    print(val);
    setState(() => selectedCountry = val);
  }

  @override
  void initState() {
    super.initState();
    countries = [
      Country(id: "1", name: "الدولة"),
      Country(id: "2", name: "asd"),
      Country(id: "3", name: "lkj")
    ];
    setState(() {
      selectedCountry = countries.first.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(child: General.buildTxt(txt: "الدولة", isBold: true)),
        SearchChoices.single(
          items: countries.map((country) {
            return DropdownMenuItem(
              child: General.buildTxt(txt: country.name),
              value: country.name,
            );
          }).toList(),
          value: selectedCountry,
          hint: "الدولة",
          closeButton: "اغلاق",
          searchHint: "ابحث عن الدولة",
          rightToLeft: true,
          style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat'),
          onChanged: (value) => selectCountry(value),
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
