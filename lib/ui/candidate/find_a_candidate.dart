import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/ui/candidate/selected_candidate_list.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

class FindACandidate extends StatefulWidget {
  static const String id = 'find_a_candidate';
  @override
  _FindACandidateState createState() => _FindACandidateState();
}

class _FindACandidateState extends State<FindACandidate> {

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _searchController = TextEditingController();

  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  /// A List to hold the all the available plans
  List<Category> _categories = List();

  /// An Integer variable to hold the length of [_plans]
  int _categoriesLength;

  /// A List to hold the widgets of all the plans
  List<Widget> _categoriesList = [];

  /// Function to fetch all the available plans from the database to
  /// [allCategories]
  void _allCategories() async {
    Future<List<Category>> names = futureValue.getAllCategoryFromDB();
    await names.then((value) {
      if(value.isEmpty || value.length == 0){
        if(!mounted)return;
        setState(() {
          _categoriesLength = 0;
          _categories = [];
        });
      } else if (value.length > 0){
        if(!mounted)return;
        setState(() {
          _categories.addAll(value.reversed);
          _categoriesLength = value.length;
        });
      }
    }).catchError((error){
      print(error);
      Constants.showError(context, error.toString());
    });
  }

  /// A function to build the list of all the available payments plans
  Widget _buildList() {
    if(_categories.length > 0 && _categories.isNotEmpty){
      _categoriesList.clear();
      for (int i = 0; i < _categories.length; i++){
        _categoriesList.add(
            Container(
              margin: EdgeInsets.only(bottom: 6),
              child: InkWell(
                onTap: (){
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (_){
                        return SelectedCandidateList(
                          category: _categories[i],
                        );
                      })
                  );
                },
                child: Container(
                  width: SizeConfig.screenWidth,
                  padding: EdgeInsets.only(left:8 ,top:9,bottom: 9 ),
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Image.network("${_categories[i].category.image}",height: 54,width: 54,fit: BoxFit.contain,),
                      ),
                      SizedBox(width:12,),
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
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      period: Duration(seconds: 3),
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey,
      child:  Container(
        margin: EdgeInsets.only(bottom: 6),
        child: Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.only(left:8 ,top:9,bottom: 9 ),
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Image.network("",height: 54,width: 54,fit: BoxFit.contain,),
              ),
              SizedBox(width:12,),
              Text(
                "Hire a ",
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

  //bool _showSpinner = false;

  @override
  void initState() {
    super.initState();
    _allCategories();
    print(_allCategories);
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
              SizedBox(height: 20,),
              IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 19,
                    color: Color(0xFF000000),
                  ),
                  onPressed:(){Navigator.pop(context);}
                  ),
              SizedBox(height: 30,),
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
              SizedBox(height: 8,),
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
              SizedBox(height: 32,),
              _buildSearch(),
              SizedBox(height: 8,),

              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(height: 16,),
//                        _buildCandidateContainer("Hire a Butler", "assets/icons/butler.png"),
//                        SizedBox(height: 6,),
//                        _buildCandidateContainer("Hire a Caregiver", "assets/icons/Caregiver.png"),
//                        SizedBox(height: 6,),
//                        _buildCandidateContainer("Hire a Carpenter", "assets/icons/Carpenter.png"),
//                        SizedBox(height: 6,),
//                        _buildCandidateContainer("Hire a Chauffeur", "assets/icons/chaffeur.png"),
//                        SizedBox(height: 6,),
//                        _buildCandidateContainer("Hire a Chef", "assets/icons/chef.png"),
//                        SizedBox(height: 6,),
//                        _buildCandidateContainer("Hire a Doorman", "assets/icons/doorman.png"),
//                        SizedBox(height: 6,),
//                        _buildCandidateContainer("Hire an Electrician", "assets/icons/electrician.png"),
//                        SizedBox(height: 6,),
//                        _buildCandidateContainer("Hire a Gardener", "assets/icons/gardener.png"),
//                        SizedBox(height: 6,),
//                        _buildCandidateContainer("Hire a Gatekeeper", "assets/icons/gatekeeper.png"),
//                        SizedBox(height: 6,),
//                        _buildCandidateContainer("Hire a Housekeeper", "assets/icons/Housekeeper.png"),
//                        SizedBox(height: 6,),
//                        _buildCandidateContainer("Hire a Nanny", "assets/icons/nanny.png"),
//                        SizedBox(height: 6,),
//                        _buildCandidateContainer("Hire a Plumber", "assets/icons/plumber.png"),
//                        SizedBox(height: 6,),
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
              //textInputAction: TextInputAction.next,
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

//  Widget _buildCandidateContainer(String candidateRole , String imagePath){
//    return InkWell(
//      onTap: (){
//        Navigator.push(context,
//            CupertinoPageRoute(builder: (_){
//              return SelectedCandidateList();
//            })
//        );
//      },
//      child: Container(
//        width: SizeConfig.screenWidth,
//        padding: EdgeInsets.only(left:8 ,top:9,bottom: 9 ),
//        decoration: BoxDecoration(
//          color: Color(0xFFFFFFFF),
//          borderRadius: BorderRadius.all(Radius.circular(6)),
//          border: Border.all(
//            width: 1,
//            color: Color(0xFFEBF1F4)
//          )
//        ),
//        child: Row(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: [
//            Container(
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.all(Radius.circular(6)),
//              ),
//              child: Image.asset(imagePath,height: 54,width: 54,fit: BoxFit.contain,),
//            ),
//            SizedBox(width:12,),
//            Text(
//              candidateRole,
//              textAlign: TextAlign.start,
//              style: TextStyle(
//                //letterSpacing: 1,
//                fontWeight: FontWeight.w400,
//                fontFamily: 'Gelion',
//                fontSize: 16,
//                color: Color(0xFF042538),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }

}
