import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_aplikasi/data/datasources/category_remote_datasource.dart';
import 'package:testing_aplikasi/presentation/home/bloc/best_seller_product/best_seller_product_bloc.dart';
import 'package:testing_aplikasi/presentation/home/bloc/category/category_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testing_aplikasi/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:testing_aplikasi/presentation/home/bloc/flash_sale_product/flash_sale_product_bloc.dart';

import 'core/constants/colors.dart';
import 'core/router/app_router.dart';
import 'data/datasources/product_remote_datasource.dart';
import 'presentation/home/bloc/all_product/all_product_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    final router = appRouter.router;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryBloc(CategoryRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AllProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => BestSellerProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => FlashSaleProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Oc Store',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          textTheme: GoogleFonts.dmSansTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            titleTextStyle: GoogleFonts.quicksand(
              color: AppColors.primary,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.black,
            ),
            centerTitle: true,
            shape: Border(
              bottom: BorderSide(
                color: AppColors.black.withOpacity(0.05),
              ),
            ),
          ),
        ),
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}
