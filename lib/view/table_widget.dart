import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_table/utils/screen/ScreenAdapter.dart';

///注：每一列的最大宽度是屏幕宽度的1/2(自适应情况下）
class TableWidget extends StatefulWidget {
  double rowWidth; //单个表宽
  double rowHeight; //表格高

  List<String> titleList = []; //标题  ["职责", "工作内容", "年度目标", "关联部门", "备注", "1"];
  List<List<String>> contentList = []; //内容列表
  List<String> selectList = []; //选中列表  ["0,1","1,2"]
  Map<int, double> titleWidthMap = Map(); //设置标题宽度 {0:100,1:50,2:200,5:30};

  Color titleBackgroundColor; //标题背景颜色
  Color titleTextColor; //标题字体颜色
  Color contentBackgroundColor; //列表背景颜色
  Color contentTextColor; //列表字体颜色
  Color leftFirstTextColor; //左边第一列字体颜色
  Color leftFirstBackgroundColor; //左边第一列背景颜色
  Color borderColor; //边框颜色
  Color allSelectColor; //所有选中颜色
  Color selectTextColor; //选中字体颜色

  double titleFontSize; //标题字体大小
  double contentFontSize; //列表字体大小
  double leftFirstFontSize; //左边第一列字体大小
  double selectFontSize; //选中字体大小
  double tableTitleLeftRightPadding; //标题表格左右内边距(列宽度自适应情况下才起作用)
  double tableTitleTopBottomPadding; //标题表格上下内边距(列宽度自适应情况下才起作用)
  double tableContentTopBottomPadding; //内容表格上下内边距(列宽度自适应情况下才起作用)
  double titleRowHeight; //标题表格高度
  double contentRowHeight; //内容所有表格高度（不包含标题）

  int titleMaxLines; //标题最大行数
  int contentMaxLines; //表格内容文字最大行数（不包含标题）

  TextOverflow titleTextOverflow; //标题TextOverflow,结合titleMaxLines一起使用
  TextOverflow
      contentTextOverflow; //表格内容TextOverflow（不包含标题）,结合contentMaxLines一起使用

  Function onTap;
  Function scrollBottom; //三星 970.906  华为mate10pro 994.092
  Function scrollTop;

  TableWidget(this.titleList, this.contentList,
      {this.rowWidth = 100.0,
      this.rowHeight = 48.0,
      this.titleBackgroundColor = Colors.greenAccent,
      this.titleTextColor = Colors.blueAccent,
      this.contentBackgroundColor = Colors.white,
      this.contentTextColor = Colors.black87,
      this.titleFontSize = 12,
      this.contentFontSize = 12,
      this.leftFirstBackgroundColor = Colors.white,
      this.leftFirstTextColor = Colors.black87,
      this.leftFirstFontSize = 12,
      this.selectList,
      this.titleWidthMap,
      this.borderColor = Colors.black54,
      this.allSelectColor = Colors.redAccent,
      this.selectTextColor = Colors.black87,
      this.selectFontSize = 12,
      this.tableTitleLeftRightPadding = 60, //60
      this.tableTitleTopBottomPadding = 20, //20
      this.tableContentTopBottomPadding = 20, //20
      this.titleMaxLines = null,
      this.contentMaxLines = null,
      this.titleTextOverflow = TextOverflow.clip,
      this.contentTextOverflow = TextOverflow.clip,
      this.titleRowHeight = null,
      this.contentRowHeight = null,
      this.onTap,
      this.scrollBottom,
      this.scrollTop});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TableState();
  }
}

class _TableState extends State<TableWidget> {
  //定义可控制滚动组件
  //第一列数据
  ScrollController firstColumnController = ScrollController();

  //右边内容数据Listview
  ScrollController thirdColumnController = ScrollController();

  //右边标题数据
  ScrollController firstRowController = ScrollController();

  //右边内容数据Listview下
  ScrollController secondedRowController = ScrollController();

  //列表所有数据
  List<List<String>> allList = [];

  //左边第一列数据--不包含顶部标题
  List<String> leftList = [];

  //右边所有数据--不包含顶部标题和第一列数据
  List<List<String>> rightList = [];

  //右边不包含顶部标题的数据
  List<String> rightContentList = [];

  // List<String> selectList = []];

  Size _firstColumnTextSize; //第一列文字大小
  double _firstColumnWidth; //第一列宽度
  Map<int, TableColumnWidth> _rightColumnWidthMap = Map(); //右边列的宽度
  double rightTotalWidth = 0; //右边总列宽
  Size _rightColumnTextSize; //右边单列文字大小
  List<double> _contentRowHeightList = []; //内容行高
  List<double> _titleRowWidthList = []; //内容行高

  void _getTwoList(List<List<String>> contentList) {
    // print("_getTwoList");
    // print(contentList.length);
    leftList.clear();
    rightList.clear();
    contentList.forEach((itList) {
      rightContentList = [];
      for (int i = 0; i < itList.length; i++) {
        if (i == 0) {
          leftList.add(itList[i]);
        } else {
          rightContentList.add(itList[i]);
        }
      }
      rightList.add(rightContentList);
    });
    // print(leftList.length);
  }

  List<int> xList = [];
  List<int> yList = [];

  ///第一列数据
  List<TableRow> _buildTableColumnOne() {
    List<TableRow> returnList = [];
    for (int i = 0; i < leftList.length; i++) {
      // print("leftList[i] ${leftList[i]}");
      returnList.add(_buildSingleColumnOne(i, leftList[i], leftList.length,
          isSelect: widget.selectList.length > 0
              ? widget.selectList.contains("0,$i")
              : false));
    }
    return returnList;
  }

  //创建tableRows
  List<TableRow> _buildTableRow() {
    List<TableRow> returnList = [];
    for (int j = 0; j < rightList.length; j++) {
      returnList.add(_buildSingleRow(j, rightList[j], false)); //添加行
    }
    return returnList;
  }

  ///第一行标题  创建单行
  List<TableRow> _buildTableOneRow() {
    List<TableRow> returnList = [];
    for (int j = 0; j < 1; j++) {
      returnList.add(_buildSingleRow(j, widget.titleList, true)); //添加行
    }
    return returnList;
  }

  //创建第一列tableRow
  TableRow _buildSingleColumnOne(int index, String text, int totalLength,
      {bool isSelect = false}) {
    // print("index: ${index}");
    return TableRow(children: [
      _buildSideBox(index, text, false, isLeftFirst: true, isSelect: isSelect),
    ]);
  }

  //创建一行tableRow
  TableRow _buildSingleRow(int index, List<String> textList, bool isTitle) {
    return TableRow(children: [
      for (int i = 0;
          i < (isTitle ? textList.length - 1 : textList.length);
          i++)
        isTitle
            ? _buildSideBox(i, textList[i + 1], true)
            : _buildSideBox(i, textList[i], false,
                xx: index,
                isSelect: widget.selectList != null
                    ? widget.selectList.contains("${i + 1},$index")
                    : false),
    ]);
  }

  //创建单个表格
  Widget _buildSideBox(int index, String title, bool isTitle,
      {bool isLeftFirst = false, int xx, bool isSelect = false}) {
    // print("_contentRowHeightList ${_contentRowHeightList.length}");
    return Container(
      color: isTitle
          ? widget.titleBackgroundColor
          : (isLeftFirst
              ? isSelect
                  ? widget.allSelectColor
                  : widget.leftFirstBackgroundColor
              : isSelect
                  ? widget.allSelectColor
                  : widget.contentBackgroundColor),
      child: InkWell(
        child: SizedBox(
            //isTitle?widget.titleRowHeight:widget.rowHeight
            height: isTitle
                ? widget.titleRowHeight
                : (widget.contentRowHeight != null
                    ? widget.contentRowHeight
                    : (isLeftFirst
                        ? _contentRowHeightList[index]
                        : _contentRowHeightList[xx])), //widget.rowHeight
            //widget.rowHeight
            child: Container(
              padding: EdgeInsets.all(0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 0.33, color: widget.borderColor),
                top: BorderSide(width: 0, color: widget.borderColor),
                right: BorderSide(width: 0.33, color: widget.borderColor),
                left: BorderSide(width: 0.33, color: widget.borderColor),
              )),
              child: Text(
                title,
                maxLines:
                    isTitle ? widget.titleMaxLines : widget.contentMaxLines,
                overflow: isTitle
                    ? widget.titleTextOverflow
                    : widget.contentTextOverflow,
                style: TextStyle(
                    fontSize: isTitle
                        ? widget.titleFontSize
                        : (isLeftFirst
                            ? isSelect
                                ? widget.selectFontSize
                                : widget.leftFirstFontSize
                            : isSelect
                                ? widget.selectFontSize
                                : widget.contentFontSize),
                    color: isTitle
                        ? widget.titleTextColor
                        : (isLeftFirst
                            ? isSelect
                                ? widget.selectTextColor
                                : widget.leftFirstTextColor
                            : isSelect
                                ? widget.selectTextColor
                                : widget.contentTextColor)),
              ),
            )),
        onTap: () {
          if (widget.onTap != null) {
            int x = 0;
            int y = 0;
            if (isLeftFirst) {
              x = 0;
              y = index;
              // print("&&x=0 y=$index");

            } else {
              y = xx;
              x = index + 1;
              // print("&&x=$x y=$y");
            }
            widget.onTap(x, y);
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    ///滚动监听
    scrollControllerListener();

    ///暂时解决方案：Map只有存的key个数>=4才可以滚动
    if (widget.titleWidthMap != null) {
      Map<int, double> otherMap = Map();
      for (int i = 1; i < 10; i++) {
        otherMap[widget.titleList.length + i] = 0;
      }
      widget.titleWidthMap.addAll(otherMap);
    }

    ///列宽度自适应
    columnWidthAdaptation();

    // if (!(widget.titleRowHeight != null && widget.titleRowHeight > 0)) {
    //   ///标题行高度自适应
    //   titleColumnHeightAdaptation();
    // }

    ///表格行高度自适应
    // tableContentHeightAdaptation();
  }

  ///滚动监听
  void scrollControllerListener() {
    //监听第一列变动
    firstColumnController.addListener(() {
      // print("offset = ${firstColumnController.offset}");
      // print("maxScrollExtent = ${firstColumnController.position.maxScrollExtent}");
      if (firstColumnController.offset != thirdColumnController.offset) {
        thirdColumnController.jumpTo(firstColumnController.offset);
      }
    });

    //监听第三列变动
    thirdColumnController.addListener(() {
      if (firstColumnController.offset != thirdColumnController.offset) {
        firstColumnController.jumpTo(thirdColumnController.offset);
      }
      if (thirdColumnController.position.pixels >=
          thirdColumnController.position.maxScrollExtent) {
        print("--------bottom");
        widget.scrollBottom();
      }
      if (thirdColumnController.position.pixels == 0) {
        widget.scrollTop();
        print("--------top");
      }
    });

    //监听第一行变动
    firstRowController.addListener(() {
      if (firstRowController.offset != secondedRowController.offset) {
        secondedRowController.jumpTo(firstRowController.offset);
      }
    });

    //监听第二行变动
    secondedRowController.addListener(() {
      if (firstRowController.offset != secondedRowController.offset) {
        firstRowController.jumpTo(secondedRowController.offset);
      }
    });
  }

  ///列宽度自适应
  void columnWidthAdaptation() {
    //获取文本大小
    _firstColumnTextSize = _getTextSize(
        widget.titleList[0],
        TextStyle(
            color: widget.titleTextColor, fontSize: widget.titleFontSize));

    ///设置第一列宽度
    if (widget.titleWidthMap != null && widget.titleWidthMap.containsKey(0)) {
      widget.titleWidthMap.forEach((key, value) {
        if (key == 0) {
          //设置右边列宽度
          _firstColumnWidth = value;
        }
      });
      // _firstColumnWidth = widget.titleWidthMap[0];
    } else {
      if (_firstColumnTextSize.width > ScreenAdapter.getScreenWith() / 2) {
        _firstColumnWidth = ScreenAdapter.getScreenWith() / 2;
      } else {
        _firstColumnWidth = _firstColumnTextSize.width +
            ScreenAdapter.width(widget.tableTitleLeftRightPadding);
      }
    }
    _titleRowWidthList.add(_firstColumnWidth); //注：把标题列宽度加进去，然后 进行计算高度

    ///设置右边列宽度
    if (widget.titleWidthMap != null) {
      for (int i = 1; i < widget.titleList.length; i++) {
        if (!widget.titleWidthMap.containsKey(i)) {
          //获取文本大小
          _rightColumnTextSize = _getTextSize(
              widget.titleList[i],
              TextStyle(
                  color: widget.titleTextColor,
                  fontSize: widget.titleFontSize));

          if (_rightColumnTextSize.width > ScreenAdapter.getScreenWith() / 2) {
            _rightColumnWidthMap[i - 1] = FixedColumnWidth(
                ScreenAdapter.getScreenWith() / 2 +
                    ScreenAdapter.width(widget.tableTitleLeftRightPadding));
            rightTotalWidth = rightTotalWidth +
                ScreenAdapter.getScreenWith() / 2 +
                ScreenAdapter.width(widget.tableTitleLeftRightPadding);

            _titleRowWidthList.add(ScreenAdapter.getScreenWith() / 2 +
                ScreenAdapter.width(widget.tableTitleLeftRightPadding));
          } else {
            _rightColumnWidthMap[i - 1] = FixedColumnWidth(
                _rightColumnTextSize.width +
                    ScreenAdapter.width(widget.tableTitleLeftRightPadding));
            rightTotalWidth = rightTotalWidth +
                _rightColumnTextSize.width +
                ScreenAdapter.width(widget.tableTitleLeftRightPadding);

            _titleRowWidthList.add(_rightColumnTextSize.width +
                ScreenAdapter.width(widget.tableTitleLeftRightPadding));
          }
        } else {
          _titleRowWidthList.add(widget.titleWidthMap[i]);
        }
        // print("标题列宽：$_titleRowWidthList");
      }
      // print("标题列宽(修改过)：$_titleRowWidthList");

      widget.titleWidthMap.forEach((key, value) {
        if (key != 0) {
          //设置右边列宽度
          _rightColumnWidthMap[key - 1] = FixedColumnWidth(value);
          rightTotalWidth = rightTotalWidth + value;
        }
      });
      if (widget.titleWidthMap.length < widget.titleList.length - 1) {
        rightTotalWidth = (widget.rowWidth) *
            (widget.titleList.length - 1 - widget.titleWidthMap.length);
      }
    } else {
      for (int i = 1; i < widget.titleList.length; i++) {
        //获取文本大小
        _rightColumnTextSize = _getTextSize(
            widget.titleList[i],
            TextStyle(
                color: widget.titleTextColor, fontSize: widget.titleFontSize));

        if (_rightColumnTextSize.width > ScreenAdapter.getScreenWith() / 2) {
          _rightColumnWidthMap[i - 1] = FixedColumnWidth(
              ScreenAdapter.getScreenWith() / 2 +
                  ScreenAdapter.width(widget.tableTitleLeftRightPadding));
          rightTotalWidth = rightTotalWidth +
              ScreenAdapter.getScreenWith() / 2 +
              ScreenAdapter.width(widget.tableTitleLeftRightPadding);

          _titleRowWidthList.add(ScreenAdapter.getScreenWith() / 2 +
              ScreenAdapter.width(widget.tableTitleLeftRightPadding));
        } else {
          _rightColumnWidthMap[i - 1] = FixedColumnWidth(
              _rightColumnTextSize.width +
                  ScreenAdapter.width(widget.tableTitleLeftRightPadding));
          rightTotalWidth = rightTotalWidth +
              _rightColumnTextSize.width +
              ScreenAdapter.width(widget.tableTitleLeftRightPadding);

          _titleRowWidthList.add(_rightColumnTextSize.width +
              ScreenAdapter.width(widget.tableTitleLeftRightPadding));
        }
      }

      // print("标题列宽(自适应)：$_titleRowWidthList");

      // rightTotalWidth = (widget.rowWidth) * (widget.titleList.length - 1);

    }
  }

  ///标题行高度自适应
  void titleColumnHeightAdaptation() {
    ///标题表格高度
    ///获取第一列第一个表格文本的高度
    double _firstColumnTextHeight = _firstColumnTextSize.height;
    widget.titleRowHeight = _firstColumnTextHeight;
    // print("第一个标题高度：${widget.titleRowHeight}");

    ///获取标题表格文本的高度
    for (int i = 1; i < widget.titleList.length; i++) {
      // print("${widget.titleList[i]}");
      //获取文本大小
      _rightColumnTextSize = _getTextSize(
          widget.titleList[i],
          TextStyle(
              color: widget.titleTextColor, fontSize: widget.titleFontSize));
      // print("标题不限制高度：${widget.titleRowHeight}");
      if (_rightColumnTextSize.width >= ScreenAdapter.getScreenWith() / 2) {
        _rightColumnTextSize = _getTextSize(
            widget.titleList[i],
            TextStyle(
                color: widget.titleTextColor, fontSize: widget.titleFontSize),
            textMaxWidth: ScreenAdapter.getScreenWith() / 2,
            textMaxLines: widget.titleMaxLines); //widget.titleMaxLines*2刚好显示完整
        // print("标题限制高度：${widget.titleRowHeight}");
      }
      if (widget.titleRowHeight <= _rightColumnTextSize.height) {
        widget.titleRowHeight = _rightColumnTextSize.height;
      }
      // print("标题最大高度：${widget.titleRowHeight}");
    }
    // widget.titleRowHeight = widget.titleRowHeight;
    widget.titleRowHeight = widget.titleRowHeight +
        ScreenAdapter.height(widget.tableTitleTopBottomPadding);
    // print("标题最终高度：${widget.titleRowHeight}");
  }

  ///表格行高度自适应
  void tableContentHeightAdaptation() {
    _contentRowHeightList.clear();

    ///获取每一行高度
    ///_contentRowHeightList
    // print("tableContentHeightAdaptation");
    double _everyRowHeight = 0;
    Size _rowTextSize;
    for (int i = 0; i < widget.contentList.length; i++) {
      _everyRowHeight = 0;
      for (int y = 0; y < widget.contentList[i].length; y++) {
        // print("标题：${widget.contentList[i][y]}    i = $i   y=$y  标题宽：${_titleRowWidthList[y]}");
        _rowTextSize = _getTextSize(
            widget.contentList[i][y],
            TextStyle(
                color: widget.contentTextColor,
                fontSize: widget.contentFontSize),
            textMaxWidth: _titleRowWidthList[y],
            //_firstColumnWidth   _titleRowWidthList[y]   ScreenAdapter.getScreenWith()/2
            textMaxLines:
                widget.contentMaxLines); //widget.titleMaxLines*2刚好显示完整

        if (_everyRowHeight <= _rowTextSize.height) {
          _everyRowHeight = _rowTextSize.height;
        }
        // print("第$y行高度：$_everyRowHeight");
      }
      _everyRowHeight = _everyRowHeight +
          ScreenAdapter.height(widget.tableContentTopBottomPadding);
      // print("行高度：$_everyRowHeight  i:$i");
      _contentRowHeightList.add(_everyRowHeight);
    }
    // print("_contentRowHeightList.length = ${_contentRowHeightList.length}");
    // print("行高度：$_contentRowHeightList");
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      // print("widget.rowHeight= ${widget.rowHeight}");
      // print("table_widget build");
      if (!(widget.titleRowHeight != null && widget.titleRowHeight > 0)) {
        ///标题行高度自适应
        titleColumnHeightAdaptation();
      }
      tableContentHeightAdaptation();
      _getTwoList(widget.contentList);
      // tableContentHeightAdaptation();
    });

    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: NotificationListener(
        //表格
        child: Container(
          // padding: EdgeInsets.only(right: 8, left:8, top: 8, bottom: 8),
          // margin: EdgeInsets.only(right: 16,left:16),
          // height: 209,
          // width:375,
          // color:Colors.lightGreen,
          child: Row(
            children: [
              //第一列
              Container(
                // width: widget.rowWidth,
                width: _firstColumnWidth,
                // height:200,
                child: Column(
                  children: [
                    Table(
                      children: [
                        TableRow(
                          children: [
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 0.33, color: widget.borderColor),
                                    top: BorderSide(
                                        width: 0.33, color: widget.borderColor),
                                    right: BorderSide(
                                        width: 0.33, color: widget.borderColor),
                                    left: BorderSide(
                                        width: 0.33, color: widget.borderColor),
                                  ),
                                ),
                                child: Container(
                                  height: widget.titleRowHeight - 0.66,
                                  //widget.rowHeight - 0.33
                                  color: widget.titleBackgroundColor,
                                  // padding: EdgeInsets.all(10),
                                  child: Center(
                                    child: Text(
                                      widget.titleList[0],
                                      textAlign: TextAlign.center,
                                      maxLines: widget.titleMaxLines,
                                      overflow: widget.titleTextOverflow,
                                      style: TextStyle(
                                          color: widget.titleTextColor,
                                          fontSize: widget.titleFontSize),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                widget.onTap(0, null);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    //SingleChildScrollView(
                    Expanded(
                      child: ListView(
                        physics: ClampingScrollPhysics(),
                        controller: firstColumnController,
                        children: [
                          Table(children: _buildTableColumnOne()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //其余列
              Expanded(
                child: Container(
                  // width: 200,
                  child: Column(children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal, //horizontal
                          controller: firstRowController,
                          child: Container(
                            child: Table(
                              children: _buildTableOneRow(),
                              //  columnWidths: {
                              // 0:FixedColumnWidth (200)
                              //  },
                              columnWidths: _rightColumnWidthMap,
                            ),
                            // width: (widget.rowWidth) *
                            //     (widget.titleList.length - 1), //设置列的行宽
                            width: rightTotalWidth, //设置列的行宽
                          )),
                    ),
                    Expanded(
                      child: ListView(
                        physics: ClampingScrollPhysics(),
                        controller: thirdColumnController,
                        children: [
                          SingleChildScrollView(
                            physics: ClampingScrollPhysics(),
                            controller: secondedRowController,
                            scrollDirection: Axis.horizontal, //horizontal
                            child: Row(
                              children: [
                                Container(
                                  child: Table(
                                    children: _buildTableRow(),
                                    columnWidths: _rightColumnWidthMap,
                                  ),
                                  // width: (widget.rowWidth) *
                                  //     (widget.titleList.length - 1), //设置列的行宽
                                  width: rightTotalWidth, //设置列的行宽
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    firstColumnController?.dispose();
    thirdColumnController?.dispose();
    firstRowController?.dispose();
    secondedRowController?.dispose();
    super.dispose();
  }

  Size _getTextSize(String text, TextStyle style,
      {textMaxWidth = double.infinity, int textMaxLines = null}) {
    final TextPainter textPainter = TextPainter(
        maxLines: textMaxLines,
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: textMaxWidth);
    return textPainter.size;
  }
}
