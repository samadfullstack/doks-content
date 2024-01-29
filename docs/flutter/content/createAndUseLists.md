## Create and Use lists

Displaying lists of data is a fundamental pattern for mobile apps. Flutter includes the [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html) widget to make working with lists a breeze.

## [](https://docs.flutter.dev/cookbook/lists/basic-list#create-a-listview)Create a ListView

Using the standard `ListView` constructor is perfect for lists that contain only a few items. The built-in [`ListTile`](https://api.flutter.dev/flutter/material/ListTile-class.html) widget is a way to give items a visual structure.


```
ListView(
  children: const <Widget>[
    ListTile(
      leading: Icon(Icons.map),
      title: Text('Map'),
    ),
    ListTile(
      leading: Icon(Icons.photo_album),
      title: Text('Album'),
    ),
    ListTile(
      leading: Icon(Icons.phone),
      title: Text('Phone'),
    ),
  ],
),
```