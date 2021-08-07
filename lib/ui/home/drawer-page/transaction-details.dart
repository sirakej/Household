import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/transaction.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:intl/intl.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';

class TransactionAndPayments extends StatefulWidget{

  @override
  _TransactionAndPaymentsState createState() => _TransactionAndPaymentsState();
}

class _TransactionAndPaymentsState extends State<TransactionAndPayments> with SingleTickerProviderStateMixin{

  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  /// Converting [dateTime] in string format to return a formatted time
  /// of hrs, minutes and am/pm
  String _getFormattedDate(DateTime dateTime) {
    return DateFormat('d.L.y').format(dateTime).toString().toUpperCase();
  }

  /// A List to hold the all the available categories
  List<Transaction> _transactions = [];

  /// An Integer variable to hold the length of [_transactions]
  int _transactionsLength;

  /// Function to fetch all the saved list from the database to
  /// [_transactions]
  void _allTransactionList() async {
    Future<List<Transaction>> list = futureValue.getTransactionHistoryFromDB();
    await list.then((value) {
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          _transactionsLength = 0;
          _transactions = [];
        });
      }
      else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          _transactions.addAll(value.reversed);
          _transactionsLength = value.length;
        });
      }
    }).catchError((e){
      print(e);
      Functions.showError(context, e);
    });
  }

  /// A function to build the list of all the transactions
  Widget _buildAllTransactionList() {
    List<Widget> transactionContainer = [];
    if(_transactions.length > 0 && _transactions.isNotEmpty){
      for (int i = 0; i < _transactions.length; i++){
        transactionContainer.add(
            Container(
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFECECEC), width: 1),
                )
              ),
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
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 17,
                          color: Color(0xFF042538),
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "${_transactions[i].totalHire} Hires",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          color: Color(0xFFF7941D),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        Functions.money(_transactions[i].totalAmount, 'N'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 20,
                          color: Color(0xFF042538),
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        _getFormattedDate(_transactions[i].createdAt),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          color: Color(0xFF717F88),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
        );
      }
      return Column(
        children: transactionContainer,
      );
    }
    else if(_transactionsLength == 0){
      return _buildEmpty('You have not made any Transactions\nat the moment');
    }
    return Container(
        child: Center(child: CupertinoActivityIndicator(radius: 15))
    );
  }

  Widget _buildEmpty(String description){
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
          children : [
            Image.asset(
                'assets/icons/empty.png',
                width: 143,
                height: 108,
                fit: BoxFit.contain
            ),
            SizedBox(height: 24),
            Text(
              "Empty List",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'Gelion',
                fontSize: 19,
                color: Color(0xFF000000),
              ),
            ),
            SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'Gelion',
                fontSize: 14,
                color: Color(0xFF3B4A54),
              ),
            ),
            SizedBox(height: 150),
        ]
      )
    );
  }

  @override
  void initState(){
    super.initState();
    _allTransactionList();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFCFDFE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            //Icons.menu,
            Icons.arrow_back_ios,
            size: 20,
            color: Color(0xFF000000),
          ),
          onPressed: () {
            //_scaffoldKey.currentState.openDrawer();
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Transactions & Payments",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: 'Gelion',
            fontSize: 19,
            color: Color(0xFF000000),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24, 25, 24, 0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: _buildAllTransactionList()
        ),
      ),
    );
  }

}
