import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:localstics/core/functions/functions.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';
import 'package:localstics/features/Seller/products/add_product_seller.dart';
import 'package:localstics/features/Seller/products/edit_product_screen.dart';

class ProductSellerScreen extends StatefulWidget {
  const ProductSellerScreen({super.key});

  @override
  State<ProductSellerScreen> createState() => _ProductSellerScreenState();
}

class _ProductSellerScreenState extends State<ProductSellerScreen> {
  final List<Map<String, dynamic>> products = [
    {
      'title': 'Regular Fit Polo',
      'brand': 'Brand X',
      'rating': '4.5',
      'reviews': '100',
      'price': '5,000 L.E',
      'discount': '',
      'image': 'assets/polo.png',
      'inStock': true,
    },
    {
      'title': 'Black Oversized Tshirt',
      'brand': 'Brand Y',
      'rating': '4.2',
      'reviews': '80',
      'price': '12,000 L.E',
      'discount': '-10%',
      'image': 'assets/blacktee.png',
      'inStock': false,
    },
    {
      'title': 'Oversized Hoodie',
      'brand': 'Brand Z',
      'rating': '4.7',
      'reviews': '120',
      'price': '15,000 L.E',
      'discount': '',
      'image': 'assets/hoodie.png',
      'inStock': true,
    },
    {
      'title': 'Regular Fit Sweater',
      'brand': 'Brand X',
      'rating': '4.8',
      'reviews': '95',
      'price': '15,000 L.E',
      'discount': '',
      'image': 'assets/sweater.png',
      'inStock': true,
    },
    {
      'title': 'Regular Fit Polo',
      'brand': 'Brand Y',
      'rating': '4.1',
      'reviews': '60',
      'price': '15,000 L.E',
      'discount': '',
      'oldPrice': '16,000 L.E',
      'image': 'assets/polo.png',
      'inStock': true,
    },
    {
      'title': 'Black Oversized Tshirt',
      'brand': 'Brand Z',
      'rating': '4.0',
      'reviews': '40',
      'price': '800 L.E',
      'discount': '',
      'image': 'assets/blacktee.png',
      'inStock': false,
    },
    {
      'title': 'Oversized Hoodie',
      'brand': 'Brand X',
      'rating': '4.6',
      'reviews': '70',
      'price': '800 L.E',
      'discount': '',
      'image': 'assets/hoodie.png',
      'inStock': true,
    },
    {
      'title': 'Regular Fit Sweater',
      'brand': 'Brand Y',
      'rating': '4.3',
      'reviews': '50',
      'price': '9,000 L.E',
      'discount': '',
      'oldPrice': '',
      'image': 'assets/sweater.png',
      'inStock': true,
    },
    {
      'title': 'Regular Fit Polo',
      'brand': 'Brand Y',
      'rating': '4.3',
      'reviews': '50',
      'price': '9,000 L.E',
      'discount': '',
      'oldPrice': '',
      'image': 'assets/polo.png',
      'inStock': true,
    },
    {
      'title': 'Regular Fit Sweater',
      'brand': 'Brand Y',
      'rating': '4.3',
      'reviews': '50',
      'price': '9,000 L.E',
      'discount': '',
      'oldPrice': '',
      'image': 'assets/sweater.png',
      'inStock': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        actions: [
          SvgPicture.asset(
            'assets/Bell.svg',
            width: 24,
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, bottom: 5),
            child: Image.asset(
              'assets/bag.png',
              width: 48,
              height: 48,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage('assets/agent.png'),
                  ),
                  const Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hello Emekus',
                        style: getTextStyle(
                          fontSize: 16,
                          fontweight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Let's make sales today",
                        style: getTextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(15),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
                  hintText: 'Search...',
                  hintStyle: getTextStyle(color: AppColors.lighticon, fontSize: 16),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lightt),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lightt),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const Gap(10),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(), // prevent scrolling conflict
                shrinkWrap: true, // important!
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                itemCount: products.length,
                separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.transparent),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        push(context, ProductEditScreen(product: product));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                product['image'] ?? '',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Gap(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['title'] ?? '',
                                    style: getTextStyle(
                                      fontSize: 17,
                                      fontweight: FontWeight.w600,
                                    ),
                                  ),
                                  const Gap(2),
                                  Row(
                                    children: [
                                      Text(
                                        product['price'] ?? '',
                                        style: getTextStyle(fontSize: 15),
                                      ),
                                      if ((product['oldPrice'] ?? '').isNotEmpty) ...[
                                        const Gap(6),
                                        Text(
                                          product['oldPrice'] ?? '',
                                          style: getTextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                      if ((product['discount'] ?? '').isNotEmpty) ...[
                                        const Gap(6),
                                        Text(
                                          product['discount'] ?? '',
                                          style: getTextStyle(
                                            fontSize: 13,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Gap(12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: product['inStock'] ? AppColors.black : const Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                product['inStock'] ? 'In Stock' : 'Out of Stock',
                                style: getTextStyle(
                                  color: product['inStock'] ? AppColors.bgColor : AppColors.darkgrey,
                                  fontSize: 13,
                                  fontweight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(context, const AddProductSellerScreen());
        },
        backgroundColor: Colors.white,
        elevation: 3,
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _NavIcon({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: selected ? const Color(0xFF00B56A) : Colors.grey,
            size: 28,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: selected ? AppColors.black : Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              fontFamily: 'Serif',
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          '$title Page',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
