import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';

import 'tabs/applications/applications_tab.dart';
import 'tabs/browse/browse_tab.dart';
import 'tabs/foundations/foundations_tab.dart';
import 'tabs/grants/grants_tab.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final _myTabs = ['Browse', 'Applications', 'Grants', 'Foundations'];
  String _currentTitle;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _currentTitle = _myTabs[0];
    _tabController = TabController(length: 4, vsync: this)
      ..addListener(() {
        // TODO(@shekohex): move this to another void.
        setState(() {
          _currentTitle = _myTabs[_tabController.index];
        });
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          _currentTitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: 27.ssp.toDouble(),
          ),
        ),
        primary: true,
        titleSpacing: 18.w.toDouble(),
        actions: [const AccountAvatar(), SizedBox(width: 22.w.toDouble())],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BrowseTab(),
          ApplicationsTab(),
          GrantsTab(),
          FoundationsTab(),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFD7DAE1),
        child: Padding(
          padding: EdgeInsets.only(bottom: ScreenUtil.bottomBarHeight - 8.h),
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: AppColors.primary,
            labelStyle: TextStyle(fontSize: 10.ssp.toDouble()),
            tabs: [
              Tab(
                text: _myTabs[0],
                icon: Icon(Icons.remove_red_eye),
              ),
              Tab(
                text: _myTabs[1],
                icon: Icon(Icons.assignment),
              ),
              Tab(
                text: _myTabs[2],
                icon: Icon(Icons.business_center),
              ),
              Tab(
                text: _myTabs[3],
                icon: Icon(Icons.people),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountAvatar extends StatelessWidget {
  const AccountAvatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) => AccountDetailsSheet(),
        );
      },
      child: CircleAvatar(
        radius: 18.w.toDouble(),
        backgroundColor: Colors.black,
        child: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
    );
  }
}
