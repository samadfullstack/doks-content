## Create a grid list

In some cases, you might want to display your items as a grid rather than a normal list of items that come one after the next. For this task, use the GridView widget.

The simplest way to get started using grids is by using the GridView.count() constructor, because it allows you to specify how many rows or columns you’d like.

To visualize how GridView works, generate a list of 100 widgets that display their index in the list.

```
GridView.count(
  // Create a grid with 2 columns. If you change the scrollDirection to
  // horizontal, this produces 2 rows.
  crossAxisCount: 2,
  // Generate 100 widgets that display their index in the List.
  children: List.generate(100, (index) {
    return Center(
      child: Text(
        'Item $index',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }),
),
```