import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/ui/candidate/selected-category.dart';
import 'package:householdexecutives_mobile/ui/candidate/short-listed-candidate.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';

class FindACategory extends StatefulWidget {

  static const String id = 'find_a_category';

  final bool hasList;

  const FindACategory({
    Key key,
    this.hasList
  }) : super(key: key);

  @override
  _FindACategoryState createState() => _FindACategoryState();
}

class _FindACategoryState extends State<FindACategory> {

  /// Checking if the filter controller is empty to reset the
  /// the filteredGiveaways to giveaways
  _FindACategoryState(){
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        if (!mounted) return;
        setState(() {
          _filteredCategories = _categories;
        });
      }
    });
  }

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _filter = TextEditingController();

  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  /// A Map to hold the all the available categories and a boolean value to
  /// show if selected or not
  Map<Category, List<Candidate>> _candidates = {};

  /// A Map to hold the all the available categories and a boolean value to
  /// show if selected or not
  Map<Category, bool> _categoriesSelection = {};

  /// A List to hold the all the categories
  List<Category> _categories = [];

  /// Variable of List<[Category]> to hold all the filtered categories
  List<Category> _filteredCategories = [];

  /// An Integer variable to hold the length of [_categories]
  int _categoriesLength;

  /// A List to hold the widgets of all the category widgets
  List<Widget> _categoriesList = [];

  /// [allCategories]
  void _allCategories() async {
    Future<List<Category>> names = futureValue.getAllCategoryFromDB();
    await names.then((value) {
      _getList();
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          _categoriesLength = 0;
          _categories = [];
          _filteredCategories = [];
          _categoriesSelection = {};
          _candidates = {};
        });
      }
      else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          _categories.addAll(value.reversed);
          _filteredCategories = _categories;
          _categoriesLength = value.length;
          for(int i = 0; i < value.length; i++){
            _categoriesSelection[value[i]] = false;
            _candidates[value[i]] = [];
          }
        });
      }
      if(widget.hasList == true){
        if(!mounted)return;
        Navigator.push(context,
            CupertinoPageRoute(builder: (_){
              return ShortListedCandidate(
                candidates: _candidates,
              );
            })
        ).then((val) {
          if(val != null){
            if(!mounted)return;
            setState(() { _candidates = val; });
          }
        });
      }
    }).catchError((e){
      print(e);
      Functions.showError(context, e);
    });
  }

  /// A function to build the list of all the categories
  Widget _buildList() {
    if(_categories.length > 0 && _categories.isNotEmpty){
      _categoriesList.clear();
      for (int i = 0; i < _filteredCategories.length; i++){
        _categoriesList.add(
            InkWell(
              onTap: (){
                Navigator.push(context,
                    CupertinoPageRoute(builder: (_){
                      return SelectedCategory(
                        category: _filteredCategories[i],
                        candidates: _candidates[_filteredCategories[i]],
                      );
                    })
                ).then((value) {
                  if(value != null){
                    if(value.isNotEmpty){
                      if(!mounted)return;
                      setState(() {
                        _candidates[_filteredCategories[i]] = value[1];
                      });
                      if(value[0] == true){
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (_){
                              return ShortListedCandidate(
                                candidates: _candidates,
                              );
                            })
                        ).then((val) {
                          if(val != null){
                            if(!mounted)return;
                            setState(() {
                              _candidates = val;
                            });
                          }
                        });
                      }
                    }
                  }
                });
              },
              child: Container(
                width: SizeConfig.screenWidth,
                padding: EdgeInsets.only(left: 8, top: 9, bottom: 9),
                margin: EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    border: Border.all(
                        width: 1,
                        color: Color(0xFFEBF1F4)
                    )
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 54,
                      width: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: _filteredCategories[i].category.image,
                        height: 54,
                        width: 54,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Container(),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Hire a ${_filteredCategories[i].category.name}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 16,
                        color: Color(0xFF042538),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        );
      }
      return Column(
        children: _categoriesList,
      );
    }
    else if(_categoriesLength == 0){
      return Container();
    }
    return SkeletonLoader(
      builder: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              color: Colors.white.withOpacity(0.5),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 20,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
      items: 20,
      period: Duration(seconds: 2),
      highlightColor: Color(0xFF1F1F1F),
      direction: SkeletonDirection.ltr,
    );
  }

  Widget _buildSearch() {
    return Container(
      color: Color(0xFF717F88).withOpacity(0.1),
      width: SizeConfig.screenWidth,
      child: TextFormField(
        controller: _filter,
        keyboardType: TextInputType.text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          fontFamily: 'Gelion',
          color: Color(0xFF042538),
        ),
        onChanged: (value){
          if(_filter.text != '' || _filter.text.isNotEmpty){
            List<Category> tempList = [];
            for (int i = 0; i < _filteredCategories.length; i++) {
              if (_filteredCategories[i].category.name.toLowerCase()
                  .contains(_filter.text.toLowerCase())) {
                tempList.add(_filteredCategories[i]);
              }
            }
            if(!mounted)return;
            setState(() {
              _filteredCategories = tempList;
            });
          }
        },
        decoration:kFieldDecoration.copyWith(
            hintText: 'Search keywords...',
            suffixIcon: Icon(Icons.search , color:Color(0xFF6F8A9C), size: 18,),
            hintStyle:TextStyle(
              color:Color(0xFF6F8A9C),
              fontSize: 14,
              fontFamily: 'Gelion',
              fontWeight: FontWeight.normal,
            )
        ),
      ),
    );
  }

  /// This function saves user's shortlisted candidates temporarily from shared
  /// preference then stores it back to [_candidates]
  /// 'checkoutCategory' key for key in [_candidates] and
  /// 'checkoutCandidates' key for value in [_candidates]
  void _getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String checkoutCategory = prefs.getString('checkoutCategory');
    String checkoutCandidates = prefs.getString('checkoutCandidates');

    if(checkoutCategory != null && checkoutCandidates != null){
      var tempCategory = jsonDecode(checkoutCategory) as List;
      var rest = jsonDecode(checkoutCandidates) as List;

      if(!mounted)return;
      setState(() {
        _candidates.forEach((key, value) {
          for(int i = 0; i < tempCategory.length; i++){
            if(tempCategory[i] == key.category.id){
              _candidates[key] = rest[i].map<Candidate>((json) => Candidate.fromJson(json)).toList();
            }
          }
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _allCategories();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 20,
              color: Color(0xFF000000),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left:24, right:24),
            width: SizeConfig.screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  'Find A Candidate!',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Gelion',
                    fontSize: 19,
                    color: Color(0xFFF7941D),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Experienced, Professional & Vetted',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFF57565C),
                      ),
                    ),
                    _candidates.values.any((element) => element.length > 0)
                        ? TextButton(
                      onPressed: (){
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (_){
                              return ShortListedCandidate(
                                candidates: _candidates,
                              );
                            })
                        ).then((val) {
                          if(val != null){
                            if(!mounted)return;
                            setState(() { _candidates = val; });
                          }
                        });
                      },
                      child: Text(
                        "Checkout",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 16,
                          color: Color(0xFF00A69D),
                        ),
                      ),
                    )
                        : Container()
                  ],
                ),
                SizedBox(height: 32),
                _buildSearch(),
                SizedBox(height: 8),
                Expanded(
                  child: Container(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollUpdateNotification) {
                          HapticFeedback.selectionClick();
                        }
                        return;
                      },
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(height: 16),
                            _buildList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
