import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localstics/core/utils/colors.dart';
// import 'package:localstics/features/Seller/SellerSignUp/signup_seller_screen.dart';
import 'package:localstics/features/Seller/accountS/account_seller.dart';
import 'package:localstics/features/Seller/products/product_screen.dart';
import 'package:localstics/features/Seller/wallet/wallet_seller.dart';

class NavbarSeller extends StatefulWidget {
  final int initialIndex;
   final VoidCallback? onSwitchToCustomer;
  const NavbarSeller({super.key, this.initialIndex = 0, this.onSwitchToCustomer});

  @override
  State<NavbarSeller> createState() => _NavbarSellerState();
}

class _NavbarSellerState extends State<NavbarSeller> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void changeTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> get _screens => [
        // Navigator(
        //   key: GlobalKey<NavigatorState>(),
        //   onGenerateRoute: (settings) => MaterialPageRoute(
        //     builder: (context) => const SignBusinessInfoScreen(),
        //   ),
        // ),
        Navigator(
          key: GlobalKey<NavigatorState>(),
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => const ProductSellerScreen(),
          ),
        ),
        Navigator(
          key: GlobalKey<NavigatorState>(),
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => const WalletSellerScreen(),
          ),
        ),
        Navigator(
          key: GlobalKey<NavigatorState>(),
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) =>  AccountSellerScreen(onSwitchToCustomer: widget.onSwitchToCustomer,),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ensure area behind padding is white
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _screens[currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.bgColor, // Set background to white
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: AppColors.black,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (value) => changeTab(value),
        items: [
          // BottomNavigationBarItem(icon: SvgPicture.asset('assets/ordericon.svg',
          // colorFilter: ColorFilter.mode(AppColors.lightgrey, BlendMode.srcIn),), label: 'Orders',
          // activeIcon: SvgPicture.asset('assets/ordericon.svg', 
          // colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),)),

          BottomNavigationBarItem(icon: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset('assets/producticon.svg', 
            colorFilter: ColorFilter.mode(AppColors.lightgrey, BlendMode.srcIn),),
          ), label: 'Products',
          activeIcon: SizedBox(
            width: 24, height: 24,
            child: SvgPicture.asset('assets/producticon.svg', 
            colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),),
          )),

          BottomNavigationBarItem(icon: SvgPicture.asset('assets/walleticon.svg', 
          colorFilter: ColorFilter.mode(AppColors.lightgrey, BlendMode.srcIn),), label: 'Wallet',
          activeIcon: SvgPicture.asset('assets/walleticon.svg', 
          colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),)),

          BottomNavigationBarItem(icon: SvgPicture.asset('assets/User.svg',
          colorFilter: ColorFilter.mode(AppColors.lightgrey, BlendMode.srcIn),), label: 'Account',
          activeIcon: SvgPicture.asset('assets/User.svg', 
          colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),)),
        ],
      ),
    );
  }
}
