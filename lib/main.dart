import 'package:baraka/blocs/category_bloc.dart';
import 'package:baraka/blocs/localization_bloc.dart';
import 'package:baraka/blocs/map-bloc.dart';
import 'package:baraka/blocs/product-review.dart';
import 'package:baraka/blocs/single-product-bloc.dart';
import 'package:baraka/blocs/profile_bloc.dart';
import 'package:baraka/screens/tabs/tabs.dart';
import 'package:baraka/utils/languages/translations_delegate_base.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'blocs/authentication_bloc.dart';
import 'blocs/general_bloc.dart';
import 'blocs/user_bloc.dart';
import 'package:baraka/blocs/product_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget _defaultHome = TabsScreen();
  runApp(app(_defaultHome));
}

Widget app(Widget startScreen) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<GeneralBloc>.value(
        value: GeneralBloc(),
      ),
      ChangeNotifierProvider<AuthenticationBloc>.value(
        value: AuthenticationBloc(),
      ),
      ChangeNotifierProvider<ProductBloc>.value(
        value: ProductBloc(),
      ),
      ChangeNotifierProvider<UserBloc>.value(
        value: UserBloc(),
      ),
      ChangeNotifierProvider<SingleProductBloc>.value(
        value: SingleProductBloc(),
      ),
      ChangeNotifierProvider<ProductReviewBloc>.value(
        value: ProductReviewBloc(),
      ),
      ChangeNotifierProvider<LocalizationBloc>.value(
        value: LocalizationBloc(),
      ),
      ChangeNotifierProvider<ProfileBloc>.value(
        value: ProfileBloc(),
      ),
      ChangeNotifierProvider<CategoryBloc>.value(
        value: CategoryBloc(),
      ),
      ChangeNotifierProvider<MapBloc>.value(
        value: MapBloc(),
      ),
      ChangeNotifierProvider<WishlistBloc>.value(
        value: WishlistBloc(),
      ),
      ChangeNotifierProvider<AddressBloc>.value(
        value: AddressBloc(),
      ),
    ],
    child: MyApp(
      defaultHome: startScreen,
    ),
  );
}

class MyApp extends StatefulWidget {
  final Widget defaultHome;
  MyApp({this.defaultHome});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LocalizationBloc localizationBloc =
        Provider.of<LocalizationBloc>(context);

    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Montserrat',
          primaryColor: Color(General.getColorHexFromStr('#14a77e')),
          accentColor: Color(General.getColorHexFromStr('#2ed889')),
          canvasColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              brightness: Brightness.light,
              iconTheme: IconThemeData(
                color: Colors.black,
              )),
          brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      locale: localizationBloc.appLocal,
      localizationsDelegates: [
        const TranslationBaseDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],

      supportedLocales: [
        const Locale('ar', ''), // Arabic
        const Locale('en', ''), // English
      ],
      // home: widget.defaultHome,
      home: TabsScreen(),
    );
  }
}
