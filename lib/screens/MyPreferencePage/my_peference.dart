import 'package:flutter/material.dart';

class myPreferPage extends StatefulWidget {
  @override
  myPreferPageState createState() => myPreferPageState();
}

class myPreferPageState extends State<myPreferPage> {

  List<bool> _selections1 = List.generate(2, (index) => false);
  final _timeItems = ['1만원 이하', '1~3만원', '3~5만원', '5만원 이상'];
  var _timeSelected = '1만원 이하';

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
            Row(
              children: <Widget> [
                SizedBox( width: 100,),
                Text(
                  '활동',
                  style: TextStyle(
                    fontFamily: 'NanumSquareRoundR',
                    fontSize: 20,
                  ),
                ),
                SizedBox( width: 20,),
                ToggleButtons(color: Colors.greenAccent,
                    children: <Widget>[
                      Text('On'),
                      Text('Off'),
                    ],
                    isSelected: _selections1
                ),
                SizedBox( height: 50),
              ],
            ),
            Row(
                children: <Widget> [
                  SizedBox( width: 100,),
                  Text(
                    '성별',
                    style: TextStyle(
                      fontFamily: 'NanumSquareRoundR',
                      fontSize: 20,
                    ),
                  ),
                  SizedBox( width: 20,),
                  ToggleButtons(color: Colors.greenAccent,
                      children: <Widget>[
                        Text('동성'),
                        Text('혼성'),
                      ],
                      isSelected: _selections1
                  ),
                  SizedBox( height: 80),

                ]
            ),
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
                  Column(
                    children: [
                      ToggleButtons(color: Colors.greenAccent,
                          children: <Widget>[
                            Text('평일'),
                            Text('주말'),
                          ],
                          isSelected: _selections1
                      ),
                      SizedBox(height: 10,),
                      ToggleButtons(color: Colors.greenAccent,
                          children: <Widget>[
                            Text('오전'),
                            Text('오후'),
                          ],
                          isSelected: _selections1
                      ),
                    ],
                  ),
                  SizedBox( height: 50),

                ]
            ),
            Row(
                children: <Widget> [
                  SizedBox( width: 20,),
                  Text(
                    '1회 만남 최대 비용',
                    style: TextStyle(
                      fontFamily: 'NanumSquareRoundR',
                      fontSize: 20,
                    ),
                  ),
                  SizedBox( height: 20, width: 20,),
                  DropdownButton(
                    value: _timeSelected,
                    items: _timeItems.map(
                            (value) {
                          return DropdownMenuItem(
                              value: value,
                              child: Text(value)
                          );
                        }
                    ).toList(),
                    onChanged: (item) {
                      setState(() {
                        _timeSelected = 'item';
                      });
                    },
                  ),
                  SizedBox( height: 50),

                ]
            ),
            Row(
                children: <Widget> [
                  SizedBox( width: 100,),
                  Text(
                    '목적',
                    style: TextStyle(
                      fontFamily: 'NanumSquareRoundR',
                      fontSize: 20,
                    ),
                  ),
                  SizedBox( height: 20, width: 30,),
                  DropdownButton(
                    value: _purposeSelected,
                    items: _purposeItems.map(
                            (value) {
                          return DropdownMenuItem(
                              value: value,
                              child: Text(value)
                          );
                        }
                    ).toList(),
                    onChanged: (item) {
                      setState(() {
                        _purposeSelected = 'item';
                      });
                    },
                  ),
                  SizedBox( height: 50),

                ]
            ),
            Row(
                children: <Widget> [
                  SizedBox( width: 40,),
                  Text(
                    '최대 만남 횟수',
                    style: TextStyle(
                      fontFamily: 'NanumSquareRoundR',
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10, height: 20),
                  DropdownButton(
                    value: _maxMeetSelected,
                    items: _maxMeetItems.map(
                            (value) {
                          return DropdownMenuItem(
                              value: value,
                              child: Text(value)
                          );
                        }
                    ).toList(),
                    onChanged: (item) {
                      setState(() {
                        _maxMeetSelected = 'item';
                      });
                    },
                  ),
                  SizedBox( height: 60),

                ]
            ),
            Row(
                children: <Widget> [
                  SizedBox( width: 60,),
                  Text(
                    '그룹 성향',
                    style: TextStyle(
                      fontFamily: 'NanumSquareRoundR',
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 20,),
                  ToggleButtons(color: Colors.greenAccent,
                      children: <Widget>[
                        Text('활발'),
                        Text('조용'),
                      ],
                      isSelected: _selections1
                  ),
                  SizedBox( height: 50),

                ]
            ),
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
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void savePreference() {

  }
}
