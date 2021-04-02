
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                'Find a candidate!',
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
                'Aliqua id fugiat nostrud irure ex duis ea quis\nid quis ad et. ',
                textAlign: TextAlign.start,
                style: TextStyle(
                  //letterSpacing: 1,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gelion',
                  fontSize: 14,
                  color: Color(0xFF57565C),
                ),
              ),
              SizedBox(height: 15,),
              _buildSearch(),
              SizedBox(height: 8,),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(height: 16,),
                        InkWell
                          (
                          onTap: (){
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (_){
                                  return SelectedCandidateList();
                                })
                            );
                          },
                            child: _buildCandidateContainer("Hire a Chef", "assets/icons/chef.png")),
                        SizedBox(height: 6,),
                        _buildCandidateContainer("Hire a Butler", "assets/icons/butler.png"),
                        SizedBox(height: 6,),
                        _buildCandidateContainer("Hire a Carpenter", "assets/icons/Carpenter.png"),
                        SizedBox(height: 6,),
                        _buildCandidateContainer("Hire a Chauffer", "assets/icons/Chauffer.png"),
                        SizedBox(height: 6,),
                        _buildCandidateContainer("Hire a Housekeeper", "assets/icons/Housekeeper.png"),
                        SizedBox(height: 6,),
                        _buildCandidateContainer("Hire a Home Tutor", "assets/icons/Home Tutor.png"),
                        SizedBox(height: 6,),
                        _buildCandidateContainer("Hire Dog Walker", "assets/icons/Dog Walker.png"),
                        SizedBox(height: 6,),
                        _buildCandidateContainer("Hire a Hair Stylist", "assets/icons/Hair Stylist.png"),
                        SizedBox(height: 6,),
                        _buildCandidateContainer("Hire a Barber", "assets/icons/Barber.png"),
                        SizedBox(height: 6,),
                        _buildCandidateContainer("Hire a Caregiver", "assets/icons/Caregiver.png"),
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
      onTap: null,
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
