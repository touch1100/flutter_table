import 'package:flutter/material.dart';
import 'package:flutter_table/utils/screen/ScreenAdapter.dart';
import 'package:flutter_table/view/table_widget.dart';

class TablePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TablePageState();
  }
}

class _TablePageState extends State<TablePage> {
  // List<String> titleList = ['日期','项目','预计完成时间预计完成时间预计完成时间预计完成时间','日期','项目','预计完成时间','日期','项目','预计完成时间','日期','项目','预计完成时间'
  // ,'日期','项目','预计完成时间','日期','项目','预计完成时间','日期','项目','预计完成时间','日期','项目','预计完成时间'];
  List<String> titleList = [
    '日期',
    '项目',
    '预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间预计完成时间',
    '项目',
    '项目',
    'test'
  ];

  // List<String> titleList = ['日期','项目ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
  //   '预计完成时间',
  //   '项目','项目'];

  //列表所有数据
  List<List<String>> allList = [];

  // List<double> titleWidthList = [100];
  Map<int, double> titleWidthMap = Map();
  List<String> mSelectList = [];
  var count = 0;

  @override
  void initState() {
    super.initState();
    allList.addAll(_getContentList());
    // _addContentList();
    mSelectList = [];
    // print(allList);
    // print(allList.length);
  }

  // Future<List<List<String>>> _getContentList() {
  List<List<String>> _getContentList() {
    List<List<String>> allList = [];
    for (int i = 0; i < 20; i++) {
      count++;
      List<String> contentList = [];
      if (i % 2 == 0) {
        contentList.add("202学习烦烦烦烦反反复复烦烦烦烦烦烦烦烦烦烦烦烦烦烦烦$count");
        contentList.add("学习烦烦烦烦反反复复烦烦烦烦烦烦烦烦烦烦烦烦烦烦烦$count");
        // contentList.add("202103$i");
        contentList.add("反反复复烦烦烦烦烦烦烦烦烦烦烦烦烦烦烦反反复复烦烦烦$count");
        // contentList.add("学习2222222255555555555555553333333332学习2222222255555555555555553333333332学习2222222255555555555555553333333332学习2222222255555555555555553333333332学习2222222255555555555555553333333332$i");
        contentList.add("202103$count");
        contentList.add("202103$count");
        contentList.add("test$count");
      } else {
        contentList.add("202学习$count");
        contentList.add("学习烦$count");
        // contentList.add("202103$i");
        contentList.add("反反复复$count");
        // contentList.add("学习2222222255555555555555553333333332学习2222222255555555555555553333333332学习2222222255555555555555553333333332学习2222222255555555555555553333333332学习2222222255555555555555553333333332$i");
        contentList.add("202103$count");
        contentList.add("202103$count");
        contentList.add("test$count");
      }
      allList.add(contentList);
    }
    // return Future(() => allList);
    return allList;
    // allList.add(contentList);
    // return allList;
  }

  _addContentList(List<List<String>> list) {
    // _getContentList().then((value) => {
    //   setState(() {
    //     allList.addAll(value);
    //   })
    // });

    setState(() {
      allList.addAll(list);
    });
  }

  void _getSelectList({x, y}) {
    // List<String> selectList = [];
    // selectList.add("2,5");
    // selectList.add("0,1");
    // selectList.add("3,0");
    // selectList.add("0,4");
    // selectList.add("0,6");
    // selectList.add("0,0");
    // selectList.add("1,1");
    // selectList.add("1,2");
    // print("---------------------");
    // print(x);
    // print(y);
    if (x != null && y != null) {
      var value = "$x,$y";
      setState(() {
        mSelectList.add(value);
      });
      // return selectList;
    } else {
      // return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenAdapter.init(context);
    // titleWidthMap = {0:100,1:250,2:400,5:30};//问题：得四个才可以滑动
    titleWidthMap = {
      0: ScreenAdapter.getScreenWith() / 4,
      1: ScreenAdapter.getScreenWith() / 3,
      2: ScreenAdapter.getScreenWith() / 3,
      3: ScreenAdapter.getScreenWith() / 5,
      4: ScreenAdapter.getScreenWith() / 3
    };

    return Scaffold(
      appBar: AppBar(
        title: Text("Table"),
      ),
      body: Container(
        child: TableWidget(titleList, allList,
            selectList: mSelectList,
            titleWidthMap: titleWidthMap,
            scrollBottom: () {
              print("-----------------------------scrollBottom");
              _addContentList(_getContentList());
              // _addContentList();
            },
            scrollTop: () {
              print("-------------------------------scrollTop");
            },
            titleMaxLines: 1,
            titleTextOverflow: TextOverflow.ellipsis,
            onTap: (x, y) {
              //如果是标题行， y = null.
              _getSelectList(x: x, y: y);
              // _addContentList(_getContentList());
              // print("外部  x=$x y=$y");
            }),
      ),
    );
  }
}
