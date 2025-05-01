import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localstics/core/functions/functions.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';
import 'package:localstics/features/Seller/wallet/transaction_seller_screen.dart';
import 'package:localstics/features/Seller/wallet/withdraw_seller_screen.dart';

class WalletSellerScreen extends StatefulWidget {
  const WalletSellerScreen({super.key});

  @override
  State<WalletSellerScreen> createState() => _WalletSellerScreenState();
}

class _WalletSellerScreenState extends State<WalletSellerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(15),
              Text('Wallet',
                style: getTextStyle(
                  fontweight: FontWeight.w600,
                  fontSize: 21,),
              ),
              const Gap(10),
              // Wallet Balance Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 120,
                        decoration: const BoxDecoration(
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text('YOUR WALLET BALANCE',
                                style: getTextStyle(
                                  color: AppColors.bgColor,
                                  fontSize: 12,
                                ),
                              ),
                              const Gap(8),
                              Text('55,000.00 L.E',
                                style: getTextStyle(
                                  color: AppColors.bgColor,
                                  fontSize: 26,
                                  fontweight: FontWeight.w600,),
                              ),
                              const Gap(12),
                              SizedBox(
                                height: 32,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.bgColor,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                     splashFactory: NoSplash.splashFactory,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(horizontal: 18),
                                  ),
                                  onPressed: () {
                                    push(context, const WithdrawSellerScreen());},
                                  child: Text('Withdraw',
                                    style: getTextStyle(
                                      fontweight: FontWeight.w500,
                                      fontSize: 15,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, bottom: 18),
                            child: Icon(Icons.remove_red_eye_outlined, color: AppColors.bgColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text('Recent Transaction',
                    style: getTextStyle(
                      fontweight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      push(context, const TransactionSellerScreen());
                    },
                    child: Text('View All',
                      style: getTextStyle(
                        color: AppColors.lightgrey,
                        fontweight: FontWeight.w500,
                        fontSize: 14,
                        decoration: TextDecoration.underline,),
                    ),
                  ),
                ],
              ),
              const Gap(12),
              Expanded(
               child: ListView.separated(
                itemCount: 8,
                separatorBuilder: (context, index) => Divider(
                  color: AppColors.lightt, thickness: 0.8,),
                itemBuilder: (context, index) {
                final transactions = [
                const WalletTransaction(
                 type: 'Order Payment',
                 amount: '50,000 L.E',
                 date: 'November25th, 2023',
                 orderId: '#212324',
                 icon: Icons.redo,
                 color: Colors.green,
                 ),
                const WalletTransaction(
                 type: 'Order Payment',
                 amount: '50,000 L.E',
                 date: 'November25th, 2023',
                 orderId: '#212336',
                 icon: Icons.redo,
                 color: Colors.green,
                ),
                const WalletTransaction(
                 type: 'Order Payment',
                 amount: '50,000 L.E',
                 date: 'November25th, 2023',
                 orderId: '#212323',
                 icon: Icons.redo,
                 color: Colors.green,
                ),
                const WalletTransaction(
                 type: 'Order Payment',
                 amount: '50,000 L.E',
                 date: 'November25th, 2023',
                 orderId: '#212323',
                 icon: Icons.redo,
                 color: Colors.green,
                ),
                const WalletTransaction(
                 type: 'Withdrawal',
                 amount: '200,000 L.E',
                 date: 'November25th, 2023',
                 orderId: 'Wallet',
                 icon: Icons.undo,
                 color: Colors.red,
                ),
                const WalletTransaction(
                 type: 'Order Payment',
                 amount: '50,000 L.E',
                 date: 'November25th, 2023',
                 orderId: '#212323',
                 icon: Icons.redo,
                 color: Colors.green,
                ),
                const WalletTransaction(
                 type: 'Withdrawal',
                 amount: '20,000 L.E',
                 date: 'November25th, 2023',
                 orderId: 'Wallet',
                 icon: Icons.undo,
                 color: Colors.red,
                ),
                const WalletTransaction(
                 type: 'Order Payment',
                 amount: '170,000 L.E',
                 date: 'November25th, 2023',
                 orderId: '#212323',
                 icon: Icons.redo,
                 color: Colors.green,
                ),
               ];
                return transactions[index];
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

class WalletTransaction extends StatelessWidget {
  final String type;
  final String amount;
  final String date;
  final String orderId;
  final IconData icon;
  final Color color;

  const WalletTransaction({
    super.key,
    required this.type,
    required this.amount,
    required this.date,
    required this.orderId,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const Gap(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: getTextStyle(
                    fontweight: FontWeight.w500,
                    fontSize: 16,),
                ),
                Text(
                  orderId,
                  style:  getTextStyle(
                    fontweight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.lightgrey,),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: getTextStyle(
                  fontweight: FontWeight.w500,
                  fontSize: 16,),
              ),
              Text(
                date,
                style: getTextStyle(
                  fontweight: FontWeight.w400,
                  fontSize: 13,
                  color: AppColors.lightgrey,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
