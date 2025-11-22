import 'dart:io';
import 'package:dash_tv/features/bookmarks/ui/bookmarks_page.dart';
import 'package:dash_tv/features/explore/ui/explore_page.dart';
import 'package:dash_tv/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../common/widget/exit_dialog.dart';
import '../../common/widget/title_widget.dart';
import '../../core/router/app_router.dart';
import '../home/ui/page/home_page.dart';
import 'drawer/drawer_menu_button.dart';

enum BottomTabType { home, explore, bookmark }

class BottomTabItem {
  final BottomTabType type;
  final IconData icon;
  final String label;
  final Widget screen;

  const BottomTabItem({
    required this.type,
    required this.icon,
    required this.label,
    required this.screen,
  });
}

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final List<BottomTabItem> tabs = [
    const BottomTabItem(
      type: BottomTabType.home,
      icon: Icons.home,
      label: "Home",
      screen: HomePage(key: PageStorageKey("home")),
    ),
    BottomTabItem(
      type: BottomTabType.explore,
      icon: Icons.explore,
      label: "Explore",
      screen: const ExplorePage(key: PageStorageKey("explore")),
    ),
    const BottomTabItem(
      type: BottomTabType.bookmark,
      icon: Icons.bookmarks_rounded,
      label: "Bookmark",
      screen: BookmarkPage(key: PageStorageKey("bookmark")),
    ),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        if (tabController.index != 0) {
          tabController.animateTo(0);
          return;
        }

        final shouldExit = await context.showExitDialog();
        if (shouldExit == true) {
          exit(0);
        }
      },
      child: Scaffold(
        extendBody: true,

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const DrawerMenuButton(),
          title: tabController.index == 0
              ? DashTvTitle()
              : Text(
                  tabs[tabController.index].label,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                GoRouter.of(context).pushNamed(AppRouteEnum.search.name);
              },
              splashRadius: 22,
              icon: const Icon(Icons.search, color: Colors.black),
            ),
          ],
        ),

        /// 🚀 Smooth swipe + screens kept alive with PageStorageKey
        body: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: tabs.map((e) => e.screen).toList(),
        ),

        bottomNavigationBar: AnimatedBuilder(
          animation: tabController,
          builder: (_, _) => _buildBottomBar(),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: kToolbarHeight + 4,
      decoration: BoxDecoration(
        color: kWhiteColor,
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            offset: Offset(6, 6),
            spreadRadius: 1,
            blurRadius: 4,
          ),
          BoxShadow(
            color: kSecondaryColor.withOpacity(0.1),
            offset: const Offset(-6, -6),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),

      child: TabBar(
        controller: tabController,
        indicatorColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,

        tabs: List.generate(tabs.length, (index) {
          final item = tabs[index];
          final isSelected = tabController.index == index;

          return TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 200),
            tween: Tween(
              begin: isSelected ? 1.0 : 0.0,
              end: isSelected ? 1.0 : 0.0,
            ),
            builder: (_, value, _) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? kMainColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      color: isSelected ? kPrimaryColor : kBlack54Color,
                      size: 22,
                    ),

                    if (value > 0)
                      Opacity(
                        opacity: value,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            item.label,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              // fontStyle: FontStyle.italic,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
