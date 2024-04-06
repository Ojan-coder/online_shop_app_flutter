import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testing_aplikasi/presentation/home/bloc/all_product/all_product_bloc.dart';
import 'package:testing_aplikasi/presentation/home/bloc/best_seller_product/best_seller_product_bloc.dart';
import 'package:testing_aplikasi/presentation/home/bloc/flash_sale_product/flash_sale_product_bloc.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/search_input.dart';
import '../../../core/components/spaces.dart';
import '../../../core/router/app_router.dart';
import '../models/product_model.dart';
import '../models/store_model.dart';
import '../widgets/banner_slider.dart';
import '../widgets/organism/menu_categories.dart';
import '../widgets/organism/product_list.dart';
import '../widgets/title_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;

  final List<String> banners1 = [
    Assets.images.banner1.path,
    Assets.images.banner1.path,
  ];
  final List<String> banners2 = [
    Assets.images.banner2.path,
    Assets.images.banner2.path,
    Assets.images.banner2.path,
  ];

  @override
  void initState() {
    searchController = TextEditingController();
    context.read<AllProductBloc>().add(const AllProductEvent.getAllProducts());
    context
        .read<BestSellerProductBloc>()
        .add(const BestSellerProductEvent.getBestSellerProducts());
    context
        .read<FlashSaleProductBloc>()
        .add(const FlashSaleProductEvent.getFlashSaleProducts());
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oc Store'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Assets.icons.notification.svg(height: 24.0),
          ),
          IconButton(
            onPressed: () {
              context.goNamed(
                RouteConstants.cart,
                pathParameters: PathParameters().toMap(),
              );
            },
            icon: Assets.icons.cart.svg(height: 24.0),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SearchInput(
            controller: searchController,
            onTap: () {
              context.pushReplacementNamed(
                RouteConstants.root,
                pathParameters: PathParameters(
                  rootTab: RootTab.explore,
                ).toMap(),
              );
            },
          ),
          const SpaceHeight(16.0),
          BannerSlider(items: banners1),
          const SpaceHeight(12.0),
          TitleContent(
            title: 'Categories',
            onSeeAllTap: () {},
          ),
          const SpaceHeight(12.0),
          const MenuCategories(),
          const SpaceHeight(50.0),
          BlocBuilder<AllProductBloc, AllProductState>(
            builder: (context, state) {
              return state.maybeWhen(
                  loaded: (products) {
                    return ProductList(
                        title: 'Featured Product',
                        onSeeAllTap: () {},
                        items: products);
                  },
                  orElse: () => const SizedBox.shrink(),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  error: (message) => Center(
                        child: Text(message),
                      ));
            },
          ),
          const SpaceHeight(50.0),
          BannerSlider(items: banners2),
          const SpaceHeight(28.0),
          BlocBuilder<BestSellerProductBloc, BestSellerProductState>(
            builder: (context, state) {
              return state.maybeWhen(
                  loaded: (products) {
                    return ProductList(
                        title: 'Best Seller',
                        onSeeAllTap: () {},
                        items: products.length > 2
                            ? products.sublist(0, 2)
                            : products);
                  },
                  orElse: () => const SizedBox.shrink(),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  error: (message) => Center(
                        child: Text(message),
                      ));
            },
          ),
          const SpaceHeight(50.0),
          BlocBuilder<FlashSaleProductBloc, FlashSaleProductState>(
            builder: (context, state) {
              return state.maybeWhen(
                  loaded: (products) {
                    return ProductList(
                        title: "Flash Sale Products",
                        onSeeAllTap: () {},
                        items: products);
                  },
                  orElse: () => const SizedBox.shrink(),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  error: (message) => Center(
                        child: Text(message),
                      ));
            },
          ),
          const SpaceHeight(50.0),
          // ProductList(
          //   title: 'Top Rated Product',
          //   onSeeAllTap: () {},
          //   items: topRatedProducts,
          // ),
          const SpaceHeight(50.0),
          // ProductList(
          //   title: 'Special Offers',
          //   onSeeAllTap: () {},
          //   items: specialOffers,
          // ),
        ],
      ),
    );
  }
}
