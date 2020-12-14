import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/models/category.dart';
import 'package:baraka/screens/category-products/category-products.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baraka/blocs/category_bloc.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  CategoryBloc categoryBloc;

  init() async {
    await Future.delayed(Duration(milliseconds: 200));
    categoryBloc = Provider.of<CategoryBloc>(context, listen: false);
    categoryBloc.getCategories();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  openCatProductsPage(Category category) {
    print('category is :${category.id}');
    Navigator.push(
        context,
        ScaleTransationRoute(
            page: CategoryProductsScreen(
          categoryId: category.id,
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Icon(Icons.menu),
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                'assets/imgs/basket.png',
                width: 30.0,
              ),
              onPressed: () {})
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Consumer<CategoryBloc>(
              builder: (BuildContext context, state, __) {
            if (state.error != null) {
              return Center(child: General.buildTxt(txt: state.error));
            } else if (!state.waiting) {
              return GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                shrinkWrap: true,
                children: List.generate(state.categories.length, (index) {
                  return GestureDetector(
                    onTap: () => openCatProductsPage(state.categories[index]),
                    child: Column(
                      children: <Widget>[
                        FadeInImage.assetNetwork(
                          image: state.categories[index].imageUrl != null
                              ? state.categories[index].imageUrl
                              : "",
                          placeholder: "assets/imgs/placeholder.png",
                          height: 100.0,
                          width: 100.0,
                        ),
                        General.sizeBoxVerical(10.0),
                        General.buildTxt(
                            txt: state.categories[index].name.toString())
                      ],
                    ),
                  );
                }),
              );
            } else {
              return Center(
                  child: General.customThreeBounce(context,
                      color: Theme.of(context).primaryColor, size: 30.0));
            }
          }),
        ),
      ),
    );
  }
}
