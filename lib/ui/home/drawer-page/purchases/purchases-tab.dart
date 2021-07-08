import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:householdexecutives_mobile/model/candidate.dart';
import 'package:householdexecutives_mobile/model/saved-candidates.dart';
import 'package:householdexecutives_mobile/networking/restdata-source.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../home-screen.dart';
import 'add-candidate.dart';

class PurchasesTab extends StatefulWidget {

  final List<SavedCategory> categories;

  const PurchasesTab({
    Key key,
    @required this.categories
  }) : super(key: key);

  @override
  _PurchasesTabState createState() => _PurchasesTabState();
}

class _PurchasesTabState extends State<PurchasesTab> with SingleTickerProviderStateMixin {

  TabController _tabController;

  List<Widget> _categoryTabLabel = [];

  List<Widget> _categoryTabs = [];

  List<String> _header = [];

  void _setTabLabels(){
    if(!mounted)return;
    setState(() {
      for(int i = 0; i < widget.categories.length; i++){
        _categoryTabLabel.add(
          Tab(text: widget.categories[i].getCategory.name),
        );
      }
    });
  }

  void _setTabs(){
    if(!mounted)return;
    setState(() {
      for(int i = 0; i < widget.categories.length; i++){
        List<Widget> candidateContainers = [];
        for(int j = 0; j < widget.categories[i].candidatePlan.length; j++){
          candidateContainers.add(
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: CandidateContainer(
                candidate: widget.categories[i].candidatePlan[j].getCandidate,
                onPressed: (){
                  _buildProfileModalSheet(context, widget.categories[i].id,
                      widget.categories[i].candidatePlan[j].getCandidate,
                      widget.categories[i].candidatePlan[j].hired
                          ? false
                          : (widget.categories[i].hires != widget.categories[i].roles)
                  );
                },
                selected: false,
                showStars: false,
              ),
            ),
          );
        }
        if(!widget.categories[i].interview){
          candidateContainers.add(
            Container(
              padding: EdgeInsets.only(top: 45),
              child: Button(
                onTap: (){
                  _showRescheduleDateTime(widget.categories[i].id);
                },
                buttonColor: Color(0xFF00A69D),
                child: Center(
                  child: _showScheduleSpinner
                      ? CupertinoActivityIndicator(radius: 13)
                      : Text(
                    "Schedule",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gelion',
                      fontSize: 16,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            )
          );
        }
        if(widget.categories[i].candidatePlan.length < (widget.categories[i].roles * 3)){
          candidateContainers.add(
              Container(
                padding: EdgeInsets.only(top: 14),
                child: TextButton(
                  onPressed: (){
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (_){
                          return AddCandidate(
                            category: widget.categories[i].getCategory,
                            candidates: widget.categories[i].candidatePlan,
                            categoryId: widget.categories[i].id
                          );
                        })
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF6F8A9C)
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Color(0xFFFFFFFF),
                            size: 12,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Add",
                        style: TextStyle(
                          color: Color(0xFF6F8A9C),
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          fontWeight:FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              )
          );
        }
        _categoryTabs.add(
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: candidateContainers
            )
          )
        );
        _header.add(widget.categories[i].interview ? 'Hire Candidate' : 'Schedule Candidate');
      }
    });
  }

  DateTime _scheduleAt;

  /// Converting [dateTime] in string format to return a formatted time
  /// of hrs, minutes and am/pm
  String _getFormattedDate(DateTime dateTime) {
    return DateFormat('E, d MMM, y h:mm a').format(dateTime).toString();
  }

  bool _showScheduleSpinner = false;

  bool _showSpinner = false;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: widget.categories.length, vsync: this);
    _setTabLabels();
    _setTabs();
    _tabController.addListener(() {
      if(_tabController.indexIsChanging){
        setState(() { });
      }
    });
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
          _header[_tabController.index],
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: 'Gelion',
            fontSize: 19,
            color: Color(0xFF000000),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24, 14, 24, 0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'You’re only allowed to select a maximum of 3\ncandidates per category',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    fontSize: 12.6829,
                    color: Color(0xFF57565C),
                  ),
                ),
              ),
              SizedBox(height: 43.39),
              TabBar(
                  physics: BouncingScrollPhysics(),
                  controller: _tabController,
                  indicatorColor: Color(0xFF00A69D),
                  isScrollable: false,
                  labelColor: Color(0xFF00A69D),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    fontSize: 14,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    fontSize: 14,
                  ),
                  unselectedLabelColor: Color(0xFF3B4A54),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3,
                  tabs: _categoryTabLabel
              ),
              Container(
                width: SizeConfig.screenWidth,
                height: 1,
                color: Color(0xFFC5C9CC),
              ),
              SizedBox(height: 27),
              Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  controller: _tabController,
                  children: _categoryTabs,
                ),
              ),
              SizedBox(height: 60),
            ]
        ),
      ),
    );
  }

  _buildProfileModalSheet(BuildContext context, String categoryId, Candidate candidate, bool hire){
    List<Widget> history = [];
    for(int i = 0; i < candidate.history.length; i++){
      history.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.check,
              size:12,
              color: Color(0xFF717F88),
            ),
            SizedBox(width:8),
            Container(
              width: SizeConfig.screenWidth - 120,
              child: Text(
                candidate.history[i].toString(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Gelion',
                  fontSize: 14,
                  color: Color(0xFF717F88),
                ),
              ),
            ),
          ],
        ),
      );
    }
    showModalBottomSheet<void>(
        backgroundColor: Color(0xFFFFFFFF),
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: false,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
            return Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
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
                    'Candidates Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Gelion',
                      fontSize: 19,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                body: Container(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 74,
                            height: 74,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Color(0xFF717F88), width: 0.5)
                            ),
                            child: CachedNetworkImage(
                              imageUrl: candidate.profileImage,
                              width: 74,
                              height: 74,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Container(),
                            ),
                          ),
                        ),
                        SizedBox(height: 7),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "${candidate.firstName}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gelion',
                              fontSize: 16,
                              color: Color(0xFF042538),
                            ),
                          ),
                        ),
                        SizedBox(height: 37),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ID Number:",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'HE${candidate.id.substring(0, 6).toUpperCase()}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF717F88),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 18),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Origin",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "${candidate.origin ?? ''}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF717F88),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 18),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Availability:",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      candidate.availability.title ?? '',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF717F88),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Age:",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height:8),
                                    Text(
                                      "${candidate.age ?? ''}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF717F88),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 18),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Residence:",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height:8),
                                    Container(
                                      width: 120,
                                      child: Text(
                                        candidate.residence ?? '',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF717F88),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 18),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Rating:",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          '${candidate.rating ?? ''}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Gelion',
                                            fontSize: 14,
                                            color: Color(0xFF717F88),
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
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Gender:",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height:8),
                                    Text(
                                      candidate.gender ?? '',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF717F88),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 18),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Experience:",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height:8),
                                    Text(
                                      "${candidate.experience} ${candidate.experience > 1 ? 'Years' : 'Year'} +",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF717F88),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 18),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tribe",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF042538),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      candidate.tribe ?? '',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF717F88),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Unique Skill(s):",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 14,
                                    color: Color(0xFF042538),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  width: SizeConfig.screenWidth - 120,
                                  child: Text(
                                    // "Fluent in 5 languages - English, Yoruba, Hausa, Igbo and Igala.",
                                    "${candidate.skill}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Gelion',
                                      fontSize: 14,
                                      color: Color(0xFF717F88),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 18),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Work History:",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 14,
                                    color: Color(0xFF042538),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: history,
                                ),
                              ],
                            ),
                            SizedBox(height: 18),
                            Container(
                              width:100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Verifications:",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Gelion',
                                      fontSize: 14,
                                      color: Color(0xFF042538),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Identity",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Gelion',
                                              fontSize: 14,
                                              color: Color(0xFF717F88),
                                            ),
                                          ),
                                          Icon(
                                            Icons.check,
                                            size:12,
                                            color: Colors.redAccent,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Residence",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Gelion',
                                              fontSize: 14,
                                              color: Color(0xFF717F88),
                                            ),
                                          ),
                                          Icon(
                                            Icons.check,
                                            size:12,
                                            color: Colors.redAccent,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                        children: [
                                          Text(
                                            "Guarantors",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Gelion',
                                              fontSize: 14,
                                              color: Color(0xFF717F88),
                                            ),
                                          ),
                                          Icon(
                                            Icons.check,
                                            size:12,
                                            color: Colors.redAccent,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                        children: [
                                          Text(
                                            "Health Status",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Gelion',
                                              fontSize: 14,
                                              color: Color(0xFF717F88),
                                            ),
                                          ),
                                          Icon(
                                            Icons.check,
                                            size:12,
                                            color: Colors.redAccent,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            candidate.officialHeReport.isNotEmpty
                                ? TextButton(
                              onPressed: () {
                                _openUrl(candidate.officialHeReport);
                              },
                              child:  Text(
                                "view official HE Report",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            )
                                : Container(),
                          ],
                        ),
                        SizedBox(height: 30),
                        hire
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Button(
                          onTap: (){
                            _buildHireStartSheet(context, candidate, categoryId);
                          },
                          buttonColor: Color(0xFF00A69D),
                          child: Center(
                                child: Text(
                                  'Hire',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 16,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                          ),
                        ),
                                SizedBox(height: 10),
                                TextButton(
                                  onPressed: (){
                                    _buildRemoveSheet(context, candidate, categoryId);
                                  },
                                  child: Text(
                                    'Remove',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Gelion',
                                      fontSize: 16,
                                      color: Color(0xFFE93E3A),
                                    ),
                                  ),
                                ),
                              ],
                            )
                            : Container(),
                        SizedBox(height: 38),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        }
    );
  }

  /// Function to call a number using the [url_launcher] package
  _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch the url';
    }
  }

  /// Function to show the bottom date time picker fo selecting frequency time
  void _showRescheduleDateTime(String categoryId){
    if(!mounted) return;
    setState(() { _showSpinner = true; });
    DateTime now = DateTime.now();
    DatePicker.showDateTimePicker(
        context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(now.year + 1, now.month, now.day),
        onConfirm: (date) {
          if(!mounted)return;
          setState(() {
            _scheduleAt = date;
          });
        },
        onCancel: (){
          if(!mounted)return;
          setState(() {
            _scheduleAt = null;
          });
        },
        currentTime: DateTime.now(),
        locale: LocaleType.en
    ).then((value) {
      if(_scheduleAt != null){
        _scheduleInterview(categoryId);
      }
    });
  }

  void _scheduleInterview(String categoryId){
    if(!mounted) return;
    setState(() { _showScheduleSpinner = true; });
    var api = RestDataSource();
    api.scheduleCandidate(categoryId, _scheduleAt).then((dynamic) async{
      if(!mounted) return;
      setState(() {
        _scheduleAt = null;
        _showScheduleSpinner = false;
      });
      _buildCandidateScheduledSheet(context);
    }).catchError((e){
      print(e);
      if(!mounted)return;
      setState(() {
        _showScheduleSpinner = false;
        _scheduleAt = null;
      });
      Constants.showError(context, e);
    });
  }

  _buildCandidateScheduledSheet(BuildContext context){
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: false,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(24, 33.75, 24, 38),
                margin: EdgeInsets.only(top: 34),
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Image.asset(
                        "assets/icons/circle check full.png",
                        height: 60.5,
                        width: 60.5,
                        fit: BoxFit.contain
                    ),
                    SizedBox(height: 24.75),
                    Text(
                      "Interview Scheduled",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 16,
                        color: Color(0xFF042538),
                      ),
                    ),
                    SizedBox(height: 13),
                    Container(
                      width: SizeConfig.screenWidth - 150,
                      child: Text(
                        "Your candidate(s) will be notified of the interview date. We will contact you for more details.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          color: Color(0xFF57565C),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    Button(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      buttonColor: Color(0xFF00A69D),
                      child: Center(
                        child: Text(
                          "Home",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 16,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child:Text(
                        "Schedule For Others",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Gelion',
                          fontSize: 16,
                          color: Color(0xFF00A69D),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        }
    );
  }


  _buildCandidateHiredSheet(BuildContext context){
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: false,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(24, 33.75, 24, 38),
                margin: EdgeInsets.only(top: 34),
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Image.asset(
                        "assets/icons/circle check full.png",
                        height: 60.5,
                        width: 60.5,
                        fit: BoxFit.contain
                    ),
                    SizedBox(height: 24.75),
                    Text(
                      "Candidate Hired",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 16,
                        color: Color(0xFF042538),
                      ),
                    ),
                    SizedBox(height: 13),
                    Container(
                      width: SizeConfig.screenWidth - 150,
                      child: Text(
                        "Your candidate(s) will be notified of the interview date. We will contact you for more details.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          color: Color(0xFF57565C),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    Button(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      buttonColor: Color(0xFF00A69D),
                      child: Center(
                        child: Text(
                          "Home",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 16,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child:Text(
                        "Choose Resumption Date",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Gelion',
                          fontSize: 16,
                          color: Color(0xFF00A69D),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        }
    );
  }

  TextEditingController _scheduleController = TextEditingController();

  DateTime _resumeAt;

  _buildHireStartSheet(BuildContext context, Candidate candidate, String categoryId){
    _scheduleController.clear();
    final formKey = GlobalKey<FormState>();
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: true,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(24, 45, 24, 38),
                margin: EdgeInsets.only(top: 34),
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft:Radius.circular(30),
                      topRight:Radius.circular(30)
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children:[
                    Text(
                      "Resumption Date",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 16,
                        color: Color(0xFF042538),
                      ),
                    ),
                    SizedBox(height: 13),
                    Container(
                      width: SizeConfig.screenWidth - 150,
                      child: Text(
                        "Your candidate(s) will be informed of the resumption date. We will contact you to firm up final arrangements.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          color: Color(0xFF57565C),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Availability',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Gelion',
                            fontSize: 16,
                            color: Color(0xFF042538),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: candidate.availability.sunday['availability']
                                  ? candidate.availability.sunday['booked']
                                  ? Container(
                                  height:33,
                                  width: 33,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF00A69D).withOpacity(0.1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Sun",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF00A69D),
                                      ),
                                    ),
                                  )
                              )
                                  : Text(
                                "Sun",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFF000000),
                                ),
                              )
                                  : Text(
                                "Sun",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFFC4CDD5),
                                ),
                              ),
                            ),
                            Expanded(
                              child: candidate.availability.monday['availability']
                                  ? candidate.availability.monday['booked']
                                  ? Container(
                                  height:33,
                                  width: 33,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF00A69D).withOpacity(0.1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Mon",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF00A69D),
                                      ),
                                    ),
                                  )
                              )
                                  : Text(
                                "Mon",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFF000000),
                                ),
                              )
                                  : Text(
                                "Mon",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFFC4CDD5),
                                ),
                              ),
                            ),
                            Expanded(
                              child: candidate.availability.tuesday['availability']
                                  ? candidate.availability.tuesday['booked']
                                  ? Container(
                                  height:33,
                                  width: 33,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF00A69D).withOpacity(0.1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Tue",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF00A69D),
                                      ),
                                    ),
                                  )
                              )
                                  : Text(
                                "Tue",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFF000000),
                                ),
                              )
                                  : Text(
                                "Tue",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFFC4CDD5),
                                ),
                              ),
                            ),
                            Expanded(
                              child: candidate.availability.wednesday['availability']
                                  ? candidate.availability.wednesday['booked']
                                  ? Container(
                                  height:33,
                                  width: 33,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF00A69D).withOpacity(0.1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Wed",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF00A69D),
                                      ),
                                    ),
                                  )
                              )
                                  : Text(
                                "Wed",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFF000000),
                                ),
                              )
                                  : Text(
                                "Wed",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFFC4CDD5),
                                ),
                              ),
                            ),
                            Expanded(
                              child: candidate.availability.thursday['availability']
                                  ? candidate.availability.thursday['booked']
                                  ? Container(
                                  height:33,
                                  width: 33,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF00A69D).withOpacity(0.1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Thu",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF00A69D),
                                      ),
                                    ),
                                  )
                              )
                                  : Text(
                                "Thu",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFF000000),
                                ),
                              )
                                  : Text(
                                "Thu",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFFC4CDD5),
                                ),
                              ),
                            ),
                            Expanded(
                              child: candidate.availability.friday['availability']
                                  ? candidate.availability.friday['booked']
                                  ? Container(
                                  height:33,
                                  width: 33,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF00A69D).withOpacity(0.1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Fri",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF00A69D),
                                      ),
                                    ),
                                  )
                              )
                                  : Text(
                                "Fri",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFF000000),
                                ),
                              )
                                  : Text(
                                "Fri",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFFC4CDD5),
                                ),
                              ),
                            ),
                            Expanded(
                              child: candidate.availability.saturday['availability']
                                  ? candidate.availability.saturday['booked']
                                  ? Container(
                                  height:33,
                                  width: 33,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF00A69D).withOpacity(0.1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Sat",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF00A69D),
                                      ),
                                    ),
                                  )
                              )
                                  : Text(
                                "Sat",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFF000000),
                                ),
                              )
                                  : Text(
                                "Sat",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 14,
                                  color: Color(0xFFC4CDD5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]
                    ),
                    SizedBox(height: 30),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Date',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Gelion',
                              fontSize: 16,
                              color: Color(0xFF042538),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: SizeConfig.screenWidth,
                            child: TextFormField(
                              controller: _scheduleController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please select';
                                }
                                return null;
                              },
                              readOnly: true,
                              onTap: (){
                                _showDateTime(setModalState);
                              },
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                color: Color(0xFF042538),
                              ),
                              decoration: kFieldDecoration.copyWith(
                                hintText: 'Please Select',
                                hintStyle: TextStyle(
                                  color: Color(0xFF717F88),
                                  fontSize: 14,
                                  fontFamily: 'Gelion',
                                  fontWeight: FontWeight.normal,
                                ),
                                suffixIcon: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 16,
                                          maxHeight: 16,
                                        ),
                                        width: 16,
                                        height: 16,
                                        child: Icon(
                                          Icons.calendar_today_outlined,
                                          color: Color(0xFF000000),
                                          size: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                      ),
                    ),
                    SizedBox(height: 40),
                    Button(
                      onTap: (){
                        if(formKey.currentState.validate()){
                          _hireCandidate(categoryId, candidate, setModalState);
                        }
                      },
                      buttonColor: Color(0xFF00A69D),
                      child: Center(
                        child: _showSpinner
                            ? CupertinoActivityIndicator(radius: 13)
                            : Text(
                          "Continue",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 16,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                  ],
                ),
              ),
            );
          });
        }
    );
  }

  /// Function to show the bottom date time picker fo selecting frequency time
  void _showDateTime(StateSetter setModalState){
    DateTime now = DateTime.now();
    DatePicker.showDateTimePicker(
        context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(now.year + 1, now.month, now.day),
        onChanged: (date) {
          if(!mounted)return;
          setModalState(() {
            _scheduleController.text = _getFormattedDate(date);
            _resumeAt = date;
          });
        },
        onConfirm: (date) {
          if(!mounted)return;
          setModalState(() {
            _scheduleController.text = _getFormattedDate(date);
            _resumeAt = date;
          });
        },
        currentTime: DateTime.now(),
        locale: LocaleType.en
    );
  }

  void _hireCandidate(String categoryId, Candidate candidate, StateSetter setModalState){
    if(!mounted) return;
    setModalState(() { _showSpinner = true; });
    var api = RestDataSource();
    api.hireCandidate(categoryId, candidate, _resumeAt).then((dynamic) async{
      if(!mounted) return;
      setModalState(() {
        _resumeAt = null;
        _showSpinner = false;
      });
      Navigator.pop(context);
      _buildCompletedHireSheet(context);
    }).catchError((e){
      print(e);
      if(!mounted)return;
      setModalState(() {
        _showSpinner = false;
        _scheduleAt = null;
      });
      Constants.showError(context, e);
    });
  }

  _buildCompletedHireSheet(BuildContext context){
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: false,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(24, 30, 24, 38),
                margin: EdgeInsets.only(top: 34),
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children:[
                    Image.asset(
                        "assets/icons/circle check full.png",
                        height: 60.5,
                        width: 60.5,
                        fit: BoxFit.contain
                    ),
                    SizedBox(height: 24.75),
                    Text(
                      "Success",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gelion',
                        fontSize: 16,
                        color: Color(0xFF042538),
                      ),
                    ),
                    SizedBox(height: 13),
                    Text(
                      "You have completed your hire!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFF57565C),
                      ),
                    ),
                    SizedBox(height: 30),
                    Button(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      buttonColor: Color(0xFF00A69D),
                      child: Center(
                        child: Text(
                          "Home",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gelion',
                            fontSize: 16,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child:Text(
                        "Schedule For Others",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gelion',
                          fontSize: 16,
                          color: Color(0xFF00A69D),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        }
    );
  }

  _buildRemoveSheet(BuildContext context, Candidate candidate, String categoryId){
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Color(0xFF07072B).withOpacity(0.81),
        isDismissible: true,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder:(BuildContext context, StateSetter setModalState){
            return Container(
              padding: EdgeInsets.fromLTRB(24, 45, 24, 38),
              margin: EdgeInsets.only(top: 34),
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(30),
                    topRight:Radius.circular(30)
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children:[
                  Text(
                    "Remove Candidate",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Gelion',
                      fontSize: 16,
                      color: Color(0xFF042538),
                    ),
                  ),
                  SizedBox(height: 13),
                  Container(
                    width: SizeConfig.screenWidth - 150,
                    child: Text(
                      "This candidate will be removed and you also have an option to add another candidate.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gelion',
                        fontSize: 14,
                        color: Color(0xFF57565C),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Button(
                    onTap: (){
                      _removeCandidate(categoryId, candidate, setModalState);
                    },
                    buttonColor: Color(0xFFE93E3A),
                    child: Center(
                      child: _showSpinner
                          ? CupertinoActivityIndicator(radius: 13)
                          : Text(
                        "Remove",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gelion',
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            );
          });
        }
    );
  }

  void _removeCandidate(String categoryId, Candidate candidate, StateSetter setModalState){
    if(!mounted) return;
    setModalState(() { _showSpinner = true; });
    var api = RestDataSource();
    api.deleteCandidate(categoryId, candidate.id).then((dynamic) async{
      if(!mounted) return;
      setModalState(() { _showSpinner = false; });
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    }).catchError((e){
      print(e);
      if(!mounted)return;
      setModalState(() { _showSpinner = false; });
      Constants.showError(context, e);
    });
  }

}
