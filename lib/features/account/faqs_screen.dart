import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localsticss/core/functions/functions.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';
import 'package:localsticss/features/account/account_screen.dart';

class FactsScreen extends StatefulWidget {
  const FactsScreen({super.key});

  @override
  State<FactsScreen> createState() => _FactsScreenState();
}

class _FactsScreenState extends State<FactsScreen> {
  final List<FaqItem> _faqs = [
    FaqItem(
      question: "How do I make a purchase?",
      answer:
          "When you find a product you want to purchase, tap on it to view the product details. Check the price, description, and available options (if applicable), and then tap the 'Add to Cart' button. Follow the on-screen instructions to complete the purchase, including providing shipping details and payment information.",
    ),
    FaqItem(
      question: "What payment methods are accepted?",
      answer:
          "We accept credit/debit cards, PayPal, Apple Pay, and Google Pay.",
    ),
    FaqItem(
      question: "Where can I see my order history?",
      answer:
          "Go to 'My Orders' from your account section to view your order history.",
    ),
    FaqItem(
      question: "Can I use multiple promo codes?",
      answer:
          "Only one promo code can be applied per order unless otherwise stated.",
    ),
    FaqItem(
      question: "How can I contact customer support for assistance?",
      answer:
          "You can reach our support team through the 'Help Center' or use live chat on our app.",
    ),
    FaqItem(
      question: "What are your customer service hours?",
      answer:
          "Our chatbot is available 24/7 to assist you instantly with most questions. If you need further help or face an issue that requires human support, you can fill out the 'Contact Us' form located in the 'Help Center', and our team will get back to you as soon as possible..",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
         elevation: 0,
         scrolledUnderElevation: 0,
         leading: IconButton(
          iconSize: 30,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            pop(context, const AccountScreen());
          },
        ),
        centerTitle: true,
        title: Text('FAQs', 
         style: getTextStyle(fontweight: FontWeight.bold, fontSize: 24),),
        actions: [
          SvgPicture.asset(
            'assets/chatbotsvg.svg',
            width: 30,
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Image.asset(
              'assets/bag.png',
              width: 48,
              height: 48,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15), 
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              //const Gap(5),
              ListView.builder(
                shrinkWrap: true, // ADD THIS
                physics: const NeverScrollableScrollPhysics(), 
                padding: const EdgeInsets.all(12),
                itemCount: _faqs.length,
                itemBuilder: (context, index){
                   final item = _faqs[index];
                   return Container(
  margin: const EdgeInsets.symmetric(vertical: 6),
  decoration: BoxDecoration(
    color: AppColors.bgColor,
    border: Border.all(
      color: Colors.grey.shade300, // Customize border color here
      width: 1,                    // Border thickness
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: ExpansionTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      collapsedBackgroundColor: AppColors.bgColor,
      backgroundColor: AppColors.bgColor,
      trailing: Icon(Icons.keyboard_arrow_down, color: AppColors.black),
      title: Text(
        item.question,
        style: getTextStyle(fontSize: 16, fontweight: FontWeight.bold),
      ),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      children: [
        Text(
          item.answer,
          style: getTextStyle(fontSize: 15, color: AppColors.lightgrey),
        ),
      ],
    ),
  ),
);

                }
              ),
            ],
          ),
        ), 
      ),
    );
  }
}

class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}