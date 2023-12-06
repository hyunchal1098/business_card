import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //소개글 컨트롤러
  TextEditingController introduceController = TextEditingController();

  //수정여부
  bool isEditMode = false;

  ///위젯이 처음 실행되면 가장먼저 실행되는 곳
  @override
  void initState() {
    super.initState();
    getIntroduceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.accessibility_new,
          size: 30,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "발전하는 개발자 이현철을 소개합니다.",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //이름
            Container(
              width: double.infinity,
              height: 400,
              margin: EdgeInsets.all(16),

              ///이미지 둥글게 만드는
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/ID_picture.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //나이
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Row(
                children: [
                  Container(
                      width: 150,
                      child: Text(
                        "나이",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Text("29"),
                ],
              ),
            ),

            //취미
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Row(
                children: [
                  Container(
                      width: 150,
                      child: Text(
                        "취미",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Text("컴퓨터게임"),
                ],
              ),
            ),

            //직업
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Row(
                children: [
                  Container(
                      width: 150,
                      child: Text(
                        "직업",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Text("무직"),
                ],
              ),
            ),

            //학력
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Row(
                children: [
                  Container(
                      width: 150,
                      child: Text(
                        "학력",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Text("영진전문대학"),
                ],
              ),
            ),

            //MBTI
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Row(
                children: [
                  Container(
                      width: 150,
                      child: Text(
                        "MBTI",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Text("ISTJ"),
                ],
              ),
            ),

            //자기소개
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 16,
                    top: 16,
                  ),
                  child: Text(
                    "자기소개",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                ///Icon 같이 클릭이벤트관련 메서드가 없을경우 사용
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(
                      right: 16,
                      top: 16,
                    ),
                    child: Icon(
                      Icons.mode_edit,
                      color: isEditMode ? Colors.blueAccent : Colors.black,
                    ),
                  ),
                  onTap: () async {
                    if (!isEditMode) {
                      ///isEditMode에 따라 화면 자체를 색깔을 변경하므로 setState 사용
                      setState(() {
                        ///isEditMode를 true 바뀌면서 setState로 빌드함
                        isEditMode = true;
                        print(isEditMode);
                      });
                    } else {
                      //빈값이면 종료
                      if (introduceController.text.isEmpty) {
                        ///SnackBar : 하단에서 올라오는 알림창
                        var snackBar = SnackBar(
                          content: Text("자기소개값을 입력하세요."),
                          duration: Duration(seconds: 2),
                        );

                        ///SnackBar 사용하기 위한 코드
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      //저장 로직
                      var sharedPref = await SharedPreferences.getInstance();
                      sharedPref.setString(
                        "introduce",
                        introduceController.text,
                      );

                      ///isEditMode를 false 바뀌면서 setState로 빌드함
                      setState(() {
                        isEditMode = false;
                        print(isEditMode);
                      });
                    }
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: TextField(
                maxLines: 5,
                controller: introduceController,

                ///위젯 활성화
                enabled: isEditMode,
                decoration: InputDecoration(
                  ///테두리
                  border: OutlineInputBorder(
                    ///테두리 기울기
                    borderRadius: BorderRadius.circular(10),

                    ///테두리 끝
                    borderSide: BorderSide(
                      color: Color(0xffd9d9d9),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void>  getIntroduceData() async {
    var sharedPref = await SharedPreferences.getInstance();
    String introduceMsg = sharedPref.getString("introduce").toString();

    ///?? null  합류 연산자
    introduceController.text = introduceMsg ?? "";
  }
}
