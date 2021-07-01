import 'package:flutter/material.dart';
import 'package:householdexecutives_mobile/model/saved-list.dart';
import 'package:householdexecutives_mobile/utils/reusable-widgets.dart';
import 'package:householdexecutives_mobile/utils/size-config.dart';

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

                },
                selected: false,
                showStars: false,
              ),
            ),
          );
        }
        _categoryTabs.add(
          SingleChildScrollView(
            child: Column(
              children: candidateContainers
            )
          )
        );
      }
    });
  }

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: widget.categories.length, vsync: this);
    _setTabLabels();
    _setTabs();
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
          "Schedule",
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
                  'You’re only allowed to select a maximmum of 3\ncandidates per category',
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
              SizedBox(height: 45),
              Button(
                onTap: (){

                },
                buttonColor: Color(0xFF00A69D),
                child: Center(
                  child: Text(
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
              SizedBox(height: 60),
            ]
        ),
      ),
    );
  }

}
