import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:localstics/core/functions/functions.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';
import 'package:localstics/core/widgets/custom_text_form.dart';
import 'package:localstics/features/HomePage/widgets/brands.dart';
import 'package:localstics/features/HomePage/widgets/custom_text.dart';
import 'package:localstics/features/HomePage/widgets/list_category.dart';
import 'package:localstics/features/HomePage/widgets/product_card.dart';
import 'package:localstics/features/chatbot/chatbot_screen.dart';


class HomeScreen extends StatefulWidget {
  final VoidCallback? onRecycleNowTap;
  const HomeScreen({super.key, this.onRecycleNowTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> images = [
    Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/pic1.png',
          height: 220,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        bottom: 10,
        right: 10,
        child: SizedBox(
          width: 116,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brown,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {},
            child: Text(
              "Shop Now",
              style: getTextStyle(
                  color: Colors.white,
                  fontweight: FontWeight.w600,
                  fontSize: 14),
            ),
          ),
        ),
      ),
    ]),
    ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset('assets/pic2.png', height: 220, fit: BoxFit.cover),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset('assets/pic3.png', height: 220, fit: BoxFit.cover),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset('assets/pic4.png', height: 220, fit: BoxFit.cover),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset('assets/pic5.png', height: 220, fit: BoxFit.cover),
    ),
  ];

   final List<Map<String, dynamic>> products = [
    {
      "image": "assets/hoodie.png",
      "brand": "H&M",
      "title": "Oversized Hoodie",
      "price": "\$1,190",
      "rating": "4.9",
      "reviews": "126",
    },
    {
      "image": "assets/polo.png",
      "brand": "H&M",
      "title": "Regular Fit Polo",
      "price": "\$1,100",
      "discount": "-52%",
      "rating": "4.9",
      "reviews": "126",
    },
    {
      "image": "assets/sweater.png",
      "brand": "H&M",
      "title": "Regular Fit Sweater",
      "price": "\$1,690",
      "rating": "4.9",
      "reviews": "126",
    },
    {
      "image": "assets/blacktee.png",
      "brand": "H&M",
      "title": "Regular Fit Tshirt",
      "price": "\$1,290",
      "rating": "4.9",
      "reviews": "126",
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: AppColors.bgColor,
        leadingWidth: 165,
        leading: Image.asset(
          'assets/localstics.png',
          width: 50,
          height: 50,
          fit: BoxFit.fitWidth,
        ),
        actions: [
          GestureDetector(
            onTap: (){
              push(context, const ChatbotScreen());
            },
            child: SvgPicture.asset(
              'assets/chatbotsvg.svg',
              width: 32,
              height: 32,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 15),
            child: SvgPicture.asset(
              'assets/Bell.svg',
              width: 26,
              height: 26,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextForm(),
              const Gap(10),
              CarouselSlider(
                items: images,
                options: CarouselOptions(
                  viewportFraction: 0.99,
                  autoPlay: false,
                  enableInfiniteScroll: true,
                  //enlargeFactor: 0.3,
                  enlargeCenterPage: true,
                ),
              ),
              const Gap(12),
              const CustomText(
                text: 'Shop By Category',
              ),
              const Gap(19),
              ListViewCategory(),
              const Divider(),
              const Gap(10),
              const CustomText(text: 'Recommended For You'),
              const Gap(12),
              SizedBox(
                height: 530,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                    ), 
                    itemCount: 4,
                  itemBuilder: (context,index){
                    final product = products[index];
                    return ProductCard(product: product);
                  }
                ),
              ),
              const Gap(15),
              const Divider(),
              const Gap(10),
              Text('Rewards For Recycling',
                style: getTextStyle(fontweight: FontWeight.bold, fontSize: 21),
              ),
              const Gap(12),
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightt,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/Recycle.png', 
                         fit: BoxFit.cover,),
                    ),
                    const Gap(13),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Earn Points From Recycling', 
                          style: getTextStyle(fontweight: FontWeight.bold, fontSize: 17),
                        ),
                        Text('Shop more, waste less', 
                          style: getTextStyle(fontSize: 15),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[500],
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                                    ),
                                    ),
                          onPressed: widget.onRecycleNowTap,
                          child: Text("Recycle Now",
                             style: getTextStyle(
                               color: Colors.white,
                               fontweight: FontWeight.w600,
                               fontSize: 14),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(15),
              const Divider(),
              const Gap(10),
              Text('Our Local Brands',
                style: getTextStyle(fontweight: FontWeight.bold, fontSize: 21),
              ),
              const Gap(12),
              const BrandSlider(),
              const Gap(10),
              const BrandSlider(),
              const Gap(15),
              const Divider(),
              const Gap(10),
              const CustomText(text: 'Most Popular Items'),
              const Gap(12),
              SizedBox(
                height: 265,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                    ), 
                    itemCount: 2,
                  itemBuilder: (context,index){
                    final product = products[index];
                    return ProductCard(product: product);
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
