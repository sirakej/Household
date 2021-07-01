import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:householdexecutives_mobile/networking/auth-rest-data.dart';
import 'package:householdexecutives_mobile/model/create-candidate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class RegisterCandidateTwo extends StatefulWidget {

  static const String id = 'register_candidate_two';

  final CreateCandidate candidate;

  const RegisterCandidateTwo({
    Key key,
    @required this.candidate
  }) : super(key: key);

  @override
  _RegisterCandidateTwoState createState() => _RegisterCandidateTwoState();
}

class _RegisterCandidateTwoState extends State<RegisterCandidateTwo> {

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for the unique skills
  TextEditingController _skillsController = TextEditingController();

  /// A [TextEditingController] to control the input text for the languages
  TextEditingController _languagesController = TextEditingController();

  bool _liveIn = false;
  bool _custom = true;

  bool _monday = true;
  bool _tuesday = false;
  bool _wednesday = false;
  bool _thursday = true;
  bool _friday = false;
  bool _saturday = true;
  bool _sunday = false;

  Map<dynamic, String> _verifications = {
    1: 'Profile Image',
    2: 'Identity Verification',
    3: 'Residence Verification',
    4: 'Guarantor Verification',
    5: 'Medical Examination',
  };

  List<String> _verificationName = [
    'Profile Image',
    'Identity Verification',
    'Residence Verification',
    'Guarantor Verification',
    'Medical Examination',
  ];

  String _profileImage = 'Profile Image'; // IMG123.JPEG
  String _identityVerification = 'Identity Verification';
  String _residenceVerification = 'Residence Verification';
  String _guarantorVerification = 'Guarantor Verification';
  String _medicalExamination = 'Medical Examination';

  List<http.MultipartFile> _uploads = [];

  final _picker = ImagePicker();

  void _getImage(int id) async {
    File image;
    // _uploads.clear();
    try{
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      if(!mounted)return;
      setState(() {
        image = File(pickedFile.path);
        print(image.path);
        _verifications[id] = "${_verifications[id]}.${image.path.split('.').last}";
      });
      _uploads.add(
        await http.MultipartFile.fromPath("formFile", image.path, filename: _verificationName[id - 1]),
      );
    } catch (err){
      // if(!mounted)return;
      // setState(() { _verifications[id] = _verificationName[id - 1]; });
      // Constants.showErrorFlushBarMessage('You haven\'t selected an image', context);
    }
  }

  void _getFile(int id) async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if(result != null) {
      PlatformFile file = result.files.first;

      if(!mounted)return;
      setState(() {
        _verifications[id] = "${_verifications[id]}.${file.extension}";
      });
      _uploads.add(
        await http.MultipartFile.fromPath("formFile", file.path, filename: _verificationName[id - 1]),
      );
      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
    } else {
      // User canceled the picker
    }
  }

  /// A boolean variable to control showing of the progress indicator
  bool _showSpinner = false;

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
        backgroundColor: Color(0xFFF3F6F8),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.fromLTRB(24, 70, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                        "assets/icons/register_logo.png",
                        height: 48.46,
                        width: 30,
                        fit: BoxFit.contain
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Go Back',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gelion',
                          fontSize: 16,
                          color: Color(0xFF00A69D),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 22.54),
                Text(
                  'Register As a Candidate',
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
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    fontSize: 14,
                    color: Color(0xFF57565C),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 33),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Availability",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Gelion',
                                fontSize: 14,
                                color: Color(0xFF042538),
                              ),
                            ),
                            Row(
                                children: [
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: (){
                                          if(!mounted)return;
                                          setState(() {
                                            _liveIn = true;
                                            _custom = false;
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                            shape: CircleBorder()
                                        ),
                                        child: Container(
                                          width: 16.5,
                                          height: 16.5,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: _liveIn
                                                  ? Border.all(color: Colors.transparent, width: 0)
                                                  : Border.all(color: Color(0xFFC4C4C4), width: 1),
                                              color: _liveIn
                                                  ? Color(0xFF00A69D)
                                                  : Colors.transparent
                                          ),
                                          child: _liveIn
                                              ? Center(
                                            child: Container(
                                              width: 6,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFFFFFFF),
                                                  shape: BoxShape.circle
                                              ),
                                            ),
                                          )
                                              : Container(),
                                        ),
                                      ),
                                      Text(
                                        "Live In",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF042538),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 20),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: (){
                                          if(!mounted)return;
                                          setState(() {
                                            _custom = true;
                                            _liveIn = false;
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                            shape: CircleBorder()
                                        ),
                                        child: Container(
                                          width: 16.5,
                                          height: 16.5,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: _custom
                                                  ? Border.all(color: Colors.transparent, width: 0)
                                                  : Border.all(color: Color(0xFFC4C4C4), width: 1),
                                              color: _custom
                                                  ? Color(0xFF00A69D)
                                                  : Colors.transparent
                                          ),
                                          child: _custom
                                              ? Center(
                                            child: Container(
                                              width: 6,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFFFFFFF),
                                                  shape: BoxShape.circle
                                              ),
                                            ),
                                          )
                                              : Container(),
                                        ),
                                      ),
                                      Text(
                                        "Custom",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Gelion',
                                          fontSize: 14,
                                          color: Color(0xFF042538),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]
                            ),
                            SizedBox(height: 23),
                            AnimatedCrossFade(
                              crossFadeState: _custom
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: const Duration(milliseconds: 500),
                              firstChild: Container(),
                              secondChild: Container(
                                padding: EdgeInsets.only(bottom: 33),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _sunday = !_sunday;
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                            shape: CircleBorder()
                                        ),
                                        child: _sunday
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
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _monday = !_monday;
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                            shape: CircleBorder()
                                        ),
                                        child: _monday
                                            ? Container(
                                            height:33,
                                            width: 33,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF00A69D).withOpacity(0.1),
                                            ),
                                            child:Center(
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
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _tuesday = !_tuesday;
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                            shape: CircleBorder()
                                        ),
                                        child: _tuesday ? Container(
                                            height:33,
                                            width: 33,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF00A69D).withOpacity(0.1),
                                            ),
                                            child:Center(
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
                                        ) : Text(
                                          "Tue",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Gelion',
                                            fontSize: 14,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _wednesday = !_wednesday;
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                            shape: CircleBorder()
                                        ),
                                        child: _wednesday ? Container(
                                            height:33,
                                            width: 33,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF00A69D).withOpacity(0.1),
                                            ),
                                            child:Center(
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
                                        ) : Text(
                                          "Wed",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Gelion',
                                            fontSize: 14,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _thursday = !_thursday;
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                            shape: CircleBorder()
                                        ),
                                        child: _thursday ? Container(
                                            height:33,
                                            width: 33,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF00A69D).withOpacity(0.1),
                                            ),
                                            child:Center(
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
                                        ) : Text(
                                          "Thu",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Gelion',
                                            fontSize: 14,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _friday = !_friday;
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                            shape: CircleBorder()
                                        ),
                                        child: _friday ? Container(
                                            height:33,
                                            width: 33,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF00A69D).withOpacity(0.1),
                                            ),
                                            child:Center(
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
                                        ) : Text(
                                          "Fri",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Gelion',
                                            fontSize: 14,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _saturday = !_saturday;
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                            shape: CircleBorder()
                                        ),
                                        child: _saturday ? Container(
                                            height:33,
                                            width: 33,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF00A69D).withOpacity(0.1),
                                            ),
                                            child:Center(
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
                                        ) : Text(
                                          "Sat",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Gelion',
                                            fontSize: 14,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        _buildForm(),
                        Container(
                          width: SizeConfig.screenWidth,
                          height: 1,
                          color: Color(0xFF6F8A9C),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Upload Documents",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Gelion',
                            fontSize: 14,
                            color: Color(0xFF042538),
                          ),
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Container(
                              width: SizeConfig.screenWidth,
                              padding: EdgeInsets.fromLTRB(16, 4, 2, 3.9),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFC4C4C4), width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                              ),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: SizeConfig.screenWidth - 220,
                                    child: Text(
                                      _verifications[1],
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF717F88),
                                      ),
                                    ),
                                  ),
                                  Button(
                                    onTap: (){
                                      _getImage(1);
                                    },
                                    buttonColor: Color(0xFF00A69D),
                                    width: 103,
                                    padding: 12,
                                    radius: 6.14925,
                                    child: Center(
                                      child: Text(
                                        "Upload",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Gelion',
                                          fontSize: 16,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: SizeConfig.screenWidth,
                              padding: EdgeInsets.fromLTRB(16, 4, 2, 3.9),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFC4C4C4), width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: SizeConfig.screenWidth - 220,
                                    child: Text(
                                      _verifications[2],
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF717F88),
                                      ),
                                    ),
                                  ),
                                  Button(
                                    onTap: (){
                                      _getFile(2);
                                    },
                                    buttonColor: Color(0xFF00A69D),
                                    width: 103,
                                    padding: 12,
                                    radius: 6.14925,
                                    child: Center(
                                      child: Text(
                                        "Upload",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Gelion',
                                          fontSize: 16,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: SizeConfig.screenWidth,
                              padding: EdgeInsets.fromLTRB(16, 4, 2, 3.9),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFC4C4C4), width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: SizeConfig.screenWidth - 220,
                                    child: Text(
                                      _verifications[3],
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF717F88),
                                      ),
                                    ),
                                  ),
                                  Button(
                                    onTap: (){
                                      _getFile(3);
                                    },
                                    buttonColor: Color(0xFF00A69D),
                                    width: 103,
                                    padding: 12,
                                    radius: 6.14925,
                                    child: Center(
                                      child: Text(
                                        "Upload",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Gelion',
                                          fontSize: 16,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: SizeConfig.screenWidth,
                              padding: EdgeInsets.fromLTRB(16, 4, 2, 3.9),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFC4C4C4), width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                              ),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: SizeConfig.screenWidth - 220,
                                    child: Text(
                                      _verifications[4],
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF717F88),
                                      ),
                                    ),
                                  ),
                                  Button(
                                    onTap: (){
                                      _getFile(4);
                                    },
                                    buttonColor: Color(0xFF00A69D),
                                    width: 103,
                                    padding: 12,
                                    radius: 6.14925,
                                    child: Center(
                                      child: Text(
                                        "Upload",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Gelion',
                                          fontSize: 16,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: SizeConfig.screenWidth,
                              padding: EdgeInsets.fromLTRB(16, 4, 2, 3.9),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFC4C4C4), width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: SizeConfig.screenWidth - 220,
                                    child: Text(
                                      _verifications[5],
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF717F88),
                                      ),
                                    ),
                                  ),
                                  Button(
                                    onTap: (){
                                      _getFile(5);
                                    },
                                    buttonColor: Color(0xFF00A69D),
                                    width: 103,
                                    padding: 12,
                                    radius: 6.14925,
                                    child: Center(
                                      child: Text(
                                        "Upload",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Gelion',
                                          fontSize: 16,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 80),
                        Button(
                          onTap: (){
                            if(_formKey.currentState.validate() && !_showSpinner){
                              _registerCandidate();
                            }
                          },
                          buttonColor: Color(0xFF00A69D),
                          child: Center(
                              child: _showSpinner
                                  ? CupertinoActivityIndicator(radius: 13)
                                  : Text(
                                "Register",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Gelion',
                                  fontSize: 16,
                                  color: Color(0xFFFFFFFF),
                                ),
                              )
                          ),
                        ),
                        SizedBox(height: 60),
                      ],
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

  /// This function builds the form widget for user to fill and validate their
  /// details
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Unique Skill(s)",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Gelion',
                  fontSize: 14,
                  color: Color(0xFF042538),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: SizeConfig.screenWidth,
                child: TextFormField(
                  controller: _skillsController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty){
                      return 'Enter your skills';
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    color: Color(0xFF042538),
                  ),
                  decoration:kFieldDecoration.copyWith(
                    hintText: 'Enter your skills',
                    hintStyle: TextStyle(
                      color: Color(0xFF717F88),
                      fontSize: 14,
                      fontFamily: 'Gelion',
                      fontWeight: FontWeight.normal,
                    ),
                    helperText: "Separate with \",\" if you have more than 1",
                    helperStyle: TextStyle(
                      color: Color(0xFF717F88),
                      fontSize: 14,
                      fontFamily: 'Gelion',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Language(s)",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Gelion',
                  fontSize: 14,
                  color: Color(0xFF042538),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: SizeConfig.screenWidth,
                child: TextFormField(
                  controller: _languagesController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  validator: (value){
                    if(value.isEmpty){
                      return 'Enter the languages you speak';
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    color: Color(0xFF042538),
                  ),
                  decoration:kFieldDecoration.copyWith(
                    hintText: 'Enter the languages you speak',
                    hintStyle: TextStyle(
                      color: Color(0xFF717F88),
                      fontSize: 14,
                      fontFamily: 'Gelion',
                      fontWeight: FontWeight.normal,
                    ),
                    helperText: "Separate with \",\" if you have more than 1",
                    helperStyle: TextStyle(
                      color: Color(0xFF717F88),
                      fontSize: 14,
                      fontFamily: 'Gelion',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
        ],
      )
    );
  }

  /// Function to save the user's details in [CreateCandidate] model then move
  /// to the next phase of registration [RegisterCandidateTwo]
  void _registerCandidate(){
    widget.candidate.skill = _skillsController.text;
    if(!mounted)return;
    setState(() { _showSpinner = true; });
    var api = AuthRestDataSource();
    api.registerCandidate(widget.candidate).then((value)async {
      if(!mounted)return;
      setState(() { _showSpinner = false; });
    }).catchError((e){
      print(e);
      if (!mounted) return;
      setState(() { _showSpinner = false; });
      Constants.showError(context, e);
    });
  }

}