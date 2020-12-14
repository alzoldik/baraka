import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/blocs/category_bloc.dart';
import 'package:baraka/components/horizontial-product-item.dart';
import 'package:baraka/components/product-item.dart';
import 'package:baraka/screens/category-products/filter.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryProductsScreen extends StatefulWidget {
  final num categoryId;
  CategoryProductsScreen({this.categoryId});
  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  CategoryBloc _categoryBloc;
  PersistentBottomSheetController _bottomSheetController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  num selectedSortedWay = 0;
  bool isGrid = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(Duration(milliseconds: 100));
    _categoryBloc = Provider.of<CategoryBloc>(context, listen: false);
    _categoryBloc.getCategoryProducts(catId: widget.categoryId);
  }

  openBottomSheet() async {
    _bottomSheetController =
        _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.bottomCenter,
        color: Colors.black12.withOpacity(0.1),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      General.sizeBoxVerical(40.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: General.buildTxt(
                            txt: "ترتيب حسب", isBold: true, fontSize: 16.0),
                      ),
                      General.sizeBoxVerical(20.0),
                      RadioListTile(
                        value: 0,
                        groupValue: selectedSortedWay,
                        title: General.buildTxt(
                            txt: "الاكثر شعبية", isCenter: false),
                        onChanged: (val) {
                          print("Radio Tile pressed $val");
                        },
                        dense: true,
                        activeColor: Theme.of(context).accentColor,
                        selected: false,
                      ),
                      Divider(),
                      RadioListTile(
                        value: 0,
                        groupValue: selectedSortedWay,
                        title: General.buildTxt(
                            txt: "السعر الادني الي الاعلي", isCenter: false),
                        onChanged: (val) {
                          print("Radio Tile pressed $val");
                        },
                        dense: true,
                        activeColor: Theme.of(context).accentColor,
                        selected: false,
                      ),
                      Divider(),
                      RadioListTile(
                        value: 0,
                        groupValue: selectedSortedWay,
                        title: General.buildTxt(
                            txt: "السعر من الارخص للاعلي", isCenter: false),
                        onChanged: (val) {
                          print("Radio Tile pressed $val");
                        },
                        dense: true,
                        activeColor: Theme.of(context).accentColor,
                        selected: false,
                      )
                    ],
                  ),
                )),
            Positioned(
              top: -20.0,
              left: 20.0,
              child: InkWell(
                onTap: () {
                  _bottomSheetController.close();
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(100.0)),
                  child: Icon(Icons.close),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: General.arrowAppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                color: Color(General.getColorHexFromStr('#FAFAFA')),
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            ScaleTransationRoute(page: FilterScreen()));
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            General.buildTxt(txt: "تصفية حساب"),
                            General.sizeBoxHorizontial(5.0),
                            Icon(Icons.filter_list)
                          ],
                        ),
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () => openBottomSheet(),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            General.buildTxt(txt: "ترتيب حسب"),
                            General.sizeBoxHorizontial(5.0),
                            Icon(Icons.filter_list)
                          ],
                        ),
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        setState(() {
                          isGrid = !isGrid;
                        });
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            General.buildTxt(txt: "عرض"),
                            General.sizeBoxHorizontial(5.0),
                            Icon(Icons.filter_list)
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              General.sizeBoxVerical(20.0),
              Consumer<CategoryBloc>(
                  builder: (BuildContext context, state, __) {
                if (state.error != null) {
                  return Center(child: General.buildTxt(txt: state.error));
                } else if (!state.waiting) {
                  return isGrid
                      ? GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 1.0),
                          shrinkWrap: true,
                          children:
                              List.generate(state.products.length, (index) {
                            return ProductItem(product: state.products[index]);
                          }),
                        )
                      : ListView.builder(
                          itemCount: state.products.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return HorizontialProductItem(
                                product: state.products[index]);
                          });
                }
                return Center(
                    child: General.customThreeBounce(context,
                        color: Theme.of(context).primaryColor, size: 30.0));
              })
            ],
          ),
        ),
      ),
    );
  }
}
