import 'package:flutter/material.dart';
import 'package:new_soul/card_view.dart';
import 'package:new_soul/edit_profile_page.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:group_list_view/group_list_view.dart';
import 'app_colors.dart';


import 'package:flutter/cupertino.dart';
import 'user.dart';
import 'user_preferences.dart';
import 'appbar_widget.dart';
import 'button_widget.dart';
import 'numbers_widget.dart';
import 'profile_widget.dart';
//import 'profile_page.dart';



void main() {
  runApp(MyApp());
}

Map<String, List> _elements = {
  'Group A': ['Klay Lewis', 'Ehsan Woodard', 'River Bains'],
  'Group B': ['Toyah Downs', 'Tyla Kane'],
  'Group C': ['Marcus Romero', 'Farrah Parkes', 'Fay Lawson', 'Asif Mckay'],
  'Group D': ['Casey Zuniga', 'Ayisha Burn', 'Josie Hayden', 'Kenan Walls', 'Mario Powers'],
  'Group Q': ['Toyah Downs', 'Tyla Kane', 'Toyah Downs'],
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      //home: MyHomePage(title: 'Soul'),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffe04c7e),
            leading: const IconButton(
              icon: Icon(Icons.settings,color: Color(0xffffe1ec)),
              tooltip: 'Navigation menu',
              onPressed: null,
            ),
            title: const Text('Soul'),
          ),
          bottomNavigationBar: menu(),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              MyHomePage(title: 'Soul'),
              ProfilePage(),
              Icon(Icons.format_list_bulleted),
              GroupListView(
                sectionsCount: _elements.keys.toList().length,
                countOfItemInSection: (int section) {
                  return _elements.values.toList()[section].length;
                },
                itemBuilder: _itemBuilder,
                groupHeaderBuilder: (BuildContext context, int section) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(
                      _elements.keys.toList()[section],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
                sectionSeparatorBuilder: (context, section) => SizedBox(height: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      color: Color(0xffe04c7e),
      child: TabBar(
        tabs: [
          Tab(text: 'Swipe', icon: Icon(Icons.help)),
          Tab(text: 'Profile', icon: Icon(Icons.person)),
          Tab(text: 'Settings', icon: Icon(Icons.format_list_bulleted)),
          Tab(text: 'Chat', icon: Icon(Icons.chat)),
        ],
      ),
    );
  }
  Widget _itemBuilder(BuildContext context, IndexPath index) {
    String user = _elements.values.toList()[index.section][index.index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 8,
        child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 18, vertical: 10.0),
          leading: CircleAvatar(
            child: Text(
              _getInitials(user),
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            backgroundColor: _getAvatarColor(user),
          ),
          title: Text(
            _elements.values.toList()[index.section][index.index],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }

  String _getInitials(String user) {
    var buffer = StringBuffer();
    var split = user.split(" ");
    for (var s in split) buffer.write(s[0]);

    return buffer.toString().substring(0, split.length);
  }

  Color _getAvatarColor(String user) {
    return AppColors
        .avatarColors[user.hashCode % AppColors.avatarColors.length];
  }

}

class MyProfile extends StatefulWidget {
  MyProfile({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyProfileState createState() => _MyProfileState();
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 4;

  @override
  Widget build(BuildContext context) {
    //create a CardController
    SwipeableCardSectionController _cardController =
    SwipeableCardSectionController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff7986cb),
        leading: const IconButton(
          icon: Icon(Icons.menu,color: Color(0xffffe1ec)),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text('Yes or no questions'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SwipeableCardsSection(
            cardController: _cardController,
            context: context,
            //add the first 3 cards
            items: [
              CardView(text: "Do you like the mountains?", image: "assets/image_1.jpg",),
              CardView(text: "Do you like Donald Trump?", image: "assets/image_2.jpg"),
              CardView(text: "Do you like liquorice?", image: "assets/image_3.jpg"),
            ],
            onCardSwiped: (dir, index, widget) {
              //Add the next card
              if (counter <= 20) {
                _cardController.addItem(CardView(text: "Do you like Card $counter?", image: "assets/image_1.jpg"));
                counter++;
              }

              if (dir == Direction.left) {
                print('onDisliked ${(widget as CardView).text} $index');
              } else if (dir == Direction.right) {
                print('onLiked ${(widget as CardView).text} $index');
              } else if (dir == Direction.up) {
                print('onUp ${(widget as CardView).text} $index');
              } else if (dir == Direction.down) {
                print('onDown ${(widget as CardView).text} $index');
              }
            },
            enableSwipeUp: true,
            enableSwipeDown: true,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  backgroundColor: Color(0xffffb74d),
                  child: Icon(Icons.block),
                  onPressed: () => _cardController.triggerSwipeDown(),
                ),
                FloatingActionButton(
                  backgroundColor: Color(0xffe57373),
                  child: Icon(Icons.thumb_down),
                  onPressed: () => _cardController.triggerSwipeLeft(),
                ),
                FloatingActionButton(
                  backgroundColor: Color(0xff81c784),
                  child: Icon(Icons.thumb_up),
                  onPressed: () => _cardController.triggerSwipeRight(),
                ),
                FloatingActionButton(
                  backgroundColor: Color(0xff64b5f6),
                  child: Icon(Icons.watch_later),
                  onPressed: () => _cardController.triggerSwipeUp(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}class _MyProfileState extends State<MyProfile> {

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff7986cb),
        leading: const IconButton(
          icon: Icon(Icons.person, color: Color(0xffffe1ec)),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text('My profile'),
        // actions: const [
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     tooltip: 'Search',
        //     onPressed: null,
        //   ),
        // ],
      ),
      // body is the majority of the screen.
      body: const Center(
        child: Text('Hello, world!'),
      ),
    );
  }
}

//---------------------------------------------------------------------------------------------------



class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      //appBar: buildAppBar(context),
      appBar: AppBar(
        backgroundColor: Color(0xff7986cb),
        leading: const IconButton(
          icon: Icon(Icons.person, color: Color(0xffffe1ec)),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text('My profile'),
        // actions: const [
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     tooltip: 'Search',
        //     onPressed: null,
        //   ),
        // ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) => EditProfilePage()),
              // );
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 48),
          buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
    children: [
      Text(
        user.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildUpgradeButton() => ButtonWidget(
    text: 'Upgrade To PRO',
    onClicked: () {},
  );

  Widget buildAbout(User user) => Container(
    padding: EdgeInsets.symmetric(horizontal: 48, vertical: 10),
    margin: EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: Color(0xffd1eaff),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About me',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          user.about,
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}