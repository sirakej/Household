import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/utils/size_config.dart';

class CandidateContainer extends StatefulWidget {

  final Category category;
  final Candidate candidate;
  final Function onPressed;
  final bool selected;

  const CandidateContainer({
    Key key,
    @required this.category,
    @required this.candidate,
    @required this.onPressed,
    @required this.selected,
  }) : super(key: key);

  @override
  _CandidateContainerState createState() => _CandidateContainerState();
}

class _CandidateContainerState extends State<CandidateContainer> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return widget.selected
        ? InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.fromLTRB(8, 17, 12, 22),
        margin: EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: Color(0xFFF9F9F9),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Image.asset(
                      "assets/icons/butler.png",
                      height: 57,
                      width: 72,
                      fit: BoxFit.contain
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.candidate.firstName} (${widget.candidate.gender})",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gelion',
                        fontSize: 16,
                        color: Color(0xFF042538),
                      ),
                    ),
                    Text(
                      "${widget.candidate.experience} Years Experience",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        //letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gelion',
                        fontSize: 12,
                        color: Color(0xFF717F88),
                      ),
                    ),
//                    Text(
//                      "${widget.candidate.availablity} . ${widget.candidate.resedential}",
//                      textAlign: TextAlign.start,
//                      style: TextStyle(
//                        //letterSpacing: 1,
//                        fontWeight: FontWeight.w400,
//                        fontFamily: 'Gelion',
//                        fontSize: 12,
//                        color: Color(0xFF717F88),
//                      ),
//                    ),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    "3.5",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      //letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gelion',
                      fontSize: 11,
                      color: Color(0xFF717F88),
                    ),
                  ),
                ),
                Image.asset(
                    'assets/icons/star.png',
                    width: 18,
                    height: 15,
                    color: Color(0xFFF7941D),
                    fit: BoxFit.contain
                )
              ],
            )
          ],
        ),
      ),
    )
        : InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.fromLTRB(8, 17, 12, 22),
        margin: EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color:Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(6)),
          border:Border.all(width: 1, color: Color(0xFFEBF1F4)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Image.asset(
                    "assets/icons/butler.png",
                    height: 57,
                    width: 72,
                    fit: BoxFit.contain
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.candidate.firstName} (${widget.candidate.gender})",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        //letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gelion',
                        fontSize: 16,
                        color: Color(0xFF042538),
                      ),
                    ),
                    Text(
                      "${widget.candidate.experience} Years Experience",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        //letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gelion',
                        fontSize: 12,
                        color: Color(0xFFF7941D),
                      ),
                    ),
//                    Text(
//                      "${widget.candidate.availablity} . ${widget.candidate.resedential}",
//                      textAlign: TextAlign.start,
//                      style: TextStyle(
//                        //letterSpacing: 1,
//                        fontWeight: FontWeight.w400,
//                        fontFamily: 'Gelion',
//                        fontSize: 12,
//                        color: Color(0xFF717F88),
//                      ),
//                    ),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    "3.5",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      //letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gelion',
                      fontSize: 11,
                      color: Color(0xFF717F88),
                    ),
                  ),
                ),
                Image.asset(
                    'assets/icons/star.png',
                    width: 18,
                    height: 15,
                    color: Color(0xFFF7941D),
                    fit: BoxFit.contain
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}
