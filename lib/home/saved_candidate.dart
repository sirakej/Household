import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

class SavedCandidate extends StatefulWidget {
  static const String id = 'saved_candidate';
  @override
  _SavedCandidateState createState() => _SavedCandidateState();
}

class _SavedCandidateState extends State<SavedCandidate> {
  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for the user's email
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFF3F6F8),
      body: SafeArea(
        child: Container(
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.only(left: 24,right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 20,
                        color: Color(0xFF000000),
                      ),
                      SizedBox(width:16,),
                      Text(
                        "Saved Candidates",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Gelion',
                          fontSize: 16,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                      onTap: (){},
                      child: Image.asset("assets/icons/notification_baseline.png",height: 24,width:24,fit: BoxFit.contain,)
                  )
                ],
              ),
              SizedBox(height:10,),
           Expanded(
             child: SingleChildScrollView(
               physics: BouncingScrollPhysics(),
               child: Container(
                 child: Column(
                   children: [
                     SizedBox(height:22),
                     _buildSearch(),
                     SizedBox(height: 20,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(
                           "Popular Categories",
                           textAlign: TextAlign.start,
                           style: TextStyle(
                             fontWeight: FontWeight.w400,
                             fontFamily: 'Gelion',
                             fontSize: 14,
                             color: Color(0xFF6F8A9C),
                           ),
                         ),
                         TextButton(
                           onPressed: (){},
                           child: Text(
                             "see all",
                             textAlign: TextAlign.start,
                             style: TextStyle(
                               fontWeight: FontWeight.w400,
                               fontFamily: 'Gelion',
                               fontSize: 14,
                               color: Color(0xFF00A69D),
                             ),
                           ),
                         )
                       ],
                     ),
                     SizedBox(
                       height: 50,
                       child: ListView.builder(
                           shrinkWrap: true,
                           scrollDirection: Axis.horizontal,
                           itemCount: 1,
                           physics: BouncingScrollPhysics(),
                           itemBuilder: (_,__)=>  Row(
                             children: [
                               Container(
                                 color: Color(0xFFFFFFFF),
                                 padding: EdgeInsets.only(left: 10,right: 10,top: 11,bottom: 11,),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Image.asset("assets/icons/baby-boy 1.png",width: 24,height: 24,fit: BoxFit.contain,),
                                     SizedBox(width: 6,),
                                     Text(
                                       "Caregiver",
                                       textAlign: TextAlign.start,
                                       style: TextStyle(
                                         fontWeight: FontWeight.w400,
                                         fontFamily: 'Gelion',
                                         fontSize: 14,
                                         color: Color(0xFF042538),
                                       ),
                                     )
                                   ],
                                 ),
                               ),
                               SizedBox(width: 10,),
                               Container(
                                 color: Color(0xFFFFFFFF),
                                 padding: EdgeInsets.only(left: 10,right: 10,top: 11,bottom: 11,),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Image.asset("assets/icons/hammer 1.png",width: 20,height:20 ,fit: BoxFit.contain,),
                                     SizedBox(width: 6,),
                                     Text(
                                       "Capenter",
                                       textAlign: TextAlign.start,
                                       style: TextStyle(
                                         fontWeight: FontWeight.w400,
                                         fontFamily: 'Gelion',
                                         fontSize: 14,
                                         color: Color(0xFF042538),
                                       ),
                                     )
                                   ],
                                 ),
                               ),
                               SizedBox(width: 10,),
                               Container(
                                 color: Color(0xFFFFFFFF),
                                 padding: EdgeInsets.only(left: 10,right: 10,top: 11,bottom: 11,),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Image.asset("assets/icons/chef-hat 1.png",width:20 ,height: 20,fit: BoxFit.contain,),
                                     SizedBox(width: 6,),
                                     Text(
                                       "Chef",
                                       textAlign: TextAlign.start,
                                       style: TextStyle(
                                         fontWeight: FontWeight.w400,
                                         fontFamily: 'Gelion',
                                         fontSize: 14,
                                         color: Color(0xFF042538),
                                       ),
                                     )
                                   ],
                                 ),
                               ),
                               SizedBox(width: 10,),
                               Container(
                                 color: Color(0xFFFFFFFF),
                                 padding: EdgeInsets.only(left: 10,right: 10,top: 11,bottom: 11,),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Image.asset("assets/icons/broom.png",width: 16,height: 22,fit: BoxFit.contain,),
                                     SizedBox(width: 6,),
                                     Text(
                                       "House Keeper",
                                       textAlign: TextAlign.start,
                                       style: TextStyle(
                                         fontWeight: FontWeight.w400,
                                         fontFamily: 'Gelion',
                                         fontSize: 14,
                                         color: Color(0xFF042538),
                                       ),
                                     )
                                   ],
                                 ),
                               ),
                               SizedBox(width: 10,),
                               Container(
                                 color: Color(0xFFFFFFFF),
                                 padding: EdgeInsets.only(left: 10,right: 10,top: 11,bottom: 11,),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Image.asset("assets/icons/taxi-driver 1.png",width: 20,height:20 ,fit: BoxFit.contain,),
                                     SizedBox(width: 6,),
                                     Text(
                                       "Chauffeur",
                                       textAlign: TextAlign.start,
                                       style: TextStyle(
                                         fontWeight: FontWeight.w400,
                                         fontFamily: 'Gelion',
                                         fontSize: 14,
                                         color: Color(0xFF042538),
                                       ),
                                     )
                                   ],
                                 ),
                               ),
                               SizedBox(width: 10,),
                               Container(
                                 color: Color(0xFFFFFFFF),
                                 padding: EdgeInsets.only(left: 10,right: 10,top: 11,bottom: 11,),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Image.asset("assets/icons/waiter.png",width: 20,height:20 ,fit: BoxFit.contain,),
                                     SizedBox(width: 6,),
                                     Text(
                                       "Butler",
                                       textAlign: TextAlign.start,
                                       style: TextStyle(
                                         fontWeight: FontWeight.w400,
                                         fontFamily: 'Gelion',
                                         fontSize: 14,
                                         color: Color(0xFF042538),
                                       ),
                                     )
                                   ],
                                 ),
                               ),
                             ],
                           )
                       ),
                     ),
                     SizedBox(height: 20,),
                     Text(
                       "Recommended Candidates",
                       textAlign: TextAlign.start,
                       style: TextStyle(
                         fontWeight: FontWeight.w400,
                         fontFamily: 'Gelion',
                         fontSize: 14,
                         color: Color(0xFF6F8A9C),
                       ),
                     ),
                     SizedBox(height: 18,),
                     Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             _buildRecommendedContainer("assets/icons/caterer.png","Chef", "Funke", 3.5),
                             _buildRecommendedContainer("assets/icons/dog_walker.png","Dog Walker", "Michelle", 3.5),
                           ],
                         ),
                         SizedBox(height: 18,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             _buildRecommendedContainer("assets/icons/home_tutor.png","Home Tutor", "Taiwo", 3.5),
                             _buildRecommendedContainer("assets/icons/carpenter_cat.png","Carpenter", "Dauda", 3.5),
                           ],
                         ),
                       ],
                     ),
                     SizedBox(height: 5,),
                     Center(
                       child: TextButton(
                           onPressed:(){},
                           child: Text(
                             "see all candidates",
                             textAlign: TextAlign.start,
                             style: TextStyle(
                               fontWeight: FontWeight.w400,
                               fontFamily: 'Gelion',
                               fontSize: 14,
                               color: Color(0xFF00A69D),
                             ),
                           )
                       ),
                     ),
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
  Widget _buildRecommendedContainer(String imagePath,String category,String candidateName, double ratings ){
    return Container(
      width: 160,
      height: 159,
      decoration: BoxDecoration(
        //color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Stack(
        children: [
          Image.asset(imagePath , fit:BoxFit.contain,width: 160,height: 130,),
          Positioned(
            bottom: 0,
            child: Container(
              width: 160,
              padding: EdgeInsets.only(left: 10,right: 10,top: 6,bottom: 11),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gelion',
                          fontSize: 13,
                          color: Color(0xFF042538),
                        ),
                      ),
                      Text(
                        candidateName,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gelion',
                          fontSize: 12,
                          color: Color(0xFF717F88),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "$ratings",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gelion',
                      fontSize: 12,
                      color: Color(0xFF717F88),
                    ),
                  ),
                ],
              ) ,
            ),
          )
        ],
      ),
    );
  }
}
