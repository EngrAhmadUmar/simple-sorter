import 'package:flutter/material.dart';
import 'package:fluttertodolistsqfliteapp/screens/categories_screen.dart';
import 'package:fluttertodolistsqfliteapp/screens/home_screen.dart';
import 'package:fluttertodolistsqfliteapp/screens/todos_by_category.dart';
import 'package:fluttertodolistsqfliteapp/services/category_service.dart';

class DrawerNavigaton extends StatefulWidget {
  @override
  _DrawerNavigatonState createState() => _DrawerNavigatonState();
}

class _DrawerNavigatonState extends State<DrawerNavigaton> {
  List<Widget> _categoryList = List<Widget>();

  CategoryService _categoryService = CategoryService();

  @override
  initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    var categories = await _categoryService.readCategories();

    categories.forEach((category) {
      setState(() {
        _categoryList.add(InkWell(
          onTap: () => Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new TodosByCategory(
                        category: category['name'],
                      ))),
          child: ListTile(
            title: Text(category['name']),
          ),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              // currentAccountPicture: CircleAvatar(

              accountName: Text('Welcome to Simple Sorter'),
              accountEmail: Text('Run your life like a pro!'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categories'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoriesScreen())),
            ),
            Divider(),
            Column(
              children: _categoryList,
            ),
          ],
        ),
      ),
    );
  }
}
