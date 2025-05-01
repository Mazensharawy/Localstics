import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/functions/functions.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/widgets/custom_text_form.dart';
import 'package:localsticss/features/HomePage/widgets/filter_category.dart';
import 'package:localsticss/features/HomePage/widgets/product_card.dart';
import 'package:localsticss/features/chatbot/chatbot_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isClicked = false;
  String selectedCategory = 'Card';

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
    {
      "image": "assets/hoodie.png",
      "brand": "H&M",
      "title": "Oversized Hoodie",
      "price": "\$1,290",
      "rating": "4.9",
      "reviews": "126",
    },
    {
      "image": "assets/polo.png",
      "brand": "H&M",
      "title": "Regular Fit Polo",
      "price": "\$1,290",
      "rating": "4.9",
      "reviews": "126",
    },
    {
      "image": "assets/sweater.png",
      "brand": "H&M",
      "title": "Regular Fit Sweater",
      "price": "\$1,290",
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
            children: [
              const CustomTextForm(),
              const Gap(10),
              const FilterViewCategory(),
              const Gap(10),
              SizedBox(
                height: 1140,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                    ), 
                    itemCount: products.length,
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




