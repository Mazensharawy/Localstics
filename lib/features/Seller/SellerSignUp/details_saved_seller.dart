import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localstics/core/functions/functions.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';
import 'package:localstics/features/HomePage/widgets/black_button.dart';
import 'package:localstics/features/account/account_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:localstics/features/Seller/orders/orders_seller.dart';

class DetailsSavedSheet extends StatefulWidget {
  const DetailsSavedSheet({super.key});

  @override
  State<DetailsSavedSheet> createState() => _DetailsSavedSheetState();
}

class _DetailsSavedSheetState extends State<DetailsSavedSheet> {
  bool _approved = false;

  @override
  void initState() {
    super.initState();
    _pollApproval();
  }

  Future<void> _pollApproval() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;
    final userId = user.id;
    while (mounted) {
      final res = await Supabase.instance.client
          .from('seller')
          .select('approved')
          .eq('user_id', userId)
          .maybeSingle();
      if (res != null && res['approved'] == true) {
        setState(() {
          _approved = true;
        });
        await Future.delayed(const Duration(milliseconds: 500));
        if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const OrderSellerScreen()),
          (route) => false,
        );
        break;
      }
      await Future.delayed(const Duration(seconds: 3));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        if (didPop) {
          await Future.delayed(const Duration(milliseconds: 100));
          if (mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const AccountScreen()),
              (route) => false,
            );
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(12),
            Icon(Icons.verified, size: 60, color: AppColors.black),
            const Gap(16),
            Text(
              'Details Saved',
              style: getTextStyle(fontSize: 22, fontweight: FontWeight.bold),
            ),
            const Gap(8),
            Text(
              'Your details have been saved successfully',
              style: getTextStyle(fontSize: 15, color: AppColors.darkgrey),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            BlackButton(
              text: _approved ? 'Approved! Go to Seller Page' : 'Wait for admin approval',
              width: double.infinity,
              height: 55,
              onPressed: _approved
                  ? () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const OrderSellerScreen()),
                        (route) => false,
                      );
                    }
                  : null,
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }
}
