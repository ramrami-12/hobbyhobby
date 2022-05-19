// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:hobbyhobby/models/preference.dart';
import 'package:hobbyhobby/screens/MyPreferencePage/local_widget/my_dropdown_button.dart';
import 'local_widget/my_toggle_button.dart';

Preference pre = Preference(); 
class MyPreferPage extends StatefulWidget {
  const MyPreferPage({ Key? key }) : super(key: key);

  @override
  State<MyPreferPage> createState() => _MyPreferPageState();
}

class _MyPreferPageState extends State<MyPreferPage> {
  // J9geUe1iJXbuVjP6j1OI : user id 나중에는 받아오기
  // Stream preferStream = FirebaseFirestore.instance.collection('Usesr').doc('J9geUe1iJXbuVjP6j1OI').collection('Preferences').snapshots();
  // final _timeItems = ['평일', '주말', '오전', '오후'];
  // var _timeSelected = '평일';

  List<bool> _activitySelection = List.generate(2, (index) => false);
  List<bool> _sexSelection = List.generate(2, (index) => false);
  List<bool> _groupSelection = List.generate(2, (index) => false);


  final _maxCostItems = ['1만원 이하', '1~3만원', '3~5만원', '5만원 이상'];
  var _costSelected = '1만원 이하';

  final _purposeItems = ['배움', '재미', '입문'];
  var _purposeSelected = '입문';

  final _maxMeetItems = ['주 1~2회','주 3~4회','주 5회 이상'];
  var _maxMeetSelected = '주 1~2회';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preference Page'),
      ),
      body: Center(
        child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MyToggleButton(title: '활동', item1: 'On', item2: 'Off',
                      pressEvent: (int index) {
                        setState(() {
                          if(index == 0) {
                            _activitySelection[0] = true;
                            _activitySelection[1] = false;
                          } else {
                            _activitySelection[0] = false;
                            _activitySelection[1] = true;
                          }
                        });
                      },
                      selections: _activitySelection),
                  MyToggleButton(title: '성별', item1: '동성', item2: '혼성',
                      pressEvent: (int index) {
                        setState(() {
                          if(index == 0) {
                            _sexSelection[0] = true;
                            _sexSelection[1] = false;
                          } else {
                            _sexSelection[0] = false;
                            _sexSelection[1] = true;
                          }
                        });
                      },
                      selections: _sexSelection),
                  Row(
                children: <Widget> [
                  SizedBox( width: 80,),
                  Text(
                    '시간대',
                    style: TextStyle(
                      fontFamily: 'NanumSquareRoundR',
                      fontSize: 20,
                    ),
                  ),
                  SizedBox( width: 20,),
                  // grid view
                  Column(
                    children: [
                      ToggleButtons(color: Colors.greenAccent,
                          children: <Widget>[
                            Text('평일'),
                            Text('주말'),
                          ],
                          isSelected: _groupSelection
                      ),
                      SizedBox(height: 10,),
                      ToggleButtons(color: Colors.greenAccent,
                          children: <Widget>[
                            Text('오전'),
                            Text('오후'),
                          ],
                          isSelected: _groupSelection
                      ),
                    ],
                  ),
                  SizedBox( height: 50),

                ]
            ),
            MyDropDownButton(title: '1회 만남 최대 비용', selectValue: _costSelected, selectList: _maxCostItems,),
            MyDropDownButton(title: '목적', selectValue: _purposeSelected, selectList: _purposeItems,),
            MyDropDownButton(title: '최대 만남 횟수', selectValue: _maxMeetSelected, selectList: _maxMeetItems,),
            MyToggleButton(title: '그룹 성향', item1: '활발', item2: '조용',
                pressEvent: (int index) {
                  setState(() {
                    if(index == 0) {
                      _groupSelection[0] = true;
                      _groupSelection[1] = false;
                    } else {
                      _groupSelection[0] = false;
                      _groupSelection[1] = true;
                    }
                  });
                },
                selections: _groupSelection),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: savePreference,
              child:
              Text(
                '정보 저장',
                style: TextStyle(
                  fontFamily: 'NanumSquareRoundR',
                  fontSize: 30,
                ),
              ),
            )

          ],
        )
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void savePreference() {

  }
}

