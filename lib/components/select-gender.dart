import 'package:baraka/models/gender.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

class SelectGender extends StatefulWidget {
  final Function selectedGender;
  SelectGender({@required this.selectedGender});
  @override
  _SelectGenderState createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  String selectedGender;
  List<Gender> genders = [
    Gender(id: 1, textAr: "ذكر"),
    Gender(id: 2, textAr: "انثي")
  ];
  selectGender(String gender) {
    widget.selectedGender(int.parse(gender));
    setState(() => selectedGender = gender);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.white),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black38))),
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              child: DropdownButton(
                hint: General.buildTxt(txt: "الجنس"),
                underline: Container(
                  height: 0,
                  color: Colors.black12,
                ),
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down),
                items: genders.map((gender) {
                  return DropdownMenuItem<String>(
                    value: gender.id.toString(),
                    child: General.buildTxt(
                        txt: gender.textAr,
                        color: Colors.black,
                        fontSize: 14.0),
                  );
                }).toList(),
                value: selectedGender,
                onChanged: (String gender) => selectGender(gender),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
