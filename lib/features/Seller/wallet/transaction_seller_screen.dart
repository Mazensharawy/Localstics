import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';

class TransactionSellerScreen extends StatefulWidget {
  const TransactionSellerScreen({super.key});

  @override
  State<TransactionSellerScreen> createState() => _TransactionSellerScreenState();
}

class _TransactionSellerScreenState extends State<TransactionSellerScreen> {
  @override
  Widget build(BuildContext context) {
    // Dummy transactions; in real app, pass data or fetch from backend
    final transactions = [
      {
        'type': 'Order Payment',
        'amount': '50,000 L.E',
        'date': 'November 25th, 2023',
        'orderId': '#212323',
        'icon': Icons.redo,
        'color': Colors.green,
      },
      {
        'type': 'Withdrawal',
        'amount': '200,000 L.E',
        'date': 'November 25th, 2023',
        'orderId': 'Wallet',
        'icon': Icons.undo,
        'color': Colors.red,
      },
      {
        'type': 'Order Payment',
        'amount': '50,000 L.E',
        'date': 'November 25th, 2023',
        'orderId': '#212323',
        'icon': Icons.redo,
        'color': Colors.green,
      },
      {
        'type': 'Withdrawal',
        'amount': '20,000 L.E',
        'date': 'November 25th, 2023',
        'orderId': 'Wallet',
        'icon': Icons.undo,
        'color': Colors.red,
      },
      {
        'type': 'Order Payment',
        'amount': '170,000 L.E',
        'date': 'November 25th, 2023',
        'orderId': '#212323',
        'icon': Icons.redo,
        'color': Colors.green,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('All Transactions',
          style: getTextStyle(
            fontweight: FontWeight.bold,
            fontSize: 24,),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(
              'assets/bag.png',
              width: 48,
              height: 48,

            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 40),
        itemCount: transactions.length,
        separatorBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Divider(color: AppColors.lightt,thickness: 0.8,),
        ),
        itemBuilder: (context, index) {
          final tx = transactions[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(tx['icon'] as IconData, color: tx['color'] as Color, size: 22),
              const Gap(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx['type'] as String,
                      style: getTextStyle(
                        fontweight: FontWeight.w500,
                        fontSize: 15,),
                    ),
                    Text(
                      tx['orderId'] as String,
                      style: getTextStyle(
                        fontweight: FontWeight.w400,
                        fontSize: 13,
                        color: AppColors.lightgrey,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    tx['amount'] as String,
                    style: getTextStyle(
                      fontweight: FontWeight.w500,
                      fontSize: 15,),
                  ),
                  Text(
                    tx['date'] as String,
                    style: getTextStyle(
                      fontweight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColors.lightgrey,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
