import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/ui/candidate/selected_candidate_list.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

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
          _categories.addAll(value);
          _categoriesLength = value.length;
        });
      }
    }).catchError((error){
      print(error);
      Constants.showError(context, error.toString());
    });
  }

  /// A function to build the list of all the available payments plans
//  Widget _buildList() {
//    if(_plans.length > 0 && _plans.isNotEmpty){
//      _planList.clear();
//      for (int i = 0; i < _plans.length; i++){
//        if(_plans[i].freeplan){
//          _planList.add(
//              GestureDetector(
//                onTap: (){
////                  Navigator.of(context).pushReplacement(
////                      easeIn(context, Index(currentIndex: 0), Offset(1.0, 0.0))
////                  );
//                },
//                child: Container(
//                  padding: EdgeInsets.fromLTRB(27, 23, 27, 26),
//                  margin: EdgeInsets.only(bottom: 16),
//                  width: SizeConfig.screenWidth - 32,
//                  decoration: BoxDecoration(
//                    color: Color(0xFFFFFFFF),
//                    borderRadius: BorderRadius.all(Radius.circular(10)),
//                  ),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      Text(
//                        _plans[i].title,
//                        textAlign: TextAlign.start,
//                        style: TextStyle(
//                            fontFamily: 'Graphik',
//                            fontSize: 16,
//                            fontWeight: FontWeight.w500,
//                            color: Color(0xFF06C03A)
//                        ),
//                      ),
//                      SizedBox(height: 8.5),
//                      Row(
//                        children: [
//                          Container(
//                            width: 6,
//                            height: 6,
//                            decoration: BoxDecoration(
//                              shape: BoxShape.circle,
//                              color: Color(0xFF002C9D).withOpacity(0.1),
//                            ),
//                          ),
//                          SizedBox(width: 8),
//                          Container(
//                            width: SizeConfig.screenWidth - 150,
//                            child: Text(
//                              '${_plans[i].noOfBasicAssessment} Basic assessment or ${_plans[i].noOfEnhancedAssessment} enhanced assessment',
//                              style: TextStyle(
//                                  fontFamily: 'Graphik',
//                                  fontSize: 12,
//                                  color: Color(0xFF000000).withOpacity(0.5)
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                      SizedBox(height: 8),
//                      Row(
//                        children: [
//                          Container(
//                            width: 6,
//                            height: 6,
//                            decoration: BoxDecoration(
//                              shape: BoxShape.circle,
//                              color: Color(0xFF002C9D).withOpacity(0.1),
//                            ),
//                          ),
//                          SizedBox(width: 8),
//                          Container(
//                            width: SizeConfig.screenWidth - 150,
//                            child: Text(
//                              'Valid for ${_plans[i].duration} days',
//                              style: TextStyle(
//                                  fontFamily: 'Graphik',
//                                  fontSize: 12,
//                                  color: Color(0xFF000000).withOpacity(0.5)
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//              )
//          );
//        }
//        else if(_plans[i].payAsYouGo){
//          _planList.add(
//            GestureDetector(
//              onTap: (){
//                Navigator.of(context).pushReplacement(
//                    easeIn(context, Index(currentIndex: 0), Offset(1.0, 0.0))
//                );
//              },
//              child: Container(
//                padding: EdgeInsets.fromLTRB(27, 23, 27, 29.51),
//                margin: EdgeInsets.only(bottom: 16),
//                width: SizeConfig.screenWidth - 32,
//                decoration: BoxDecoration(
//                  color: Color(0xFF00154C),
//                  borderRadius: BorderRadius.all(Radius.circular(10)),
//                ),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                    Text(
//                      _plans[i].title,
//                      textAlign: TextAlign.start,
//                      style: TextStyle(
//                          fontFamily: 'Graphik',
//                          fontSize: 16,
//                          fontWeight: FontWeight.w500,
//                          color: Color(0xFF06C03A)
//                      ),
//                    ),
//                    SizedBox(height: 8.5),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: [
//                        Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//                            Row(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: [
//                                Container(
//                                  padding: EdgeInsets.only(top: 4),
//                                  child: Text(
//                                    '£',
//                                    style: TextStyle(
//                                      fontFamily: 'Graphik',
//                                      fontSize: 12,
//                                      fontWeight: FontWeight.w500,
//                                      color: Color(0xFFFFFFFF),
//                                    ),
//                                  ),
//                                ),
//                                RichText(
//                                  textAlign: TextAlign.center,
//                                  text: TextSpan(
//                                    text: '${_plans[i].priceOfBasicAssessment}.',
//                                    style: TextStyle(
//                                      fontFamily: 'Graphik',
//                                      fontSize: 25,
//                                      fontWeight: FontWeight.w600,
//                                      color: Color(0xFFFFFFFF),
//                                    ),
//                                    children: <TextSpan>[
//                                      TextSpan(
//                                          text: '00',
//                                          style: TextStyle(
//                                            fontFamily: 'Graphik',
//                                            fontSize: 20,
//                                            fontWeight: FontWeight.w600,
//                                            color: Color(0xFFFFFFFF),
//                                          )
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ],
//                            ),
//                            Text(
//                              'per basic assessment',
//                              textAlign: TextAlign.start,
//                              style: TextStyle(
//                                fontFamily: 'Graphik',
//                                fontSize: 8,
//                                color: Color(0xFFFFFFFF),
//                              ),
//                            ),
//                          ],
//                        ),
//                        Container(
//                          padding: EdgeInsets.only(top: 8),
//                          alignment: Alignment.center,
//                          child: Container(
//                            width: 1,
//                            height: 27.95,
//                            color: Color(0xFF8795B8),
//                          ),
//                        ),
//                        Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//                            Row(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: [
//                                Container(
//                                  padding: EdgeInsets.only(top: 4),
//                                  child: Text(
//                                    '£',
//                                    style: TextStyle(
//                                      fontFamily: 'Graphik',
//                                      fontSize: 12,
//                                      fontWeight: FontWeight.w500,
//                                      color: Color(0xFFFFFFFF),
//                                    ),
//                                  ),
//                                ),
//                                RichText(
//                                  textAlign: TextAlign.center,
//                                  text: TextSpan(
//                                    text: '${_plans[i].priceOfEnhancedAssessment}.',
//                                    style: TextStyle(
//                                      fontFamily: 'Graphik',
//                                      fontSize: 25,
//                                      fontWeight: FontWeight.w600,
//                                      color: Color(0xFFFFFFFF),
//                                    ),
//                                    children: <TextSpan>[
//                                      TextSpan(
//                                          text: '00',
//                                          style: TextStyle(
//                                            fontFamily: 'Graphik',
//                                            fontSize: 20,
//                                            fontWeight: FontWeight.w600,
//                                            color: Color(0xFFFFFFFF),
//                                          )
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ],
//                            ),
//                            Text(
//                              'per enhanced assessment',
//                              textAlign: TextAlign.start,
//                              style: TextStyle(
//                                fontFamily: 'Graphik',
//                                fontSize: 8,
//                                color: Color(0xFFFFFFFF),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ],
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          );
//        }
//        else {
//          _planList.add(
//            _buildContainer(_plans[i]),
//          );
//        }
//      }
//      _planList.add(
//          Container(
//            padding: EdgeInsets.fromLTRB(27, 23, 27, 26),
//            width: SizeConfig.screenWidth - 32,
//            decoration: BoxDecoration(
//              color: Color(0xFF00154D),
//              borderRadius: BorderRadius.all(Radius.circular(10)),
//            ),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: [
//                Text(
//                  'Custom Package',
//                  textAlign: TextAlign.start,
//                  style: TextStyle(
//                      fontFamily: 'Graphik',
//                      fontSize: 16,
//                      fontWeight: FontWeight.w500,
//                      color: Color(0xFF06C03A)
//                  ),
//                ),
//                SizedBox(height: 8.5),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: [
//                    Container(
//                      child: Row(
//                        children: [
//                          Container(
//                            width: 6,
//                            height: 6,
//                            decoration: BoxDecoration(
//                                shape: BoxShape.circle,
//                                color: Color(0xFFFFFFFF).withOpacity(0.4)
//                            ),
//                          ),
//                          SizedBox(width: 8),
//                          Container(
//                            width: (SizeConfig.screenWidth - 150) / 2,
//                            child: Text(
//                              'Please contact us to discuss',
//                              style: TextStyle(
//                                  fontFamily: 'Graphik',
//                                  fontSize: 12,
//                                  color: Color(0xFFFFFFFF)
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                    GestureDetector(
//                      onTap: (){
//
//                      },
//                      child: Container(
//                        padding: EdgeInsets.fromLTRB(0, 11, 0, 11),
//                        width: (SizeConfig.screenWidth - 150) / 2,
//                        alignment: Alignment.center,
//                        decoration: BoxDecoration(
//                          color: Color.fromARGB(19, 255, 255, 255),
//                          borderRadius: BorderRadius.all(Radius.circular(3)),
//                        ),
//                        child: Text(
//                          'Contact Us',
//                          textAlign: TextAlign.center,
//                          style: TextStyle(
//                              fontFamily: 'Graphik',
//                              fontSize: 13,
//                              fontWeight: FontWeight.w500,
//                              color: Color(0xFFFFFFFF)
//                          ),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ],
//            ),
//          )
//      );
//      return Column(
//        children: _planList,
//      );
//    }
//    else if(_planLength == 0){
//      return Container();
//    }
//    return Center(child: CupertinoActivityIndicator(radius: 15));
//  }

  bool _showSpinner = false;

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
//                        Container(height: 16,),
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

  Widget _buildCandidateContainer(String candidateRole , String imagePath){
    return InkWell(
      onTap: (){
        Navigator.push(context,
            CupertinoPageRoute(builder: (_){
              return SelectedCandidateList();
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
              child: Image.asset(imagePath,height: 54,width: 54,fit: BoxFit.contain,),
            ),
            SizedBox(width:12,),
            Text(
              candidateRole,
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
    );
  }

}
