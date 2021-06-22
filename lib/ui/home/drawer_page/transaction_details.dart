import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

class TransactionAndPayments extends StatefulWidget{
  @override
  _TransactionAndPaymentsState createState() => _TransactionAndPaymentsState();
}

class _TransactionAndPaymentsState extends State<TransactionAndPayments> with SingleTickerProviderStateMixin{
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        width:SizeConfig.screenWidth,
        padding:EdgeInsets.only(left:24,right: 24),
        child: Column(
          children: [
            SizedBox(height:20),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                    icon:Icon(
                      Icons.menu,
                      size: 20,
                      color: Color(0xFF000000),
                    )
                ),
                Center(
                  child: Text(
                    "Transactions & Payments",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gelion',
                      fontSize: 19,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height:4),
            SizedBox(height: 15,),
            _buildTransactionAndPayments(2, "N 400,000", "20.06.2021"),
            SizedBox(height: 18,),
            Container(
              height: 1,
              width: SizeConfig.screenWidth,
              color: Color(0xFFECECEC),
            ),
            SizedBox(height: 15,),
            _buildTransactionAndPayments(2, "N 400,000", "20.06.2021"),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionAndPayments(int countHires, String price, String date){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Services Payment",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gelion',
                  fontSize: 16,
                  color: Color(0xFF042538),
                ),
              ),
              SizedBox(height:4),
              Text(
                "$countHires Hires",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gelion',
                  fontSize: 16,
                  color: Color(0xFFF7941D),
                ),
              ),

            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                price,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gelion',
                  fontSize: 16,
                  color: Color(0xFF042538),
                ),
              ),
              SizedBox(height:4),
              Text(
                date,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gelion',
                  fontSize: 16,
                  color: Color(0xFF717F88),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
