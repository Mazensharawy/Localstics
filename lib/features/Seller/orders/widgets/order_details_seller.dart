import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';
import 'package:localsticss/features/HomePage/widgets/black_button.dart';

// Define a class to represent an order item
class OrderItemData {
  final String imagePath;
  final String name;
  final String quantity;
  final String price;

  OrderItemData({
    required this.imagePath,
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class OrderDetailsScreen extends StatelessWidget {
  final String customerName;
  final String address;
  final String phoneNumber;
  final String status;
  final List<OrderItemData> items;
  final String total;
  final bool showProcessButton;

  const OrderDetailsScreen({
    super.key,
    required this.customerName,
    required this.address,
    required this.phoneNumber,
    required this.status,
    required this.items,
    required this.total,
    this.showProcessButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text("Customer's Order",
            style: getTextStyle(fontSize: 24, fontweight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/bag.png',width:48,height: 48,),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(18),
              // Customer Info Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(
                   color: AppColors.lightt, 
                   width: 1,          
                  ),
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(12),
                  
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customerName,
                            style: getTextStyle(
                              fontSize: 17,
                              fontweight: FontWeight.w600,),
                          ),
                          Text(
                            address,
                            style: getTextStyle(
                              fontSize: 14,
                              color: AppColors.lighticon,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            phoneNumber,
                            style: getTextStyle(
                              fontSize: 14,
                              color: AppColors.lighticon,),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        status,
                        style: getTextStyle(
                          color: AppColors.bgColor,
                          fontweight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(18),
              // Order Items Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                   border: Border.all(
                   color: AppColors.lightt, 
                   width: 1,          
                  ),
                ),
                child: Column(
                  children: [
                    ...items.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _OrderItem(
                            imagePath: item.imagePath,
                            name: item.name,
                            quantity: item.quantity,
                            price: item.price,
                          ),
                        )).toList(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                         Padding(
                           padding: const EdgeInsets.only(left: 65),
                           child: Text('Total',
                            style: getTextStyle(
                              fontSize: 18,
                              fontweight: FontWeight.w600,
                            ),
                                                   ),
                         ),
                        const Spacer(),
                        Text(
                          total,
                          style: getTextStyle(
                            fontSize: 16,
                            fontweight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (showProcessButton) ...[
                const Gap(28),
                const BlackButton(text: 'Process Order', width: double.infinity, height: 50),
                const Gap(16),
              ],
              // Agent's Information section (show for all except 'New Order' and 'Cancelled')
              if (status != 'New Order' && status != 'Cancelled') ...[
                const Gap(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Agent's Information",
                      style: getTextStyle(
                        fontweight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const Gap(8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                         color: AppColors.lightt, 
                         width: 1,          
                      ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset('assets/agent.png',
                              width: 45, height: 45, fit: BoxFit.cover,
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Order awaiting pickup 9:00 am',
                                  style: getTextStyle(
                                    fontweight: FontWeight.w500,
                                    fontSize: 15,),
                                ),
                                Text('Adekunle is on his way to pickup',
                                  style: getTextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(8),
                          const Padding(
                            padding: EdgeInsets.only(top: 9, right: 5),
                            child: Icon(Icons.phone_outlined, size: 24),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),

    );
  }
}

class _OrderItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final String quantity;
  final String price;

  const _OrderItem({
    required this.imagePath,
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        const Gap(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: getTextStyle(
                  fontSize: 15,
                  fontweight: FontWeight.w600,),
              ),
              Text(
                quantity,
                style: getTextStyle(
                  fontSize: 13,
                  color: AppColors.lighticon,),
              ),
            ],
          ),
        ),
        Text(
          price,
          style: getTextStyle(
            fontSize: 15,
            fontweight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}