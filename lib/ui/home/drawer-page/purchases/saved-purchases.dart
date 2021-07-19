import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/saved-candidates.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:intl/intl.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'purchases-tab.dart';

class SavedPurchases extends StatefulWidget {

  static const String id = 'saved_purchases';

  @override
  _SavedPurchasesState createState() => _SavedPurchasesState();
}

class _SavedPurchasesState extends State<SavedPurchases> {

  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  /// GlobalKey of a my RefreshIndicatorState to refresh my list items
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  /// Converting [dateTime] in string format to return a formatted time
  /// of hrs, minutes and am/pm
  String _getFormattedDate(DateTime dateTime) {
    return DateFormat('MMM d, y').format(dateTime).toString();
  }

  /// A List to hold the all the purchases
  List<MySavedList> _purchases = [];

  /// An Integer variable to hold the length of [_purchases]
  int _purchasesLength;

  /// Function to fetch all the purchases from the database to
  /// [_purchases]
  void _allPurchases() async {
    Future<List<MySavedList>> list = futureValue.getAllSavedListFromDB();
    await list.then((value) {
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          _purchasesLength = 0;
          _purchases = [];
        });
      }
      else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          _purchases.addAll(value.reversed);
          _purchasesLength = value.length;
        });
      }
    }).catchError((e){
      print(e);
      Functions.showError(context, e);
    });
  }

  /// A function to build the list of all purchases
  Widget _buildAllPurchases() {
    List<Widget> purchasesContainer = [];
    if(_purchases.length > 0 && _purchases.isNotEmpty){
      for (int i = 0; i < _purchases.length; i++){
        List<Widget> categories = [];
        for(int j = 0; j < _purchases[i].savedCategory.length; j++){
          categories.add(
            Text(
              "${_purchases[i].savedCategory[j].candidatePlan.length} ${_purchases[i].savedCategory[j].getCategory.name}",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'Gelion',
                fontSize: 14,
                color: Color(0xFF717F88),
              ),
            )
          );
        }
        purchasesContainer.add(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getFormattedDate(_purchases[i].purchase.createdAt),
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    fontSize: 14,
                    color: Color(0xFF717F88),
                  ),
                ),
                SizedBox(height: 12),
                InkWell(
                  onTap: (){
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (_){
                          return PurchasesTab(
                            categories: _purchases[i].savedCategory,
                          );
                        }
                        )
                    ).then((value) => _refresh());
                  },
                  child: Container(
                    width: SizeConfig.screenWidth,
                    padding: EdgeInsets.fromLTRB(16, 21, 13, 22),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      border: Border.all(
                          color: Color(0xFFEBF1F4),
                          width: 1,
                          style: BorderStyle.solid
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Purchase ${i + 1}",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFF042538),
                                ),
                              ),
                              SizedBox(height: 13),
                              Container(
                                width: SizeConfig.screenWidth - 120,
                                height: 1,
                                color: Color(0xFF000000).withOpacity(0.1),
                              ),
                              SizedBox(height: 13),
                              Wrap(
                                  spacing: 18,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: categories
                              ),
                            ]
                        ),
                        Icon(
                            Icons.arrow_forward,
                            color: Color(0xFF00A69D),
                            size: 16
                        )
                      ]
                    ),
                  ),
                ),
                SizedBox(height: 18),
              ],
            )
        );
      }
      return Column(
        children: purchasesContainer,
      );
    }
    else if(_purchasesLength == 0){
      return _buildEmpty('You have not made any Purchases\nat the moment');
    }
    return Container(
        padding: EdgeInsets.only(top: 100),
        child: Center(child: CupertinoActivityIndicator(radius: 15))
    );
    return SkeletonLoader(
      builder: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 20,
              color: Colors.white.withOpacity(0.5),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 22,
              color: Colors.white.withOpacity(0.5),
            ),
          ],
        ),
      ),
      items: 20,
      period: Duration(seconds: 3),
      highlightColor: Color(0xFFEBF1F4),
      direction: SkeletonDirection.btt,
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
            ]
        )
    );
  }

  /// Function to refresh details of the list of all the saved purchases user has
  /// similar to [_allPurchases()]
  Future<Null> _refresh() {
    Future<List<MySavedList>> list = futureValue.getAllSavedListFromDB();
    return list.then((value) {
      _purchases.clear();
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          _purchasesLength = 0;
          _purchases = [];
        });
      }
      else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          _purchases.addAll(value);
          _purchasesLength = value.length;
        });
      }
    }).catchError((e){
      print(e);
      Functions.showError(context, e);
    });
  }

  @override
  void initState() {
    super.initState();
    _allPurchases();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return RefreshIndicator(
      onRefresh: _refresh,
      key: _refreshIndicatorKey,
      color: Color(0xFF00A69D),
      child: Scaffold(
        backgroundColor: Color(0xFFFCFDFE),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
              color: Color(0xFF000000),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          elevation: 0,
          title: Text(
            "My Purchases",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'Gelion',
              fontSize: 19,
              color: Color(0xFF000000),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.fromLTRB(24, 14, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'You’re only allowed to select a maximmum of 3\ncandidates per category',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    fontSize: 12.6829,
                    color: Color(0xFF57565C),
                  ),
                ),
                SizedBox(height: 33.39),
                _buildAllPurchases(),
                SizedBox(height: SizeConfig.screenHeight - 200),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
