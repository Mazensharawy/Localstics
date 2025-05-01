import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';
import 'package:localsticss/features/Seller/orders/widgets/order_details_seller.dart';

class OrderSellerScreen extends StatefulWidget {
  const OrderSellerScreen({super.key, });

  @override
  State<OrderSellerScreen> createState() => _OrderSellerScreenState();
}


class _OrderSellerScreenState extends State<OrderSellerScreen> {
 // int _selectedIndex = 0;
  final List<String> _statuses = [
    'All',
    'Awaiting Pickup',
    'In Transit',
    'Completed',
    'Cancelled',
  ];
  int _selectedStatus = 0;

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        'name': 'Raiden Lord',
        'orderId': '#212323',
        'date': 'Today | 9:00 am',
        'status': 'New Order',
        'statusColor': const Color(0xFFE7F6E9),
        'statusBg': const Color(0xFF008000),
        'address': '16, First Love Estate, Ikorodu',
        'phoneNumber': '08092346578',
        'items': [
          OrderItemData(
            imagePath: 'assets/polo.png',
            name: 'Mama Gold Rice',
            quantity: '2 bags',
            price: '90,000 L.E',
          ),
          OrderItemData(
            imagePath: 'assets/polo.png',
            name: 'Tatashe',
            quantity: '1 Paint rubber',
            price: '25,000 L.E',
          ),
          OrderItemData(
            imagePath: 'assets/polo.png',
            name: 'Mama Gold Rice',
            quantity: '2 bags',
            price: '90,000 L.E',
          ),
          OrderItemData(
            imagePath: 'assets/polo.png',
            name: 'Tomatoes',
            quantity: '1 Basket',
            price: '30,000 L.E',
          ),
        ],
        'total': '275,000 L.E',
      },
      {
        'name': 'Raiden Lord',
        'orderId': '#212323',
        'date': 'Today | 9:00 am',
        'status': 'Awaiting Pickup',
        'statusColor': const Color(0xFFE9A900),
        'statusBg': const Color(0xFFFFF6E1),
        'address': '16, First Love Estate, Ikorodu',
        'phoneNumber': '08092346578',
        'items': [
          OrderItemData(
            imagePath: 'assets/polo.png',
            name: 'Mama Gold Rice',
            quantity: '2 bags',
            price: '90,000 L.E',
          ),
        ],
        'total': '90,000 L.E',
      },
      {
        'name': 'Jay Baba',
        'orderId': '#212323',
        'date': 'Today | 9:00 am',
        'status': 'In transit',
        'statusColor': const Color(0xFF3C7EFF),
        'statusBg': const Color(0xFFEAF2FF),
        'address': '12, Main Street, Lagos',
        'phoneNumber': '08012345678',
        'items': [
          OrderItemData(
            imagePath: 'assets/polo.png',
            name: 'Mama Gold Rice',
            quantity: '1 bag',
            price: '45,000 L.E',
          ),
        ],
        'total': '45,000 L.E',
      },
      {
        'name': 'Raiden Lord',
        'orderId': '#212323',
        'date': '25th November, 2023 | 9:00 am',
        'status': 'Completed',
        'statusColor': const Color(0xFF00B56A),
        'statusBg': const Color(0xFFE7F6E9),
        'address': '16, First Love Estate, Ikorodu',
        'phoneNumber': '08092346578',
        'items': [
          OrderItemData(
            imagePath: 'assets/polo.png',
            name: 'Tomatoes',
            quantity: '1 Basket',
            price: '30,000 L.E',
          ),
        ],
        'total': '30,000 L.E',
      },
      {
        'name': 'Raiden Lord',
        'orderId': '#212323',
        'date': '25th November, 2023 | 9:00 am',
        'status': 'Cancelled',
        'statusColor': const Color(0xFFD92D20),
        'statusBg': const Color(0xFFFFEAEA),
        'address': '16, First Love Estate, Ikorodu',
        'phoneNumber': '08092346578',
        'items': [
          OrderItemData(
            imagePath: 'assets/polo.png',
            name: 'Tatashe',
            quantity: '1 Paint rubber',
            price: '25,000 L.E',
          ),
        ],
        'total': '25,000 L.E',
      },
      {
        'name': 'Raiden Lord',
        'orderId': '#212323',
        'date': '25th November, 2023 | 9:00 am',
        'status': 'New Order',
        'statusColor': const Color(0xFFE7F6E9),
        'statusBg': const Color(0xFF008000),
        'address': '16, First Love Estate, Ikorodu',
        'phoneNumber': '08092346578',
        'items': [
          OrderItemData(
            imagePath: 'assets/polo.png',
            name: 'Mama Gold Rice',
            quantity: '1 bag',
            price: '45,000 L.E',
          ),
        ],
        'total': '45,000 L.E',
      },
    ];
    List<Map<String, Object>> filteredOrders;
    final statusTabs = [
      'All',
      'New Order',
      'Awaiting Pickup',
      'In transit',
      'Completed',
      'Cancelled',
    ];
    if (_selectedStatus == 0) {
      filteredOrders = List<Map<String, Object>>.from(orders);
    } else if (_selectedStatus == 1) {
      filteredOrders = orders.where((o) => o['status'] == 'New Order').toList();
    } else {
      final tabStatus = statusTabs[_selectedStatus];
      filteredOrders = orders.where((o) => o['status'] == tabStatus || o['status'] == 'New Order').toList();
    }
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
               Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/agent.png'),
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hello Emekus',
                      style: getTextStyle(
                        fontSize: 16,
                        fontweight: FontWeight.w600,
                      ),
                    ),
                    Text("Let's make sales today",
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
                      contentPadding:const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
                  hintText: 'Search...',
                  hintStyle: getTextStyle(color: AppColors.lighticon, fontSize: 16),
                  enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide (color: AppColors.lightt,),
                   borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  focusedBorder: OutlineInputBorder(
                   borderSide: BorderSide (color: AppColors.lightt,),
                   borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                ),
              ),
              const Gap(14),
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _statuses.length,
                  separatorBuilder: (context, index) => const Gap(7),
                  itemBuilder: (context, idx) {
                    final selected = idx == _selectedStatus;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedStatus = idx),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: selected ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: selected ? Colors.black : AppColors.lightt),
                        ),
                        child: Text(
                          _statuses[idx],
                          style: getTextStyle(
                            color: selected ? Colors.white : Colors.black,
                            fontSize: 14,),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(5),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredOrders.length,
                  separatorBuilder: (context, idx) => Divider(color: AppColors.lightt,),
                  itemBuilder: (context, idx) {
                    final order = filteredOrders[idx];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OrderDetailsScreen(
                              customerName: order['name'] as String,
                              address: order['address'] as String,
                              phoneNumber: order['phoneNumber'] as String,
                              status: order['status'] as String,
                              items: order['items'] as List<OrderItemData>,
                              total: order['total'] as String,
                              showProcessButton: order['status'] == 'New Order',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10,),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order['name'] as String,
                                    style: getTextStyle(
                                      fontweight: FontWeight.w600,
                                      fontSize: 17,),
                                  ),
                                  const Gap(2),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Order ID ${order['orderId']}',
                                        style: getTextStyle(
                                          fontSize: 13,),
                                      ),
                                      Text(
                                        order['date'] as String,
                                        style: getTextStyle(
                                          fontSize: 13,
                                          color:AppColors.lightgrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: order['statusBg'] as Color,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                order['status'] as String,
                                style: getTextStyle(
                                  color: order['statusColor'] as Color,
                                  fontweight: FontWeight.w600,
                                  fontSize: 13,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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