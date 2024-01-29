1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Persistence](https://docs.flutter.dev/cookbook/persistence)
3.  [Persist data with SQLite](https://docs.flutter.dev/cookbook/persistence/sqlite)

If you are writing an app that needs to persist and query large amounts of data on the local device, consider using a database instead of a local file or key-value store. In general, databases provide faster inserts, updates, and queries compared to other local persistence solutions.

Flutter apps can make use of the SQLite databases via the [`sqflite`](https://pub.dev/packages/sqflite) plugin available on pub.dev. This recipe demonstrates the basics of using `sqflite` to insert, read, update, and remove data about various Dogs.

If you are new to SQLite and SQL statements, review the [SQLite Tutorial](http://www.sqlitetutorial.net/) to learn the basics before completing this recipe.

This recipe uses the following steps:

1.  Add the dependencies.
2.  Define the `Dog` data model.
3.  Open the database.
4.  Create the `dogs` table.
5.  Insert a `Dog` into the database.
6.  Retrieve the list of dogs.
7.  Update a `Dog` in the database.
8.  Delete a `Dog` from the database.

## 1\. Add the dependencies

To work with SQLite databases, import the `sqflite` and `path` packages.

-   The `sqflite` package provides classes and functions to interact with a SQLite database.
-   The `path` package provides functions to define the location for storing the database on disk.

To add the packages as a dependency, run `flutter pub add`:

```
<span>$</span><span> </span>flutter pub add sqflite path
```

Make sure to import the packages in the file you’ll be working in.

```
<span>import</span><span> </span><span>'dart:async'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:flutter/widgets.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:path/path.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:sqflite/sqflite.dart'</span><span>;</span>
```

## 2\. Define the Dog data model

Before creating the table to store information on Dogs, take a few moments to define the data that needs to be stored. For this example, define a Dog class that contains three pieces of data: A unique `id`, the `name`, and the `age` of each dog.

```
<span>class</span><span> </span><span>Dog</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>int</span><span> id</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> name</span><span>;</span><span>
  </span><span>final</span><span> </span><span>int</span><span> age</span><span>;</span><span>

  </span><span>const</span><span> </span><span>Dog</span><span>({</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>id</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>name</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>age</span><span>,</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

## 3\. Open the database

Before reading and writing data to the database, open a connection to the database. This involves two steps:

1.  Define the path to the database file using `getDatabasesPath()` from the `sqflite` package, combined with the `join` function from the `path` package.
2.  Open the database with the `openDatabase()` function from `sqflite`.

```
<span>// Avoid errors caused by flutter upgrade.</span><span>
</span><span>// Importing 'package:flutter/widgets.dart' is required.</span><span>
</span><span>WidgetsFlutterBinding</span><span>.</span><span>ensureInitialized</span><span>();</span><span>
</span><span>// Open the database and store the reference.</span><span>
</span><span>final</span><span> database </span><span>=</span><span> openDatabase</span><span>(</span><span>
  </span><span>// Set the path to the database. Note: Using the `join` function from the</span><span>
  </span><span>// `path` package is best practice to ensure the path is correctly</span><span>
  </span><span>// constructed for each platform.</span><span>
  join</span><span>(</span><span>await</span><span> getDatabasesPath</span><span>(),</span><span> </span><span>'doggie_database.db'</span><span>),</span><span>
</span><span>);</span>
```

## 4\. Create the `dogs` table

Next, create a table to store information about various Dogs. For this example, create a table called `dogs` that defines the data that can be stored. Each `Dog` contains an `id`, `name`, and `age`. Therefore, these are represented as three columns in the `dogs` table.

1.  The `id` is a Dart `int`, and is stored as an `INTEGER` SQLite Datatype. It is also good practice to use an `id` as the primary key for the table to improve query and update times.
2.  The `name` is a Dart `String`, and is stored as a `TEXT` SQLite Datatype.
3.  The `age` is also a Dart `int`, and is stored as an `INTEGER` Datatype.

For more information about the available Datatypes that can be stored in a SQLite database, see the [official SQLite Datatypes documentation](https://www.sqlite.org/datatype3.html).

```
<span>final</span><span> database </span><span>=</span><span> openDatabase</span><span>(</span><span>
  </span><span>// Set the path to the database. Note: Using the `join` function from the</span><span>
  </span><span>// `path` package is best practice to ensure the path is correctly</span><span>
  </span><span>// constructed for each platform.</span><span>
  join</span><span>(</span><span>await</span><span> getDatabasesPath</span><span>(),</span><span> </span><span>'doggie_database.db'</span><span>),</span><span>
  </span><span>// When the database is first created, create a table to store dogs.</span><span>
  onCreate</span><span>:</span><span> </span><span>(</span><span>db</span><span>,</span><span> version</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// Run the CREATE TABLE statement on the database.</span><span>
    </span><span>return</span><span> db</span><span>.</span><span>execute</span><span>(</span><span>
      </span><span>'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)'</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>},</span><span>
  </span><span>// Set the version. This executes the onCreate function and provides a</span><span>
  </span><span>// path to perform database upgrades and downgrades.</span><span>
  version</span><span>:</span><span> </span><span>1</span><span>,</span><span>
</span><span>);</span>
```

## 5\. Insert a Dog into the database

Now that you have a database with a table suitable for storing information about various dogs, it’s time to read and write data.

First, insert a `Dog` into the `dogs` table. This involves two steps:

1.  Convert the `Dog` into a `Map`
2.  Use the [`insert()`](https://pub.dev/documentation/sqflite_common/latest/sqlite_api/DatabaseExecutor/insert.html) method to store the `Map` in the `dogs` table.

```
<span>class</span><span> </span><span>Dog</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>int</span><span> id</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> name</span><span>;</span><span>
  </span><span>final</span><span> </span><span>int</span><span> age</span><span>;</span><span>

  </span><span>const</span><span> </span><span>Dog</span><span>({</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>id</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>name</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>age</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>// Convert a Dog into a Map. The keys must correspond to the names of the</span><span>
  </span><span>// columns in the database.</span><span>
  </span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;</span><span> toMap</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>{</span><span>
      </span><span>'id'</span><span>:</span><span> id</span><span>,</span><span>
      </span><span>'name'</span><span>:</span><span> name</span><span>,</span><span>
      </span><span>'age'</span><span>:</span><span> age</span><span>,</span><span>
    </span><span>};</span><span>
  </span><span>}</span><span>

  </span><span>// Implement toString to make it easier to see information about</span><span>
  </span><span>// each dog when using the print statement.</span><span>
  @override
  </span><span>String</span><span> toString</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>'Dog{id: $id, name: $name, age: $age}'</span><span>;</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

```
<span>// Define a function that inserts dogs into the database</span><span>
</span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> insertDog</span><span>(</span><span>Dog</span><span> dog</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>// Get a reference to the database.</span><span>
  </span><span>final</span><span> db </span><span>=</span><span> </span><span>await</span><span> database</span><span>;</span><span>

  </span><span>// Insert the Dog into the correct table. You might also specify the</span><span>
  </span><span>// `conflictAlgorithm` to use in case the same dog is inserted twice.</span><span>
  </span><span>//</span><span>
  </span><span>// In this case, replace any previous data.</span><span>
  </span><span>await</span><span> db</span><span>.</span><span>insert</span><span>(</span><span>
    </span><span>'dogs'</span><span>,</span><span>
    dog</span><span>.</span><span>toMap</span><span>(),</span><span>
    conflictAlgorithm</span><span>:</span><span> </span><span>ConflictAlgorithm</span><span>.</span><span>replace</span><span>,</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

```
<span>// Create a Dog and add it to the dogs table</span><span>
</span><span>var</span><span> fido </span><span>=</span><span> </span><span>const</span><span> </span><span>Dog</span><span>(</span><span>
  id</span><span>:</span><span> </span><span>0</span><span>,</span><span>
  name</span><span>:</span><span> </span><span>'Fido'</span><span>,</span><span>
  age</span><span>:</span><span> </span><span>35</span><span>,</span><span>
</span><span>);</span><span>

</span><span>await</span><span> insertDog</span><span>(</span><span>fido</span><span>);</span>
```

## 6\. Retrieve the list of Dogs

Now that a `Dog` is stored in the database, query the database for a specific dog or a list of all dogs. This involves two steps:

1.  Run a `query` against the `dogs` table. This returns a `List<Map>`.
2.  Convert the `List<Map>` into a `List<Dog>`.

```
<span>// A method that retrieves all the dogs from the dogs table.</span><span>
</span><span>Future</span><span>&lt;</span><span>List</span><span>&lt;</span><span>Dog</span><span>&gt;&gt;</span><span> dogs</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>// Get a reference to the database.</span><span>
  </span><span>final</span><span> db </span><span>=</span><span> </span><span>await</span><span> database</span><span>;</span><span>

  </span><span>// Query the table for all The Dogs.</span><span>
  </span><span>final</span><span> </span><span>List</span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;</span><span> maps </span><span>=</span><span> </span><span>await</span><span> db</span><span>.</span><span>query</span><span>(</span><span>'dogs'</span><span>);</span><span>

  </span><span>// Convert the List&lt;Map&lt;String, dynamic&gt; into a List&lt;Dog&gt;.</span><span>
  </span><span>return</span><span> </span><span>List</span><span>.</span><span>generate</span><span>(</span><span>maps</span><span>.</span><span>length</span><span>,</span><span> </span><span>(</span><span>i</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Dog</span><span>(</span><span>
      id</span><span>:</span><span> maps</span><span>[</span><span>i</span><span>][</span><span>'id'</span><span>]</span><span> </span><span>as</span><span> </span><span>int</span><span>,</span><span>
      name</span><span>:</span><span> maps</span><span>[</span><span>i</span><span>][</span><span>'name'</span><span>]</span><span> </span><span>as</span><span> </span><span>String</span><span>,</span><span>
      age</span><span>:</span><span> maps</span><span>[</span><span>i</span><span>][</span><span>'age'</span><span>]</span><span> </span><span>as</span><span> </span><span>int</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

```
<span>// Now, use the method above to retrieve all the dogs.</span><span>
print</span><span>(</span><span>await</span><span> dogs</span><span>());</span><span> </span><span>// Prints a list that include Fido.</span>
```

## 7\. Update a `Dog` in the database

After inserting information into the database, you might want to update that information at a later time. You can do this by using the [`update()`](https://pub.dev/documentation/sqflite_common/latest/sqlite_api/DatabaseExecutor/update.html) method from the `sqflite` library.

This involves two steps:

1.  Convert the Dog into a Map.
2.  Use a `where` clause to ensure you update the correct Dog.

```
<span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> updateDog</span><span>(</span><span>Dog</span><span> dog</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>// Get a reference to the database.</span><span>
  </span><span>final</span><span> db </span><span>=</span><span> </span><span>await</span><span> database</span><span>;</span><span>

  </span><span>// Update the given Dog.</span><span>
  </span><span>await</span><span> db</span><span>.</span><span>update</span><span>(</span><span>
    </span><span>'dogs'</span><span>,</span><span>
    dog</span><span>.</span><span>toMap</span><span>(),</span><span>
    </span><span>// Ensure that the Dog has a matching id.</span><span>
    where</span><span>:</span><span> </span><span>'id = ?'</span><span>,</span><span>
    </span><span>// Pass the Dog's id as a whereArg to prevent SQL injection.</span><span>
    whereArgs</span><span>:</span><span> </span><span>[</span><span>dog</span><span>.</span><span>id</span><span>],</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

```
<span>// Update Fido's age and save it to the database.</span><span>
fido </span><span>=</span><span> </span><span>Dog</span><span>(</span><span>
  id</span><span>:</span><span> fido</span><span>.</span><span>id</span><span>,</span><span>
  name</span><span>:</span><span> fido</span><span>.</span><span>name</span><span>,</span><span>
  age</span><span>:</span><span> fido</span><span>.</span><span>age </span><span>+</span><span> </span><span>7</span><span>,</span><span>
</span><span>);</span><span>
</span><span>await</span><span> updateDog</span><span>(</span><span>fido</span><span>);</span><span>

</span><span>// Print the updated results.</span><span>
print</span><span>(</span><span>await</span><span> dogs</span><span>());</span><span> </span><span>// Prints Fido with age 42.</span>
```

## 8\. Delete a `Dog` from the database

In addition to inserting and updating information about Dogs, you can also remove dogs from the database. To delete data, use the [`delete()`](https://pub.dev/documentation/sqflite_common/latest/sqlite_api/DatabaseExecutor/delete.html) method from the `sqflite` library.

In this section, create a function that takes an id and deletes the dog with a matching id from the database. To make this work, you must provide a `where` clause to limit the records being deleted.

```
<span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> deleteDog</span><span>(</span><span>int</span><span> id</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>// Get a reference to the database.</span><span>
  </span><span>final</span><span> db </span><span>=</span><span> </span><span>await</span><span> database</span><span>;</span><span>

  </span><span>// Remove the Dog from the database.</span><span>
  </span><span>await</span><span> db</span><span>.</span><span>delete</span><span>(</span><span>
    </span><span>'dogs'</span><span>,</span><span>
    </span><span>// Use a `where` clause to delete a specific dog.</span><span>
    where</span><span>:</span><span> </span><span>'id = ?'</span><span>,</span><span>
    </span><span>// Pass the Dog's id as a whereArg to prevent SQL injection.</span><span>
    whereArgs</span><span>:</span><span> </span><span>[</span><span>id</span><span>],</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

## Example

To run the example:

1.  Create a new Flutter project.
2.  Add the `sqflite` and `path` packages to your `pubspec.yaml`.
3.  Paste the following code into a new file called `lib/db_test.dart`.
4.  Run the code with `flutter run lib/db_test.dart`.

```
<span>import</span><span> </span><span>'dart:async'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:flutter/widgets.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:path/path.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:sqflite/sqflite.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>// Avoid errors caused by flutter upgrade.</span><span>
  </span><span>// Importing 'package:flutter/widgets.dart' is required.</span><span>
  </span><span>WidgetsFlutterBinding</span><span>.</span><span>ensureInitialized</span><span>();</span><span>
  </span><span>// Open the database and store the reference.</span><span>
  </span><span>final</span><span> database </span><span>=</span><span> openDatabase</span><span>(</span><span>
    </span><span>// Set the path to the database. Note: Using the `join` function from the</span><span>
    </span><span>// `path` package is best practice to ensure the path is correctly</span><span>
    </span><span>// constructed for each platform.</span><span>
    join</span><span>(</span><span>await</span><span> getDatabasesPath</span><span>(),</span><span> </span><span>'doggie_database.db'</span><span>),</span><span>
    </span><span>// When the database is first created, create a table to store dogs.</span><span>
    onCreate</span><span>:</span><span> </span><span>(</span><span>db</span><span>,</span><span> version</span><span>)</span><span> </span><span>{</span><span>
      </span><span>// Run the CREATE TABLE statement on the database.</span><span>
      </span><span>return</span><span> db</span><span>.</span><span>execute</span><span>(</span><span>
        </span><span>'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)'</span><span>,</span><span>
      </span><span>);</span><span>
    </span><span>},</span><span>
    </span><span>// Set the version. This executes the onCreate function and provides a</span><span>
    </span><span>// path to perform database upgrades and downgrades.</span><span>
    version</span><span>:</span><span> </span><span>1</span><span>,</span><span>
  </span><span>);</span><span>

  </span><span>// Define a function that inserts dogs into the database</span><span>
  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> insertDog</span><span>(</span><span>Dog</span><span> dog</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Get a reference to the database.</span><span>
    </span><span>final</span><span> db </span><span>=</span><span> </span><span>await</span><span> database</span><span>;</span><span>

    </span><span>// Insert the Dog into the correct table. You might also specify the</span><span>
    </span><span>// `conflictAlgorithm` to use in case the same dog is inserted twice.</span><span>
    </span><span>//</span><span>
    </span><span>// In this case, replace any previous data.</span><span>
    </span><span>await</span><span> db</span><span>.</span><span>insert</span><span>(</span><span>
      </span><span>'dogs'</span><span>,</span><span>
      dog</span><span>.</span><span>toMap</span><span>(),</span><span>
      conflictAlgorithm</span><span>:</span><span> </span><span>ConflictAlgorithm</span><span>.</span><span>replace</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>// A method that retrieves all the dogs from the dogs table.</span><span>
  </span><span>Future</span><span>&lt;</span><span>List</span><span>&lt;</span><span>Dog</span><span>&gt;&gt;</span><span> dogs</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Get a reference to the database.</span><span>
    </span><span>final</span><span> db </span><span>=</span><span> </span><span>await</span><span> database</span><span>;</span><span>

    </span><span>// Query the table for all The Dogs.</span><span>
    </span><span>final</span><span> </span><span>List</span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;</span><span> maps </span><span>=</span><span> </span><span>await</span><span> db</span><span>.</span><span>query</span><span>(</span><span>'dogs'</span><span>);</span><span>

    </span><span>// Convert the List&lt;Map&lt;String, dynamic&gt; into a List&lt;Dog&gt;.</span><span>
    </span><span>return</span><span> </span><span>List</span><span>.</span><span>generate</span><span>(</span><span>maps</span><span>.</span><span>length</span><span>,</span><span> </span><span>(</span><span>i</span><span>)</span><span> </span><span>{</span><span>
      </span><span>return</span><span> </span><span>Dog</span><span>(</span><span>
        id</span><span>:</span><span> maps</span><span>[</span><span>i</span><span>][</span><span>'id'</span><span>]</span><span> </span><span>as</span><span> </span><span>int</span><span>,</span><span>
        name</span><span>:</span><span> maps</span><span>[</span><span>i</span><span>][</span><span>'name'</span><span>]</span><span> </span><span>as</span><span> </span><span>String</span><span>,</span><span>
        age</span><span>:</span><span> maps</span><span>[</span><span>i</span><span>][</span><span>'age'</span><span>]</span><span> </span><span>as</span><span> </span><span>int</span><span>,</span><span>
      </span><span>);</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> updateDog</span><span>(</span><span>Dog</span><span> dog</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Get a reference to the database.</span><span>
    </span><span>final</span><span> db </span><span>=</span><span> </span><span>await</span><span> database</span><span>;</span><span>

    </span><span>// Update the given Dog.</span><span>
    </span><span>await</span><span> db</span><span>.</span><span>update</span><span>(</span><span>
      </span><span>'dogs'</span><span>,</span><span>
      dog</span><span>.</span><span>toMap</span><span>(),</span><span>
      </span><span>// Ensure that the Dog has a matching id.</span><span>
      where</span><span>:</span><span> </span><span>'id = ?'</span><span>,</span><span>
      </span><span>// Pass the Dog's id as a whereArg to prevent SQL injection.</span><span>
      whereArgs</span><span>:</span><span> </span><span>[</span><span>dog</span><span>.</span><span>id</span><span>],</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> deleteDog</span><span>(</span><span>int</span><span> id</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Get a reference to the database.</span><span>
    </span><span>final</span><span> db </span><span>=</span><span> </span><span>await</span><span> database</span><span>;</span><span>

    </span><span>// Remove the Dog from the database.</span><span>
    </span><span>await</span><span> db</span><span>.</span><span>delete</span><span>(</span><span>
      </span><span>'dogs'</span><span>,</span><span>
      </span><span>// Use a `where` clause to delete a specific dog.</span><span>
      where</span><span>:</span><span> </span><span>'id = ?'</span><span>,</span><span>
      </span><span>// Pass the Dog's id as a whereArg to prevent SQL injection.</span><span>
      whereArgs</span><span>:</span><span> </span><span>[</span><span>id</span><span>],</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>// Create a Dog and add it to the dogs table</span><span>
  </span><span>var</span><span> fido </span><span>=</span><span> </span><span>const</span><span> </span><span>Dog</span><span>(</span><span>
    id</span><span>:</span><span> </span><span>0</span><span>,</span><span>
    name</span><span>:</span><span> </span><span>'Fido'</span><span>,</span><span>
    age</span><span>:</span><span> </span><span>35</span><span>,</span><span>
  </span><span>);</span><span>

  </span><span>await</span><span> insertDog</span><span>(</span><span>fido</span><span>);</span><span>

  </span><span>// Now, use the method above to retrieve all the dogs.</span><span>
  print</span><span>(</span><span>await</span><span> dogs</span><span>());</span><span> </span><span>// Prints a list that include Fido.</span><span>

  </span><span>// Update Fido's age and save it to the database.</span><span>
  fido </span><span>=</span><span> </span><span>Dog</span><span>(</span><span>
    id</span><span>:</span><span> fido</span><span>.</span><span>id</span><span>,</span><span>
    name</span><span>:</span><span> fido</span><span>.</span><span>name</span><span>,</span><span>
    age</span><span>:</span><span> fido</span><span>.</span><span>age </span><span>+</span><span> </span><span>7</span><span>,</span><span>
  </span><span>);</span><span>
  </span><span>await</span><span> updateDog</span><span>(</span><span>fido</span><span>);</span><span>

  </span><span>// Print the updated results.</span><span>
  print</span><span>(</span><span>await</span><span> dogs</span><span>());</span><span> </span><span>// Prints Fido with age 42.</span><span>

  </span><span>// Delete Fido from the database.</span><span>
  </span><span>await</span><span> deleteDog</span><span>(</span><span>fido</span><span>.</span><span>id</span><span>);</span><span>

  </span><span>// Print the list of dogs (empty).</span><span>
  print</span><span>(</span><span>await</span><span> dogs</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>Dog</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>int</span><span> id</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> name</span><span>;</span><span>
  </span><span>final</span><span> </span><span>int</span><span> age</span><span>;</span><span>

  </span><span>const</span><span> </span><span>Dog</span><span>({</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>id</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>name</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>age</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>// Convert a Dog into a Map. The keys must correspond to the names of the</span><span>
  </span><span>// columns in the database.</span><span>
  </span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;</span><span> toMap</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>{</span><span>
      </span><span>'id'</span><span>:</span><span> id</span><span>,</span><span>
      </span><span>'name'</span><span>:</span><span> name</span><span>,</span><span>
      </span><span>'age'</span><span>:</span><span> age</span><span>,</span><span>
    </span><span>};</span><span>
  </span><span>}</span><span>

  </span><span>// Implement toString to make it easier to see information about</span><span>
  </span><span>// each dog when using the print statement.</span><span>
  @override
  </span><span>String</span><span> toString</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>'Dog{id: $id, name: $name, age: $age}'</span><span>;</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```