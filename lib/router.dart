import 'package:amazon_clone/common/widgets/bottombar.dart';
import 'package:amazon_clone/features/address/screens/address_screens.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/auths/screens/auth_screens.dart';
import 'package:amazon_clone/features/home/screens/categories_deals_screen.dart';
import 'package:amazon_clone/features/home/screens/homescreen.dart';
import 'package:amazon_clone/features/orderdetail/screen/order_screen.dart';
import 'package:amazon_clone/features/product_details/screens/product_detail_screens.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateroute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routename:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    case Homescreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const Homescreen());
    case Bottombar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const Bottombar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductScreen());
    case CategoryDeals.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDeals(
                category: category,
              ));
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ));
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailScreen(
                product: product,
              ));
    case AddressScreen.routeName:
      var totalamount = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => AddressScreen(
                totalAmount: totalamount,
              ));
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as OrderModel;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetailScreen(
                orderModel: order,
              ));
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Text("Screen does't exist!"),
              ));
  }
}
