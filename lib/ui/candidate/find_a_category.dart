import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/ui/candidate/selected_category.dart';
import 'package:householdexecutives_mobile/ui/candidate/short_listed_candidate.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class FindACategory extends StatefulWidget {

  static const String id = 'find_a_category';

  @override
  _FindACategoryState createState() => _FindACategoryState();
}

class _FindACategoryState extends State<FindACategory> {

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _searchController = TextEditingController();

  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  /// A Map to hold the all the available categories and a boolean value to
  /// show if selected or not
  Map<Category, List<Candidate>> _candidates = {};

  /// A Map to hold the all the available categories and a boolean value to
  /// show if selected or not
  Map<Category, bool> _categoriesSelection = {};

  /// A List to hold the all the available plans
  List<Category> _categories = [];

  /// An Integer variable to hold the length of [_plans]
  int _categoriesLength;

  /// A List to hold the widgets of all the plans
  List<Widget> _categoriesList = [];

  /// [allCategories]
  void _allCategories() async {
    Future<List<Category>> names = futureValue.getAllCategoryFromDB();
    await names.then((value) {
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          _categoriesLength = 0;
          _categories = [];
          _categoriesSelection = {};
          _candidates = {};
        });
      } else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          _categories.addAll(value.reversed);
          _categoriesLength = value.length;
          for(int i = 0; i < value.length; i++){
            _categoriesSelection[value[i]] = false;
            _candidates[value[i]] = [];
          }
        });
      }
    }).catchError((e){
      print(e);
      Constants.showError(context, e);
    });
  }

  /// A function to build the list of all the available payments plans
  Widget _buildList() {
    if(_categories.length > 0 && _categories.isNotEmpty){
      _categoriesList.clear();
      for (int i = 0; i < _categories.length; i++){
        _categoriesList.add(
            InkWell(
              onTap: (){
                Navigator.push(context,
                    CupertinoPageRoute(builder: (_){
                      return SelectedCategory(
                        category: _categories[i],
                        candidates: _candidates[_categories[i]],
                      );
                    })
                ).then((value) {
                  print(value);
                  if(value != null){
                    if(value.isNotEmpty){
                      if(!mounted)return;
                      setState(() {
                        _candidates[_categories[i]] = value[1];
                      });
                      if(value[0] == true){
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (_){
                              return ShortListedCandidate(
                                candidates: _candidates,
                              );
                            })
                        );
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
                      child: Image.network(
                        _categories[i].category.image,
                        height: 54,
                        width: 54,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace){
                          return Container();
                        },
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Hire a ${_categories[i].category.name}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        //letterSpacing: 1,
                        fontWeight: FontWeight.w400,
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color:Color(0xFF717F88).withOpacity(0.1),
            width: SizeConfig.screenWidth,
            child: TextFormField(
              controller: _searchController,
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gelion',
                color: Color(0xFF042538),
              ),
              decoration:kFieldDecoration.copyWith(
                  hintText: 'Search keywords...',
                  suffixIcon: Icon(Icons.search , color:Color(0xFF6F8A9C), size: 18,),
                  hintStyle:TextStyle(
                    color:Color(0xFF6F8A9C),
                    fontSize: 14,
                    fontFamily: 'Gelion',
                    fontWeight: FontWeight.w400,
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _allCategories();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left:24,right:24),
          width: SizeConfig.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 19,
                    color: Color(0xFF000000),
                  ),
                  onPressed:(){Navigator.pop(context);}
                  ),
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
                      //letterSpacing: 1,
                      fontWeight: FontWeight.w400,
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
                      );
                    },
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
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
              )
            ],
          ),
        ),
      ),
    );
  }

}
