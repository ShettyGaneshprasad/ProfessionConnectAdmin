import 'package:ProfessionConnect/screens/home/ProfessionConnectJobs/displayProfessionConnectJobs.dart';
import 'package:toast/toast.dart';
import 'package:ProfessionConnect/models/user.dart';
import 'package:ProfessionConnect/screens/home/drawerScreen.dart/aboutDeveloper/aboutDeveloper.dart';
import 'package:ProfessionConnect/screens/home/githubJobs/gihubJobsScreen.dart';
import 'package:ProfessionConnect/services/auth.dart';
import 'package:ProfessionConnect/services/githubJobs.dart';
import 'package:ProfessionConnect/shared/loading.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ProfessionConnect/models/githubJobs.dart';
import 'package:ProfessionConnect/services/database.dart';
import 'package:ProfessionConnect/screens/home/drawerScreen.dart/Profile/profileView.dart';
import 'ApproveJobs/ApproveJobsDetails.dart';
import 'ApproveJobs/jobsToBeApproved.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  List<GithubJobsModel> githubJobsList = new List<GithubJobsModel>();
  bool _loading = true;
  int widgetId = 1;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  MenuController _menuController;
  Color mainColor = Color(0xff2FD159);
  // Color mainColor = Colors.orangeAccent.shade200;
  Color secondaryColor = Colors.white;
  // for bottom sHeadElement final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  /// ---------------------------
  /// inilizing controllers and state .
  /// ---------------------------

  @override
  void initState() {
    print(
        "init state of home page\n\n\n\n\n\n\n\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#####");
    getNews();
    super.initState();

    _menuController = MenuController(vsync: this);
  }

  getNews() async {
    GithubJobs githubJobs = GithubJobs();
    print("github jobs object created");
    await githubJobs.getNews();
    print("exectuted job list and created news");
    githubJobsList = githubJobs.githubJobsList;
    setState(() {
      _loading = false;
    });
  }

  /// ---------------------------
  /// Closing controllers for memory leaks .
  /// ---------------------------
  dispose() {
    super.dispose();
    _menuController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  double setHeightPercentage(percentage, context) {
    if (percentage <= 100 || percentage > 0)
      return MediaQuery.of(context).size.height * (percentage / 100);
    else
      return MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    double height = setHeightPercentage(100, context);
    final userdata = Provider.of<User>(context);
    DatabaseService db = DatabaseService();

    /// ---------------------------
    /// Building Scaffold Reside Menu drawer .
    /// ---------------------------

    return ResideMenu.custom(
      decoration: new BoxDecoration(
        /// ---------------------------
        /// Building shaped  background drawer .
        /// ---------------------------

        gradient: LinearGradient(
          colors: <Color>[
            // Colors.yellow,
            // Color(0xFFFF3E4D),
            Color(0xff2FD159),
            Colors.white,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        color: Colors.white.withOpacity(0.5),
      ),
      controller: _menuController,
      leftView: getDrawer(height),

      /// ---------------------------
      /// Building home content.
      /// ---------------------------

      child: new Scaffold(
        appBar: buildAppBar(),
        body: _page == 0
            ? DisplayProfessionConnectJobs()
            : _page == 1
                ? JobsToBeApproved()
                : _page == 2
                    ? _loading
                        ? Loading()
                        : GithubJobScreen(
                            githubJobsList: githubJobsList,
                          )
                    : _page == 3
                        ? buildPage(3)
                        : _page == 4
                            ? JobsToBeApproved()
                            : buildPage(4),
        bottomNavigationBar: buildCurvedNavigationBar(),
      ),
    );
  }

  Container buildPage(int number) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              number.toString(),
              textScaleFactor: 10.0,
              style: TextStyle(
                color: mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  CurvedNavigationBar buildCurvedNavigationBar() {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,
      height: 50.0,
      items: <Widget>[
        Icon(
          Icons.home,
          size: 30,
          color: secondaryColor,
        ),
        Icon(
          Icons.done,
          size: 30,
          color: secondaryColor,
        ),
        Icon(
          Icons.supervised_user_circle,
          size: 30,
          color: secondaryColor,
        ),
        Icon(
          Icons.notifications_active,
          size: 30,
          color: secondaryColor,
        ),
        Icon(
          Icons.more_vert,
          size: 30,
          color: secondaryColor,
        ),
      ],
      color: mainColor,
      buttonBackgroundColor: mainColor,
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: (index) {
        setState(() {
          _page = index;
        });
      },
    );
  }

  AppBar buildAppBar() {
    // final userdata = Provider.of<User>(context);
    // DatabaseService db = DatabaseService(user:  userdata);
    return new AppBar(
      elevation: 8.0,
      centerTitle: true,
      backgroundColor: mainColor,
      leading: new GestureDetector(
        child: Container(
          color: mainColor,
          child: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        onTap: () {
          _menuController.openMenu(true);
        },
      ),
      title: new Text(
        'Profession Connect',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        // IconButton(
        //   icon: Icon(
        //     Icons.search,
        //     color: Colors.white,
        //   ),
        //   onPressed: () => {
        //     // Navigator.push(context,
        //     //     MaterialPageRoute(builder: (context) => GithubJobScreen()))
        //     // // getNews(), print("search pressed")
        //   },
        // ),
        buildGestureDetector()
      ],
    );
  }

  GestureDetector buildGestureDetector() {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.grey[600],
          context: context,
          isScrollControlled: true,
          builder: (context) => SingleChildScrollView(
            child: Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(30.0),
                      topRight: const Radius.circular(30.0))),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: bottomsheetForAddingJob(),
            ),
          ),
        );
      },
      child: Row(
        children: [
          Center(
              child: Text(
            "Add Job",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.library_add,
            color: Colors.white,
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }

// bottom sheet for adding jobs in PC
  Form bottomsheetForAddingJob() {
    String companyName;
    String position;
    String location;
    String salary;
    String jobRequirement;
    String jobDescription;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Add job',
              style: TextStyle(
                color: Color(0xff2FD159),
                fontWeight: FontWeight.bold,
                fontSize: 25,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              // controller: companyNameController,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Company name cannot be empty';
                } else if (value.length < 4) {
                  return ' Company name must be at least 4 characters long.';
                }
                companyName = value;
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Eg: Bosch',
                labelText: 'Company Name',
                labelStyle: TextStyle(
                  color: Color(0xff2FD159),
                ),
                hintStyle: TextStyle(
                  color: Color(0xff2FD159),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),

          // to add position
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (String value) {
                if (value.isEmpty) {
                  return 'position cannot be empty';
                } else if (value.length < 4) {
                  return 'position must be at least 4 characters long.';
                }
                position = value;
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Eg: Manager',
                labelText: 'Position',
                labelStyle: TextStyle(
                  color: Color(0xff2FD159),
                ),
                hintStyle: TextStyle(
                  color: Color(0xff2FD159),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Location cannot be empty';
                } else if (value.length < 4) {
                  return 'Location must be at least 4 characters long.';
                }
                location = value;
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Eg: Mumbai',
                labelText: 'Location',
                labelStyle: TextStyle(
                  color: Color(0xff2FD159),
                ),
                hintStyle: TextStyle(
                  color: Color(0xff2FD159),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          //to add salary
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (String value) {
                salary = value;
                return null;
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Eg: 250000',
                labelText: 'Salary',
                labelStyle: TextStyle(
                  color: Color(0xff2FD159),
                ),
                hintStyle: TextStyle(
                  color: Color(0xff2FD159),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),

          // add job requriments
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Requirements cannot be empty';
                } else if (value.length < 4) {
                  return 'Requirements must be at least 4 characters long.';
                }
                jobRequirement = value;
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Eg: Communication skill, Programming knowledge',
                labelText: 'Job Requirment',
                labelStyle: TextStyle(
                  color: Color(0xff2FD159),
                ),
                hintStyle: TextStyle(
                  color: Color(0xff2FD159),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Desc cannot be empty';
                } else if (value.length < 20) {
                  return 'Desc must be at least 20 characters long.';
                }
                jobDescription = value;
                return null;
              },
              decoration: InputDecoration(
                hintText:
                    'Eg: A enginner with knowledge of microcontroller and hands on experience with programming',
                labelText: 'Job Description',
                labelStyle: TextStyle(
                  color: Color(0xff2FD159),
                ),
                hintStyle: TextStyle(
                  color: Color(0xff2FD159),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),

          FloatingActionButton(
            backgroundColor: Color(0xff2FD159),
            child: Icon(
              Icons.playlist_add_check,
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                debugPrint('All validations passed!!!');

                try {
                  final userdata = Provider.of<User>(context, listen: false);
                  DatabaseService db = DatabaseService(user: userdata);

                  db.updateJobData(companyName, position, location, salary,
                      jobDescription, jobRequirement);
                } on Exception catch (_) {
                  Toast.show("Error in adding Job", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                  debugPrint('error');
                }
                Toast.show("Added Job Sucessfuly", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                debugPrint('sucess');
                Navigator.pop(context);
              } else {
                Toast.show("Error in adding Job", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
              }
            },
          ),
        ],
      ),
    );
  }

  /// ---------------------------
  /// Building drawer with helper method.
  /// ---------------------------

  getDrawer(double height) {
    return new Container(
      padding: new EdgeInsets.only(top: height * 0.1),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new ConstrainedBox(
            constraints: new BoxConstraints(maxHeight: 82.0, maxWidth: 82.0),
            child: getHeaderDrawerImage(),
          ),
          new SizedBox(
            height: 16.0,
          ),
          getHeaderText(),
          new SizedBox(
            height: 8.0,
          ),

          /// ---------------------------
          /// Building drawer list items.
          /// ---------------------------

          Expanded(
            child: Container(
              child: new ListView(
                /// ---------------------------
                /// Building list view items for drawer items.
                /// ---------------------------

                physics: const NeverScrollableScrollPhysics(),
                itemExtent: 40.0,
                shrinkWrap: true,
                children: <Widget>[
                  /// ---------------------------
                  /// Building one item  for drawer with helper method.
                  /// ---------------------------

                  getMaterialResideMenuItem('Home', Icons.home, 1),
                  getMaterialResideMenuItem('Profile', Icons.account_circle, 2),
                  getMaterialResideMenuItem('Saved Job', Icons.favorite, 3),
                  getMaterialResideMenuItem(
                      'Account Settings', Icons.settings, 6),
                  getMaterialResideMenuItem('Report Bugs', Icons.bug_report, 6),
                  getMaterialResideMenuItem('About us', Icons.group, 7),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Colors.black.withOpacity(0.5),
          ),
          Container(
            margin: new EdgeInsets.only(bottom: height * 0.122),
            child: getMaterialResideMenuItemWithCustomColor(Colors.white, 8),
          ),
        ],
      ),
    );
  }

  /// ---------------------------
  /// Building Header Drawer Image  for drawer with helper method.
  /// ---------------------------
  Widget getHeaderDrawerImage() {
    return new CircleAvatar(
      backgroundImage: NetworkImage(
        'https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search/jcr_content/main-pars/image/visual-reverse-image-search-v2_intro.jpg',
      ),
      radius: 50.0,
      backgroundColor: Colors.transparent,
    );
  }

  /// ---------------------------
  /// Building Header Drawer Text  for drawer with helper method.
  /// ---------------------------
  getHeaderText() {
    final userdata = Provider.of<User>(context);
    return Text(
      userdata.email,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        decoration: TextDecoration.none,
      ),
    );
  }

  Material getMaterialResideMenuItemWithCustomColor(
      Color drawerIconColor, int state) {
    final AuthService _auth = AuthService();
    String drawerMenuTitle = 'Log Out';
    IconData drawerMenuIcon = Icons.power_settings_new;
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        child: ResideMenuItem(
          title: drawerMenuTitle,
          icon: Icon(
            drawerMenuIcon,
            color: drawerIconColor,
          ),
        ),
        onTap: () => {_auth.signOut()},
      ),
    );
  }

  /// ---------------------------
  /// Changing active state for clicked item.
  /// ---------------------------
  setStateForWidget(int widgetId) {
    if (this.widgetId != widgetId)
      setState(() {
        this.widgetId = widgetId;
      });
    _menuController.closeMenu();
    if (widgetId == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ViewProfile()));
    } else {
      if (widgetId == 7) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutDeveloper()));
      }
    }
  }

  Material getMaterialResideMenuItem(
      String drawerMenuTitle, IconData drawerMenuIcon, int state) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: () => {
          setStateForWidget(state),
        },
        child: new Stack(
          children: <Widget>[
            ResideMenuItem(
              title: drawerMenuTitle,
              icon: Icon(
                drawerMenuIcon,
                color: new Color(0xffdddddd),
              ),
            ),
            widgetId == state
                ? Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 2),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(28),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(28),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------
///  Reside Menu Drawer widget goes here.
/// ---------------------------

typedef void OnOpen(bool isLeft);
typedef void OnClose();
typedef void OnOffsetChange(double offset);

enum ScrollDirection { LEFT, RIGHT, BOTH }
enum ScrollState { ScrollToLeft, NONE, ScrollToRight }

class ResideMenu extends StatefulWidget {
  // your content View
  final Widget child;

  //left or right Menu View
  final Widget leftView, rightView;

  //shadow elevation
  final double elevation;

  // it will control the menu Action,such as openMenu,closeMenu
  final MenuController controller;

  // used to set bottom bg and color
  final BoxDecoration decoration;

  final OnOpen onOpen;

  final OnClose onClose;

  final bool enableScale, enableFade, enable3dRotate;

  final OnOffsetChange onOffsetChange;

  ResideMenu.scaffold(
      {@required this.child,
      Widget leftBuilder,
      MenuScaffold leftScaffold,
      MenuScaffold rightScaffold,
      this.decoration: const BoxDecoration(),
      this.elevation: 12.0,
      this.onOpen,
      this.enableScale: true,
      this.enableFade: true,
      this.enable3dRotate: false,
      this.onClose,
      this.onOffsetChange,
      this.controller,
      Key key})
      : assert(child != null),
        leftView = leftScaffold,
        rightView = rightScaffold,
        super(key: key);

  ResideMenu.custom(
      {@required this.child,
      this.leftView,
      this.rightView,
      this.decoration: const BoxDecoration(color: const Color(0xff0000)),
      this.elevation: 12.0,
      this.onOpen,
      this.onClose,
      this.enable3dRotate: false,
      this.enableScale: true,
      this.enableFade: true,
      this.onOffsetChange,
      this.controller,
      Key key})
      : assert(child != null),
        super(key: key);

  @override
  _ResideMenuState createState() => new _ResideMenuState();
}

class _ResideMenuState extends State<ResideMenu>
    with SingleTickerProviderStateMixin {
  //determine width
  double _width = 0.0;
  MenuController _controller;
  ValueNotifier<ScrollState> _scrollState =
      ValueNotifier<ScrollState>(ScrollState.NONE);

  void _onScrollMove(DragUpdateDetails details) {
    double offset = details.delta.dx / _width * 2.0;
    if (_controller.value == 0.0) {
      if (details.delta.dy.abs() > details.delta.dx.abs() ||
          details.delta.dx.abs() < 10) return;
    }
    _controller.value += offset;
  }

  void _onScrollEnd(DragEndDetails details) {
    if (_controller.value > 0.5) {
      _controller.openMenu(true);
    } else if (_controller.value < -0.5) {
      _controller.openMenu(false);
    } else {
      _controller.closeMenu();
    }
  }

  void _handleScrollChange() {
    _scrollState.value = _controller.value == 0.0
        ? ScrollState.NONE
        : _controller.value > 0.0
            ? ScrollState.ScrollToLeft
            : ScrollState.ScrollToRight;
    if (widget.onOffsetChange != null) {
      widget.onOffsetChange(_controller.value.abs());
    }
  }

  void _handleScrollEnd(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (_controller.value == 1.0) {
        if (widget.onOpen != null) {
          widget.onOpen(true);
        }
      } else if (_controller.value == -1.0) {
        if (widget.onOpen != null) {
          widget.onOpen(false);
        }
      } else {
        if (widget.onClose != null) {
          widget.onClose();
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _update();
    super.didChangeDependencies();
  }

  // update listener
  void _update() {
    final MenuController newController = widget.controller ??
        MenuController(vsync: this, direction: ScrollDirection.LEFT);
    if (newController == null || newController == _controller) return;
    if (_controller != null)
      _controller
        ..removeListener(_handleScrollChange)
        ..removeStatusListener(_handleScrollEnd);
    _controller = newController;
    _controller
      ..addListener(_handleScrollChange)
      ..addStatusListener(_handleScrollEnd);
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollState.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollState.dispose();
    _controller
      ..removeListener(_handleScrollChange)
      ..removeStatusListener(_handleScrollEnd);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(ResideMenu oldWidget) {
    // TODO: implement didUpdateWidget
    _update();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(builder: (context, cons) {
      _width = cons.biggest.width;
      return WillPopScope(
        child: GestureDetector(
          onPanUpdate: _onScrollMove,
          onPanEnd: _onScrollEnd,
          child: new Stack(
            children: <Widget>[
              _scrollState.value != ScrollState.NONE
                  ? new Container(
                      decoration: widget.decoration,
                    )
                  : null,
              _scrollState.value != ScrollState.NONE
                  ? _MenuTransition(
                      offset: _controller,
                      child: new Container(
                          margin: new EdgeInsets.only(
                              left: (_scrollState.value ==
                                      ScrollState.ScrollToRight
                                  ? cons.biggest.width * 0.3
                                  : 0.0),
                              right: (_scrollState.value ==
                                      ScrollState.ScrollToLeft
                                  ? cons.biggest.width * 0.3
                                  : 0.0)),
                          child: _scrollState.value == ScrollState.ScrollToLeft
                              ? widget.leftView
                              : widget.rightView),
                    )
                  : null,
              _ContentTransition(
                  enableScale: widget.enableScale,
                  enable3D: widget.enable3dRotate,
                  child: new Stack(
                    children: <Widget>[
                      Container(
                        child: widget.child,
                        decoration: new BoxDecoration(boxShadow: <BoxShadow>[
                          new BoxShadow(
                            color: const Color(0xcc000000),
                            offset: const Offset(-2.0, 2.0),
                            blurRadius: widget.elevation * 0.66,
                          ),
                        ]),
                      ),
                      _scrollState.value != ScrollState.NONE
                          ? AnimatedBuilder(
                              animation: _controller,
                              builder: (c, w) {
                                return GestureDetector(
                                  child: Container(
                                    width: cons.biggest.width,
                                    height: cons.biggest.height,
                                    color: new Color.fromARGB(
                                        !widget.enableFade
                                            ? 0
                                            : (125 * _controller.value.abs())
                                                .toInt(),
                                        0,
                                        0,
                                        0),
                                  ),
                                  onTap: () {
                                    _controller.closeMenu();
                                  },
                                );
                              },
                            )
                          : null,
                    ].where((child) => child != null).toList(),
                  ),
                  menuOffset: _controller),
            ].where((child) => child != null).toList(),
          ),
        ),
        onWillPop: () async {
          if (_controller.value != 0) {
            _controller.closeMenu();
            return false;
          }
          return true;
        },
      );
    });
  }
}

class ResideMenuItem extends StatelessWidget {
  final String title;

  final TextStyle titleStyle;

  final Widget icon, right;

  final double height;

  final double midSpacing, leftSpacing, rightSpacing;

  const ResideMenuItem(
      {Key key,
      this.title: "Hello world",
      this.titleStyle: const TextStyle(
          inherit: true, color: const Color(0xffdddddd), fontSize: 15.0),
      this.icon: const Text(""),
      this.right: const Icon(
        Icons.arrow_forward_ios,
        color: const Color(0xffdddddd),
      ),
      this.height: 50.0,
      this.leftSpacing: 15.0,
      this.rightSpacing: 50.0,
      this.midSpacing: 30.0});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
        height: 40.0,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  icon,
                  Container(
                    width: midSpacing,
                  ),
                  Text(
                    title,
                    style: titleStyle,
                  )
                ],
              ),
              margin: EdgeInsets.only(left: leftSpacing),
            ),
//            Padding(
//              child: right,
//              padding: EdgeInsets.only(right: rightSpacing),
//            )
          ],
        ));
  }
}

class _MenuTransition extends AnimatedWidget {
  final Widget child;

  final Animation<double> offset;

  _MenuTransition({@required this.child, this.offset, Key key})
      : super(key: key, listenable: offset);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new LayoutBuilder(builder: (context, cons) {
      double width = cons.biggest.width;
      double height = cons.biggest.height;
      final Matrix4 transform = new Matrix4.identity()
        ..scale(2 - offset.value.abs(), 2 - offset.value.abs(), 1.0);
      return Opacity(
        opacity: offset.value.abs(),
        child: new Transform(
            transform: transform,
            child: child,
            origin: new Offset(width / 2, height / 2)),
      );
    });
  }
}

class _ContentTransition extends AnimatedWidget {
  final Widget child;

  final bool enableScale;
  final bool enable3D;

  _ContentTransition(
      {@required this.child,
      @required Animation<double> menuOffset,
      Key key,
      this.enable3D,
      this.enableScale})
      : super(key: key, listenable: menuOffset);

  Animation<double> get menuOffset => listenable;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new LayoutBuilder(builder: (context, cons) {
      double width = cons.biggest.width;
      double val = menuOffset.value;
      final Matrix4 transform = new Matrix4.identity();
      if (enable3D) {
        transform.setEntry(3, 2, 0.0008);
        transform.rotateY(val * 0.8);
        transform.transposeRotation();
      }
      if (enableScale) {
        transform.scale(1.0 - 0.25 * val.abs(), 1 - 0.25 * val.abs(), 1.0);
      }

      transform.translate(val * 0.8 * width);
      return Transform(
        alignment: Alignment.center,
        transform: transform,
        child: child,
      );
    });
  }
}

class MenuController extends AnimationController {
  bool _isOpenLeft = false;
  bool _isOpenRight = false;

  MenuController(
      {TickerProvider vsync,
      ScrollDirection direction: ScrollDirection.LEFT,
      Duration openDuration: const Duration(milliseconds: 300)})
      : super(
            vsync: vsync,
            lowerBound: direction == ScrollDirection.LEFT ? 0.0 : -1.0,
            upperBound: direction == ScrollDirection.RIGHT ? 0.0 : 1.0,
            duration: openDuration,
            value: 0.0);

  Future<void> openMenu(bool left) {
    return animateTo(left ? 1.0 : -1.0).then((_) {
      _isOpenLeft = left;
    });
  }

  Future<void> closeMenu() {
    return animateTo(0.0).then((_) {
      _isOpenLeft = false;
      _isOpenRight = false;
    });
  }

  bool get isOpenLeft => _isOpenLeft;

  bool get isOpenRight => _isOpenLeft;

  bool get isClose => !_isOpenLeft && !_isOpenRight;
}

class MenuScaffold extends StatelessWidget {
  final List<Widget> children;
  final Widget header;
  final Widget footer;
  final double itemExtent;
  final double topMargin;

  MenuScaffold(
      {Key key,
      @required this.children,
      this.topMargin: 100.0,
      Widget header,
      Widget footer,
      this.itemExtent: 40.0})
      : assert(children != null),
        header = header ?? new Container(height: 20.0),
        footer = footer ?? new Container(height: 20.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: new EdgeInsets.only(top: this.topMargin),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          header,
          new ListView(
            physics: const NeverScrollableScrollPhysics(),
            //  itemExtent: this.itemExtent,
//            shrinkWrap: true,
            children: children,
          ),
          footer,
        ],
      ),
    );
  }
}
