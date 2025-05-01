import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:localstics/core/functions/functions.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';
import 'package:localstics/features/account/account_screen.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int selectedTabIndex = 0;

  List<Map<String, dynamic>> onGoingorders = [
    {
      "image": "assets/blacktee.png",
      "name": "Regular Fit Slogan",
      "brand": "H&M",
      "size": "M",
      "price": "\$ 1,190",
      "status": "In Transit",
    },
    {
      "image": "assets/hoodie.png",
      "name": "Regular Fit Polo",
      "brand": "H&M",
      "size": "L",
      "price": "\$ 1,100",
      "status": "Picked",
    },
    {
      "image": "assets/polo.png",
      "name": "Regular Fit Black",
      "brand": "H&M",
      "size": "L",
      "price": "\$ 1,690",
      "status": "In Transit",
    },
    {
      "image": "assets/sweater.png",
      "name": "Regular Fit V-Neck",
      "brand": "H&M",
      "size": "S",
      "price": "\$ 1,290",
      "status": "Packing",
    },
    {
      "image": "assets/hoodie.png",
      "name": "Regular Fit Pink",
      "brand": "H&M",
      "size": "M",
      "price": "\$ 1,210",
      "status": "Picked",
    },
  ];

  List<Map<String, dynamic>> completedorders = [
    {
      "image": "assets/blacktee.png",
      "name": "Regular Fit Slogan",
      "brand": "H&M",
      "size": "M",
      "price": "\$ 1,190",
      "status": "Completed",
    },
    {
      "image": "assets/hoodie.png",
      "name": "Regular Fit Polo",
      "brand": "H&M",
      "size": "L",
      "price": "\$ 1,100",
      "status": "Completed",
    },
    {
      "image": "assets/polo.png",
      "name": "Regular Fit Black",
      "brand": "H&M",
      "size": "L",
      "price": "\$ 1,690",
      "status": "Completed",
    },
    {
      "image": "assets/sweater.png",
      "name": "Regular Fit V-Neck",
      "brand": "H&M",
      "size": "S",
      "price": "\$ 1,290",
      "status": "Completed",
    },
    {
      "image": "assets/hoodie.png",
      "name": "Regular Fit Pink",
      "brand": "H&M",
      "size": "M",
      "price": "\$ 1,210",
      "status": "Completed",
    },
  ];
  @override
  Widget build(BuildContext context) {
     final selectedOrders = selectedTabIndex == 0 ? onGoingorders : completedorders;
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
        title: Text('My Orders', 
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
        padding: const EdgeInsets.only(left: 12, right: 12, top:10),
        child: SingleChildScrollView(
          child: Column(
            children: [
               Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300,
              ),
              child: Row(
                children: [
                  TabButton(title: 'Ongoing', isSelected: selectedTabIndex==0, 
                    onTap: (){setState(() {
                      selectedTabIndex = 0;
                    });}
                    ),
                  TabButton(
                   title: 'Completed',
                   isSelected: selectedTabIndex == 1,
                   onTap: () {
                    setState(() {
                     selectedTabIndex = 1;
                     });

    _showReviewModal(context); 
  },
),
                ],
              ),
              ),
              const Gap(16),
              SizedBox(
                height: 580,
                child: selectedOrders.isEmpty
                  ? const Center(child: Text('No orders available'))
                  : ListView.separated(
                    itemCount: selectedOrders.length,
                    separatorBuilder: (_, __) => const Gap(10),
                    itemBuilder: (context, index) {
                      return OrderCard(order: selectedOrders[index]);
               },
               ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}

 class TabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const TabButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.horizontal(
          left: title == "Ongoing" ? const Radius.circular(10) : Radius.zero,
          right: title == "Completed" ? const Radius.circular(10) : Radius.zero,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : AppColors.lightt,
            borderRadius: BorderRadius.horizontal(
              left: title == "Ongoing" ? const Radius.circular(10) : Radius.zero,
              right: title == "Completed" ? const Radius.circular(10) : Radius.zero,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: getTextStyle(
                fontSize: 16,
                color: isSelected ? Colors.black : AppColors.darkgrey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}




 class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightt),
      ),
      child: Row(
        children: [
          Image.asset(
            order["image"],
            width: 72,
            height: 90,
            fit: BoxFit.cover,
          ),
          const Gap(15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(4),
                Text(order["name"],
                    style: getTextStyle(
                        fontweight: FontWeight.bold, fontSize: 16)),
                Text(order["brand"],
                     style: getTextStyle(fontSize: 13),),
                Text("Size ${order["size"]}", 
                      style: getTextStyle(fontSize: 13),),
                const Gap(8),
                Text(order["price"],
                    style: getTextStyle(
                        fontSize: 15, fontweight: FontWeight.w600)),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Gap(3),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.lightt,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  order["status"],
                  style: getTextStyle(fontSize: 12),
                ),
              ),
              const Gap(25),
              ElevatedButton(
                onPressed: () {  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(100, 35),
                ),
                child: Text("See Order",
                 style: getTextStyle(fontSize: 15, color: AppColors.bgColor),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



void _showReviewModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent, 
    builder: (context) {
      double rating = 0;
      final TextEditingController reviewController = TextEditingController();

      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: StatefulBuilder(
          builder: (context, setState) {
            return Material(
              color: AppColors.bgColor, 
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Leave a Review',
                          style: getTextStyle(fontSize: 25, fontweight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('How was your order?',
                        style: getTextStyle(fontweight: FontWeight.bold)),
                    Text(
                      'Please give your rating and also your review',
                      style: getTextStyle(color: AppColors.lighticon, fontSize: 14),
                    ),
                   const Gap(3),

                    // Star Rating Row
                    Row(
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            Icons.star,
                            size: 30,
                            color: rating >= index + 1 ? Colors.orange : AppColors.lightt,
                          ),
                          onPressed: () {
                            setState(() {
                              rating = index + 1;
                            });
                          },
                        );
                      }),
                    ),

                    // Review TextField
                    TextField(
                      controller: reviewController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Write your review...',
                        fillColor: AppColors.bgColor,
                        filled: true,
                        hintStyle: getTextStyle(fontSize: 15, color: AppColors.lightgrey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lightt),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lightt),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // Save or send the review here
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Submit',
                          style: getTextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
