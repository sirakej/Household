import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/category.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';

import 'constant.dart';

class CandidateContainer extends StatefulWidget {

  final Category category;
  final Candidate candidate;
  final Function onPressed;
  final bool selected;
  final bool showStars;
  final String date;

  const CandidateContainer({
    Key key,
    this.category,
    @required this.candidate,
    @required this.onPressed,
    @required this.selected,
    @required this.showStars,
    this.date,
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
                  height: 57,
                  width: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Image.network(
                    widget.candidate.profileImage,
                    height: 57,
                    width: 72,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace){
                      return Container();
                    },
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
                      "${widget.candidate.experience} ${widget.candidate.experience > 1 ? 'Years' : 'Year'} Experience",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gelion',
                        fontSize: 12,
                        color: Color(0xFF717F88),
                      ),
                    ),
                    Text(
                      "${widget.candidate.availability.title} . ${widget.candidate.origin}",
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
              ],
            ),
            widget.showStars
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2.0, right: 4),
                  child: Text(
                    "${widget.candidate.rating}",
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
                : widget.date != null
                  ? Text(
              widget.date,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'Gelion',
                fontSize: 14,
                color: Color(0xFF717F88),
              ),
            )
                  : Container()
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
                  height: 57,
                  width: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Image.network(
                    widget.candidate.profileImage,
                    height: 57,
                    width: 72,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace){
                      return Container();
                    },
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
                      "${widget.candidate.experience} ${widget.candidate.experience > 1 ? 'Years' : 'Year'} Experience",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gelion',
                        fontSize: 12,
                        color: Color(0xFFF7941D),
                      ),
                    ),
                    Text(
                      "${widget.candidate.availability.title} . ${widget.candidate.origin}",
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
              ],
            ),
            widget.showStars
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2.0, right: 4),
                  child: Text(
                    "${widget.candidate.rating}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
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
                : widget.date != null
                  ? Text(
              widget.date,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'Gelion',
                fontSize: 14,
                color: Color(0xFF717F88),
              ),
            )
                  : Container()
          ],
        ),
      ),
    );
  }

}

class Button extends StatelessWidget {

  final void Function() onTap;

  final Color buttonColor;

  final Color foregroundColor;

  final Widget child;

  final double width;

  final double padding;

  final double radius;

  const Button({
    Key key,
    @required this.onTap,
    @required this.buttonColor,
    this.foregroundColor,
    @required this.child,
    this.width,
    this.padding,
    this.radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: buttonColor, // background
          onPrimary: foregroundColor ?? Color(0xFFFFFFFF), // foreground
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
          )
      ),
      onPressed: onTap,
      child: Container(
        width: width ?? SizeConfig.screenWidth,
        padding: EdgeInsets.only(top: padding ?? 18, bottom: padding ?? 18),
        child: child,
      ),
    );
  }

}

class DrawerHeaderName extends StatelessWidget {

  final String firstName;

  final String surName;

  const DrawerHeaderName({
    Key key,
    @required this.firstName,
    @required this.surName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFFFFFF),
              border: Border.all(
                  color: Color(0xFF5D6970),
                  width: 1.5
              )
          ),
          child: (surName != null && firstName != null)
              ? Center(
            child: Text(
              Constants.profileName('$surName $firstName'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Gelion',
                fontSize: 24,
                color: Color(0xFF000000),
              ),
            ),
          )
              : Container(),
        ),
        /*Center(
                          child: Image.asset(
                            "assets/icons/profile.png",
                            width: 64,
                            height: 64,
                            fit: BoxFit.contain
                          )
                        ),*/
        SizedBox(width: 13),
        Text(
          "${firstName ?? ''} ${surName ?? ''}",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: 'Gelion',
            fontSize: 16,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ],
    );
  }

}

class DrawerContainer extends StatelessWidget {

  final Function onTap;

  final String title;

  final String imageName;

  const DrawerContainer({
    Key key,
    @required this.onTap,
    @required this.title,
    @required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(top: 16, bottom: 16),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFEBF1F4), width: 1))
        ),
        child: Row(
          children: [
            Image.asset(
                "assets/icons/$imageName.png",
                width: 16,
                height: 16,
                fit: BoxFit.contain
            ),
            SizedBox(width: 10),
            Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'Gelion',
                fontSize: 14,
                color: Color(0xFF3B4A54),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class StarDisplay extends StatelessWidget {

  final int value;

  const StarDisplay({
    Key key,
    @required this.value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
          color: Color(0xFFF7941D),
        );
      }),
    );
  }
}