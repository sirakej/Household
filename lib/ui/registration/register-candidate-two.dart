import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/candidate-availability.dart';
import 'package:householdexecutives_mobile/networking/restdata-source.dart';
import 'package:householdexecutives_mobile/utils/constant.dart';
import 'package:householdexecutives_mobile/utils/photo-permissions.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';
import 'package:householdexecutives_mobile/model/create-candidate.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:householdexecutives_mobile/utils/static-functions.dart';
import 'package:path_provider/path_provider.dart';
import 'candidate-created-successfully.dart';

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

  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  /// A [TextEditingController] to control the input text for the user's address
  TextEditingController _addressController = TextEditingController();

  /// A [TextEditingController] to control the input text for the unique skills
  TextEditingController _skillsController = TextEditingController();

  /// A [TextEditingController] to control the input text for the name of current
  /// of previous employer
  TextEditingController _nameEmployerController = TextEditingController();

  /// A [TextEditingController] to control the input text for the position of
  /// current of previous employer
  TextEditingController _positionEmployerController = TextEditingController();

  /// A list of string variables holding a list of all languages
  List<String> _languages = [
    "Arabic", "English", "Francais", "Hausa", "Hindi", "Igbo", "Italiano",
    "Mandarin", "Yoruba", "Native Dialect", "Other"
  ];

  /// A List to hold the all the selected languages
  List<String> _allSelectedLanguages = [];

  /// A string variable holding the selected language
  String _selectedLanguage;

  bool _liveIn = false;
  bool _custom = true;

  bool _monday = true;
  bool _tuesday = true;
  bool _wednesday = true;
  bool _thursday = true;
  bool _friday = true;
  bool _saturday = true;
  bool _sunday = false;

  Map<dynamic, String> _verifications = {
    1: 'Passport Photograph',
    2: 'Government Identity',
    3: 'Current Recent Utility Bill'
  };

  List<String> _verificationName = [
    'Passport Photograph',
    'Government Identity',
    'Current Recent Utility Bill'
  ];

  List<String> _uploadName = [
    'profile_image',
    'government_identity',
    'utility_bill',
  ];

  String _passportPhoto = 'Passport Photograph'; // IMG123.JPEG
  String _governmentIdentity = 'Government Identity';
  String _utilityBill = 'Current Recent Utility Bill';

  Map<int, http.MultipartFile> _uploads = {
    1: null, 2: null, 3: null
  };

  Future<void> _loadAssets(int id) async {
    List<Asset> resultList = [];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        materialOptions: MaterialOptions(
          statusBarColor: '#00A69D',
          actionBarColor: '#00A69D',
          selectCircleStrokeColor: '#00A69D',
          allViewTitle: "All Photos",
        ),
      );
    } on Exception catch (e) {
      print(e.toString());
      if(e.toString() == "The user has denied the gallery access."){
        PhotoPermissions.buildImageRequest(context);
      }
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if(resultList != null){
      if(resultList.length > 0){
        _uploads[id] = null;
        _verifications[id] = _verificationName[id-1];
        Asset asset = resultList[0];
        ByteData thumbData = await asset.getByteData();
        final directory = await getTemporaryDirectory();
        final imageFile = await File('${directory.path}/${asset.name}').create();
        await imageFile.writeAsBytes(thumbData.buffer.asUint8List());
        _verifications[id] = "${_verifications[id]}.${asset.name.split('.').last}";
        _uploads[id] = await http.MultipartFile.fromPath(_uploadName[id-1], imageFile.path, filename: _verificationName[id-1]);
      }
    }

    if (!mounted) return;
    setState(() {
      //if (error == null) _error = 'No Error Detected';
      //print(_error);
    });

  }

  /// Boolean variable holding either the condition is accepted or not
  bool _terms = false;

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
                  'Register as a Candidate',
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
                                        "Live Out",
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
                              firstChild: Container(
                                padding: EdgeInsets.only(bottom: 33),
                                child: Row(
                                  children: [
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
                                  ],
                                ),
                              ),
                              secondChild: Container(
                                padding: EdgeInsets.only(bottom: 33),
                                child: Row(
                                  children: [
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
                        SizedBox(height: 16),
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
                                      _loadAssets(1);
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: SizeConfig.screenWidth,
                                  child: Text(
                                    "  (Valid Driver's License or NIN Slip)",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Gelion',
                                      fontSize: 12,
                                      color: Color(0xFF042538),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
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
                                          _loadAssets(2);
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
                            SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: SizeConfig.screenWidth,
                                  child: Text(
                                    "  (Eko Electric, Ikeja Electric or LAWMA)",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Gelion',
                                      fontSize: 12,
                                      color: Color(0xFF042538),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
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
                                          _loadAssets(3);
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
                          ],
                        ),
                        SizedBox(height: 28),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: _terms == false
                                    ? Icon(
                                  Icons.check_box_outline_blank_outlined,
                                  size: 25,
                                  color:  Color(0xFF9097A5),
                                )
                                    : Icon(
                                  Icons.check_box_outlined,
                                  size: 25,
                                  color:  Color(0xFF9097A5),
                                ),
                                onPressed: (){
                                  setState(() {
                                    _terms =! _terms;
                                  });
                                }
                            ),
                            RichText(
                              text:TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gelion',
                                    fontSize: 14,
                                    color: Color(0xFF042538),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Terms of Use",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF00A69D),
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = (){
                                        //Navigator.pushNamed(context, Terms.id);
                                      },
                                    ),
                                    TextSpan(text: " & "),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gelion',
                                        fontSize: 14,
                                        color: Color(0xFF00A69D),
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = (){
                                        //Navigator.pushNamed(context, Terms.id);
                                      },
                                    ),
                                    TextSpan(text:" of\nHousehold Executives")
                                  ]
                              ),
                              textAlign: TextAlign.start,
                            )
                          ],
                        ),
                        SizedBox(height: 80),
                        Button(
                          onTap: (){
                            if(_allSelectedLanguages.length > 0){
                              if(_formKey.currentState.validate() && !_showSpinner){
                                if(_uploads.containsValue(null)){
                                  Functions.showInfo(context, 'Please upload all Documents');
                                }
                                else {
                                  if(_terms){
                                    _setAvailability();
                                    _registerCandidate();
                                  }
                                  else {
                                    Functions.showInfo(context, 'Agree to the terms and conditions');
                                  }
                                }
                              }
                            }
                            else {
                              Functions.showInfo(context, 'Select at least one preferred language');
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
          SizedBox(height: 20),
          // Residence
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Residence",
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
                  controller: _addressController,
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your residence';
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
                      hintText: 'Ogba, Lagos',
                      hintStyle:TextStyle(
                        color:Color(0xFF717F88),
                        fontSize: 14,
                        fontFamily: 'Gelion',
                        fontWeight: FontWeight.normal,
                      )
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Skills
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
          // Languages
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
                child: DropdownButtonFormField(
                  isExpanded: true,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    color: Color(0xFF042538),
                  ),
                  icon: Image.asset(
                      'assets/icons/arrow-down.png',
                      height: 18,
                      width: 18,
                      fit: BoxFit.contain
                  ),
                  value: _selectedLanguage,
                  onChanged: (value){
                    if(!mounted)return;
                    setState(() {
                      if(!_allSelectedLanguages.contains(value)){
                        _allSelectedLanguages.add(value);
                      }
                      _selectedLanguage = null;
                    });
                  },
                  decoration: kFieldDecoration.copyWith(
                    hintText: 'Please Select',
                    hintStyle: TextStyle(
                      color: Color(0xFF717F88),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Gelion',
                    ),
                  ),
                  selectedItemBuilder: (BuildContext context){
                    return _languages.map((value){
                      return Text(
                        value,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          color: Color(0xFF042538),
                        ),
                      );
                    }).toList();
                  },
                  items: _languages.map((value){
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Gelion',
                          color: Color(0xFF042538),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10),
              _buildLanguageList(),
            ],
          ),
          SizedBox(height: 20),
          // Name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name of Current/Former Employer",
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
                  controller: _nameEmployerController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty) return 'Enter name';
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    color: Color(0xFF042538),
                  ),
                  decoration:kFieldDecoration.copyWith(
                    hintText: 'Name',
                    hintStyle: TextStyle(
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
          // Position
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Position with Current/Former Employer",
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
                  controller: _positionEmployerController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                    if(value.isEmpty) return 'Enter your position';
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Gelion',
                    color: Color(0xFF042538),
                  ),
                  decoration:kFieldDecoration.copyWith(
                    hintText: 'Position',
                    hintStyle: TextStyle(
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

  /// Function to build the selected language list in a row
  Widget _buildLanguageList(){
    List<Widget> languageContainer = [];
    if(_allSelectedLanguages.length <= 0){
      languageContainer.add(Container());
    }
    else {
      for(int i = 0; i < _allSelectedLanguages.length; i++){
        if(_allSelectedLanguages[i] != null){
          languageContainer.add(
            InkWell(
              onTap: (){
                if(!mounted)return;
                setState(() {
                  _allSelectedLanguages.removeAt(i);
                });
              },
              child: Container(
                padding: EdgeInsets.only(left: 9.73, right: 3.89242),
                margin: EdgeInsets.only(right: 7.78484, bottom: 8),
                decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    border: Border.all(color: Color(0xFF757575), width: 0.486553, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(7.78484))
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _allSelectedLanguages[i],
                      style: TextStyle(
                          fontFamily: 'Gelion',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF0C0C0C)
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.close_sharp,
                      size: 12,
                      color: Color(0xFF000000),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }
    }
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      children: languageContainer,
    );
  }

  void _setAvailability(){
    var availability = Availability();
    availability.title = _liveIn ? 'Live In' : 'Custom';
    availability.sunday = { "availability": _sunday, "booked": false };
    availability.monday = { "availability": _monday, "booked": false };
    availability.tuesday = { "availability": _tuesday, "booked": false };
    availability.wednesday = { "availability": _wednesday, "booked": false };
    availability.thursday = { "availability": _thursday, "booked": false };
    availability.friday = { "availability": _friday, "booked": false };
    availability.saturday = { "availability": _saturday, "booked": false };
    widget.candidate.availability = availability;
  }

  /// Function to save the user's details in [CreateCandidate] model then move
  /// to the next phase of registration [RegisterCandidateTwo]
  void _registerCandidate(){
    widget.candidate.skill = _skillsController.text;
    widget.candidate.languages = _allSelectedLanguages.join(',');
    widget.candidate.residence = _addressController.text.trim();
    widget.candidate.previousEmployer = _nameEmployerController.text.trim();
    widget.candidate.previousEmployerPosition = _positionEmployerController.text.trim();
    List<http.MultipartFile> uploads = [];
    _uploads.forEach((key, value) => uploads.add(value));
    widget.candidate.image = uploads;
    if(!mounted)return;
    setState(() => _showSpinner = true);
    var api = RestDataSource();
    api.registerCandidate(widget.candidate).then((value)async {
      if(!mounted)return;
      setState(() => _showSpinner = false);
      Navigator.pushReplacementNamed(context, CandidateCreatedSuccessfully.id);
    }).catchError((e){
      print(e);
      if (!mounted) return;
      setState(() {
        _showSpinner = false;
        _resetUploads();
      });
      Functions.showError(context, e);
    });
  }

  _resetUploads(){
    _uploads = { 1: null, 2: null, 3: null};
    _verifications = {
      1: 'Passport Photograph',
      2: 'Government Identity',
      3: 'Current Recent Utility Bill'
    };
  }

}
