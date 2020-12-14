import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/blocs/category_bloc.dart';
import 'package:baraka/screens/category-products/category-products.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesBar extends StatefulWidget {
  @override
  _CategoriesBarState createState() => _CategoriesBarState();
}

class _CategoriesBarState extends State<CategoriesBar> {
  CategoryBloc categoryBloc;

  openCategoryScreen() {
    Navigator.push(
        context, ScaleTransationRoute(page: CategoryProductsScreen()));
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(Duration(milliseconds: 100));
    categoryBloc = Provider.of<CategoryBloc>(context, listen: false);
    categoryBloc.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryBloc>(builder: (BuildContext context, state, __) {
      if (state.error != null) {
        return Center(child: General.buildTxt(txt: state.error));
      } else if (!state.waiting) {
        return Container(
          height: 20,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                return state.categories.length > 0
                    ? Container(
                        //height: 200,
                        child: _tabItem(
                            title: state.categories[index].name.toString(),
                            context: context),
                      )
                    : Container(
                        child: Center(
                          child: Text(('no cats found')),
                        ),
                      );
              }),
        );
      } else {
        return Center(
            child: General.customThreeBounce(context,
                color: Theme.of(context).primaryColor, size: 30.0));
      }
    });
  }

  buildCategoryList(CategoryBloc state) {
    return state.categories.isNotEmpty
        ? ListView.builder(
            itemCount: state.categories.length,
            padding: EdgeInsets.only(
                bottom: 20.0, left: 15.0, right: 15.0, top: 20.0),
            itemBuilder: (BuildContext context, int index) {
              return _tabItem(
                title: state.categories[index].name,
              );
            })
        : Container(
            child: Center(child: Text('NO_Categories')),
          );
  }

  _tabItem({String title, BuildContext context}) {
    return GestureDetector(
      onTap: () => openCategoryScreen(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: General.buildTxt(txt: title),
      ),
    );
  }
}
