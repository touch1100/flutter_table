# flutter_table

一个自定义可以上下左右滚动的表格。

## 实现

通过四个Table进行滚动监听来实现上下左右滑动。

```dart
 @override
  void initState() {
    super.initState();

    //监听第一列变动
    firstColumnController.addListener(() {
      if (firstColumnController.offset != thirdColumnController.offset) {
        thirdColumnController.jumpTo(firstColumnController.offset);
      }
    });

    //监听第三列变动
    thirdColumnController.addListener(() {
      if (firstColumnController.offset != thirdColumnController.offset) {
        firstColumnController.jumpTo(thirdColumnController.offset);
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
 
 	......
 
 }
```

## 使用

使用简单、方便。

直接在TableWidget传入相关参数。

```dart
class _TablePageState extends State<TablePage>{
  List<String> titleList = ['日期','项目','预计完成时间','项目','项目'];

  //列表所有数据
  List<List<String>> allList = [];
  List<String> contentList = [];
  // List<double> titleWidthList = [100];
  Map<int, double> titleWidthMap = Map();
  List<List<String>> _getContentList() {
    for (int i = 1; i < 20; i++) {
      contentList = [];
      contentList.add("202$i");
      contentList.add("学习2222222$i");
      contentList.add("202103$i");
      contentList.add("202103$i");
      contentList.add("202103$i");
      allList.add(contentList);
    }
    return allList;
  }


  List<String> _getSelectList(){
    List<String> selectList = [];
    selectList.add("2,5");
    selectList.add("0,1");
    selectList.add("3,0");
    selectList.add("0,4");
    selectList.add("0,6");
    selectList.add("0,0");
    return selectList;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenAdapter.init(context);
    titleWidthMap = {0:100,1:50,2:200,5:30};

    return Scaffold(
      appBar: AppBar(
        title: Text("Table"),
      ),
      body: Container(
        child: TableWidget(titleList,_getContentList(),selectList: _getSelectList(),
            onTap: (x,y){
              print("外部  x=$x y=$y");
            }),
      ),
    );
  }

}
```

## 属性



| 参数名称                     | 参数类型           | 作用                                                         | 备注 |
| ---------------------------- | ------------------ | ------------------------------------------------------------ | ---- |
| titleList                    | List<String>       | 表格标题                                                     | 必传 |
| contentList                  | List<List<String>> | 内容列表<br />将每一行的每个表格的内容添加到List,<br />再将每一行List添加到一个List。 | 必传 |
| titleBackgroundColor         | Color              | 标题背景颜色                                                 |      |
| titleTextColor               | Color              | 标题字体颜色                                                 |      |
| contentBackgroundColor       | Color              | 列表背景颜色                                                 |      |
| contentTextColor             | Color              | 列表字体颜色                                                 |      |
| leftFirstTextColor           | Color              | 左边第一列字体颜色                                           |      |
| leftFirstBackgroundColor     | Color              | 左边第一列背景颜色                                           |      |
| borderColor                  | Color              | 边框颜色                                                     |      |
| allSelectColor               | Color              | 所有选中颜色                                                 |      |
| selectTextColor              | Color              | 选中字体颜色                                                 |      |
| titleFontSize                | double             | 标题字体大小                                                 |      |
| contentFontSize              | double             | 列表字体大小                                                 |      |
| leftFirstFontSize            | double             | 左边第一列字体大小                                           |      |
| selectFontSize               | double             | 选中字体大小                                                 |      |
| tableTitleLeftRightPadding   | double             | 标题表格左右内边距(列宽度自适应情况下才起作用)               |      |
| tableTitleTopBottomPadding   | double             | 标题表格上下内边距(列宽度自适应情况下才起作用)               |      |
| tableContentTopBottomPadding | double             | 内容表格上下内边距(列宽度自适应情况下才起作用)               |      |
| titleRowHeight               | double             | 标题表格高度                                                 |      |
| contentRowHeight             | double             | 内容所有表格高度（不包含标题）                               |      |
| selectList                   | List<String>       | 选中列表  ["0,1","1,2"]<br />“0，1”：第二行第一列<br />(0代表列，1代表行) |      |
| titleWidthMap                | Map<int, double>   | 设置标题宽度 {0:100,1:50,2:200,5:30};<br />"0:100"代表第一列宽度为100 |      |
| titleMaxLines                | int                | 标题最大行数                                                 |      |
| contentMaxLines              | int                | 表格内容文字最大行数（不包含标题）                           |      |
| titleTextOverflow            | TextOverflow       | 标题TextOverflow,结合titleMaxLines一起使用                   |      |
| contentTextOverflow          | TextOverflow       | 表格内容TextOverflow（不包含标题）,结合contentMaxLines一起使用 |      |
| onTap                        | Function           | 每个表格的点击事件                                           |      |

## 注意：

在自适应情况下，每一列的最大宽度是屏幕宽度的1/2。

表格列宽度平分：可通过**titleWidthMap**使其平分

## 后续计划：

- [x] 添加表格宽度平分
- [x] 表格高度自适应

## 版本

### 1.0.1

- 表格高度自适应
- 添加一些设置参数

### 1.0.0+1

## 问题反馈

Issues

或QQ:1127141134（请备注）

如果有其他更好的写法你可以分享一下。

觉得不错的话请留下你的star，谢谢。

## Demo

[https://gitee.com/LinHaitao/flutter_table.git](https://gitee.com/LinHaitao/flutter_table.git)

## Thanks for

[https://blog.csdn.net/zzy123zzy123_/article/details/108867596](https://blog.csdn.net/zzy123zzy123_/article/details/108867596)

