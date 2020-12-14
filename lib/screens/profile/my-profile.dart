import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/screens/profile/edit-profile.dart';
import 'package:baraka/blocs/profile_bloc.dart';
import 'package:baraka/widgets/general.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'change-password.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  ProfileBloc _profileBloc;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(Duration(milliseconds: 100));
    _profileBloc = Provider.of<ProfileBloc>(context, listen: false);
    _profileBloc.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: General.arrowAppBar(),
      body: Consumer<ProfileBloc>(builder: (BuildContext context, state, __) {
        if (state.error != null) {
          return Center(child: General.buildTxt(txt: state.error));
        } else if (!state.waiting) {
          return Container(
            padding: EdgeInsets.all(15.0),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                General.buildTxt(
                    txt:
                        "${state.user.userInfo.fname} ${state.user.userInfo.lname}",
                    fontSize: 16.0,
                    isBold: true),
                General.sizeBoxVerical(5.0),
                General.buildTxt(
                    txt: state.user.userInfo.email,
                    fontSize: 14.0,
                    color: Colors.grey),
                General.sizeBoxVerical(30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    General.buildTxt(
                        txt: "المعلومات الشخصية", fontSize: 16.0, isBold: true),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            ScaleTransationRoute(
                                page: EditProfileScreen(
                              user: state.user,
                            )));
                      },
                      child: General.buildTxt(
                          txt: "تعديل",
                          fontSize: 14.0,
                          color: Theme.of(context).accentColor),
                    ),
                  ],
                ),
                General.sizeBoxVerical(20.0),
                _buildStaticField(
                    title: "الاسم الاول", value: state.user.userInfo.fname),
                General.sizeBoxVerical(20.0),
                _buildStaticField(
                    title: "الاسم الاخير", value: state.user.userInfo.lname),
                General.sizeBoxVerical(20.0),
                General.buildTxt(
                    txt: "حماية المعلومات", fontSize: 16.0, isBold: true),
                General.sizeBoxVerical(20.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        ScaleTransationRoute(page: ChangePasswordScreen()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: DottedBorder(
                      color: Theme.of(context).accentColor.withOpacity(0.6),
                      strokeWidth: 1,
                      radius: Radius.circular(5.0),
                      strokeCap: StrokeCap.butt,
                      borderType: BorderType.RRect,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(15.0),
                        child: General.buildTxt(
                          txt: "تغيير كلمة المرور",
                          fontSize: 14.0,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
          );
        } else {
          return Center(
              child: General.customThreeBounce(context,
                  color: Theme.of(context).primaryColor, size: 30.0));
        }
      }),
    );
  }

  _buildStaticField({String title, value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        General.buildTxt(
          txt: title,
          fontSize: 14.0,
        ),
        General.sizeBoxVerical(10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            General.buildTxt(
              txt: value,
              isBold: true,
              fontSize: 14.0,
            ),
            Divider()
          ],
        )
      ],
    );
  }
}
