import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/features/HomePage/home_screen.dart';
import 'package:localsticss/features/account/account_screen.dart';
import 'package:localsticss/features/cart/cart_screen.dart';
import 'package:localsticss/features/recycle/recycle_screen.dart';

class NavBarCustomer extends StatefulWidget {
  final int initialIndex;
   final VoidCallback? onSwitchToSeller;
  const NavBarCustomer({super.key, this.initialIndex = 0, this.onSwitchToSeller});

  @override
  State<NavBarCustomer> createState() => _NavBarCustomerState();
}

class _NavBarCustomerState extends State<NavBarCustomer> {
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
  List <Widget> get screens => [
       Navigator(
          key: GlobalKey<NavigatorState>(), // Each tab gets a separate navigation stack
          onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => HomeScreen(onRecycleNowTap: () => changeTab(1)),
    ),
  ),
       Navigator(
          key: GlobalKey<NavigatorState>(),
          onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => const RecycleScreen(),
    ),
  ),
       Navigator(
          key: GlobalKey<NavigatorState>(),
          onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) =>  const CartScreen(),
    ),
  ),
       Navigator(
          key: GlobalKey<NavigatorState>(),
          onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => AccountScreen(onSwitchToSeller: widget.onSwitchToSeller),
    ),
  ),
  ];
  //int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: screens[currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: AppColors.black,
        showUnselectedLabels: false,
        onTap: (value) => changeTab(value),
        items: [
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/Home.svg',
          colorFilter: ColorFilter.mode(AppColors.lightgrey, BlendMode.srcIn),), label: 'Home',
          activeIcon: SvgPicture.asset('assets/Home.svg', 
          colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),)),

          BottomNavigationBarItem(icon: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset('assets/recyclee.svg', 
            colorFilter: ColorFilter.mode(AppColors.lightgrey, BlendMode.srcIn),),
          ), label: 'Recycle',
          activeIcon: SizedBox(
            width: 24, height: 24,
            child: SvgPicture.asset('assets/recyclee.svg', 
            colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),),
          )),

          BottomNavigationBarItem(icon: SvgPicture.asset('assets/cart.svg', 
          colorFilter: ColorFilter.mode(AppColors.lightgrey, BlendMode.srcIn),), label: 'Cart',
          activeIcon: SvgPicture.asset('assets/cart.svg', 
          colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),)),

          BottomNavigationBarItem(icon: SvgPicture.asset('assets/User.svg',
          colorFilter: ColorFilter.mode(AppColors.lightgrey, BlendMode.srcIn),), label: 'Account',
          activeIcon: SvgPicture.asset('assets/User.svg', 
          colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),)),
        ]
        ),
    );
  }
}