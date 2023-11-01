import 'package:flutter/material.dart';

class UbiAnasayfa extends StatefulWidget {
  const UbiAnasayfa({super.key});

  @override
  State<UbiAnasayfa> createState() => _UbiAnasayfaState();
}

class _UbiAnasayfaState extends State<UbiAnasayfa> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 5, vsync: this);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(right: 250),
            child: Text(
              "Hoş geldin, ",
              style: TextStyle(
                  fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10,),
          SingleChildScrollView(
            child: Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  indicatorColor: Colors.red,
                  indicatorPadding: EdgeInsets.only(bottom: 7),
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: "Sanat",),
                    Tab(text: "Spor",),
                    Tab(text: "Akış",),
                    Tab(text: "Teknoloji",),
                    Tab(text: "Bilim",),
                  ],
                ),
              ),
            ),
          ),
               Container(
              height: 440.4285,
              width: double.maxFinite,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Text("mandalina"),
                  Text("armut"),
                  Text("erik"),
                  Text("şeftali"),
                  Text("kiraz"),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
