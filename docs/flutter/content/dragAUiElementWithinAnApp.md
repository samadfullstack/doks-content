1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Effects](https://docs.flutter.dev/cookbook/effects)
3.  [Drag a UI element](https://docs.flutter.dev/cookbook/effects/drag-a-widget)

Drag and drop is a common mobile app interaction. As the user long presses (sometimes called _touch & hold_) on a widget, another widget appears beneath the user’s finger, and the user drags the widget to a final location and releases it. In this recipe, you’ll build a drag-and-drop interaction where the user long presses on a choice of food, and then drags that food to the picture of the customer who is paying for it.

The following animation shows the app’s behavior:

![Ordering the food by dragging it to the person](https://docs.flutter.dev/assets/images/docs/cookbook/effects/DragAUIElement.gif)

This recipe begins with a prebuilt list of menu items and a row of customers. The first step is to recognize a long press and display a draggable photo of a menu item.

## Press and drag

Flutter provides a widget called [`LongPressDraggable`](https://api.flutter.dev/flutter/widgets/LongPressDraggable-class.html) that provides the exact behavior that you need to begin a drag-and-drop interaction. A `LongPressDraggable` widget recognizes when a long press occurs and then displays a new widget near the user’s finger. As the user drags, the widget follows the user’s finger. `LongPressDraggable` gives you full control over the widget that the user drags.

Each menu list item is displayed with a custom `MenuListItem` widget.

```
<span>MenuListItem</span><span>(</span><span>
  name</span><span>:</span><span> item</span><span>.</span><span>name</span><span>,</span><span>
  price</span><span>:</span><span> item</span><span>.</span><span>formattedTotalItemPrice</span><span>,</span><span>
  photoProvider</span><span>:</span><span> item</span><span>.</span><span>imageProvider</span><span>,</span><span>
</span><span>)</span>
```

Wrap the `MenuListItem` widget with a `LongPressDraggable` widget.

```
<span>LongPressDraggable</span><span>&lt;</span><span>Item</span><span>&gt;(</span><span>
  data</span><span>:</span><span> item</span><span>,</span><span>
  dragAnchorStrategy</span><span>:</span><span> pointerDragAnchorStrategy</span><span>,</span><span>
  feedback</span><span>:</span><span> </span><span>DraggingListItem</span><span>(</span><span>
    dragKey</span><span>:</span><span> _draggableKey</span><span>,</span><span>
    photoProvider</span><span>:</span><span> item</span><span>.</span><span>imageProvider</span><span>,</span><span>
  </span><span>),</span><span>
  child</span><span>:</span><span> </span><span>MenuListItem</span><span>(</span><span>
    name</span><span>:</span><span> item</span><span>.</span><span>name</span><span>,</span><span>
    price</span><span>:</span><span> item</span><span>.</span><span>formattedTotalItemPrice</span><span>,</span><span>
    photoProvider</span><span>:</span><span> item</span><span>.</span><span>imageProvider</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

In this case, when the user long presses on the `MenuListItem` widget, the `LongPressDraggable` widget displays a `DraggingListItem`. This `DraggingListItem` displays a photo of the selected food item, centered beneath the user’s finger.

The `dragAnchorStrategy` property is set to [`pointerDragAnchorStrategy`](https://api.flutter.dev/flutter/widgets/pointerDragAnchorStrategy.html). This property value instructs `LongPressDraggable` to base the `DraggableListItem`’s position on the user’s finger. As the user moves a finger, the `DraggableListItem` moves with it.

Dragging and dropping is of little use if no information is transmitted when the item is dropped. For this reason, `LongPressDraggable` takes a `data` parameter. In this case, the type of `data` is `Item`, which holds information about the food menu item that the user pressed on.

The `data` associated with a `LongPressDraggable` is sent to a special widget called `DragTarget`, where the user releases the drag gesture. You’ll implement the drop behavior next.

## Drop the draggable

The user can drop a `LongPressDraggable` wherever they choose, but dropping the draggable has no effect unless it’s dropped on top of a `DragTarget`. When the user drops a draggable on top of a `DragTarget` widget, the `DragTarget` widget can either accept or reject the data from the draggable.

In this recipe, the user should drop a menu item on a `CustomerCart` widget to add the menu item to the user’s cart.

```
<span>CustomerCart</span><span>(</span><span>
  hasItems</span><span>:</span><span> customer</span><span>.</span><span>items</span><span>.</span><span>isNotEmpty</span><span>,</span><span>
  highlighted</span><span>:</span><span> candidateItems</span><span>.</span><span>isNotEmpty</span><span>,</span><span>
  customer</span><span>:</span><span> customer</span><span>,</span><span>
</span><span>);</span>
```

Wrap the `CustomerCart` widget with a `DragTarget` widget.

```
<span>DragTarget</span><span>&lt;</span><span>Item</span><span>&gt;(</span><span>
  builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> candidateItems</span><span>,</span><span> rejectedItems</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>CustomerCart</span><span>(</span><span>
      hasItems</span><span>:</span><span> customer</span><span>.</span><span>items</span><span>.</span><span>isNotEmpty</span><span>,</span><span>
      highlighted</span><span>:</span><span> candidateItems</span><span>.</span><span>isNotEmpty</span><span>,</span><span>
      customer</span><span>:</span><span> customer</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>},</span><span>
  onAccept</span><span>:</span><span> </span><span>(</span><span>item</span><span>)</span><span> </span><span>{</span><span>
    _itemDroppedOnCustomerCart</span><span>(</span><span>
      item</span><span>:</span><span> item</span><span>,</span><span>
      customer</span><span>:</span><span> customer</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>},</span><span>
</span><span>)</span>
```

The `DragTarget` displays your existing widget and also coordinates with `LongPressDraggable` to recognize when the user drags a draggable on top of the `DragTarget`. The `DragTarget` also recognizes when the user drops a draggable on top of the `DragTarget` widget.

When the user drags a draggable on the `DragTarget` widget, `candidateItems` contains the data items that the user is dragging. This draggable allows you to change what your widget looks like when the user is dragging over it. In this case, the `Customer` widget turns red whenever any items are dragged above the `DragTarget` widget. The red visual appearance is configured with the `highlighted` property within the `CustomerCart` widget.

When the user drops a draggable on the `DragTarget` widget, the `onAccept` callback is invoked. This is when you get to decide whether or not to accept the data that was dropped. In this case, the item is always accepted and processed. You might choose to inspect the incoming item to make a different decision.

Notice that the type of item dropped on `DragTarget` must match the type of the item dragged from `LongPressDraggable`. If the types are not compatible, then the `onAccept` method isn’t invoked.

With a `DragTarget` widget configured to accept your desired data, you can now transmit data from one part of your UI to another by dragging and dropping.

In the next step, you update the customer’s cart with the dropped menu item.

Each customer is represented by a `Customer` object, which maintains a cart of items and a price total.

```
<span>class</span><span> </span><span>Customer</span><span> </span><span>{</span><span>
  </span><span>Customer</span><span>({</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>name</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>imageProvider</span><span>,</span><span>
    </span><span>List</span><span>&lt;</span><span>Item</span><span>&gt;?</span><span> items</span><span>,</span><span>
  </span><span>})</span><span> </span><span>:</span><span> items </span><span>=</span><span> items </span><span>??</span><span> </span><span>[];</span><span>

  </span><span>final</span><span> </span><span>String</span><span> name</span><span>;</span><span>
  </span><span>final</span><span> </span><span>ImageProvider</span><span> imageProvider</span><span>;</span><span>
  </span><span>final</span><span> </span><span>List</span><span>&lt;</span><span>Item</span><span>&gt;</span><span> items</span><span>;</span><span>

  </span><span>String</span><span> </span><span>get</span><span> formattedTotalItemPrice </span><span>{</span><span>
    </span><span>final</span><span> totalPriceCents </span><span>=</span><span>
        items</span><span>.</span><span>fold</span><span>&lt;</span><span>int</span><span>&gt;(</span><span>0</span><span>,</span><span> </span><span>(</span><span>prev</span><span>,</span><span> item</span><span>)</span><span> </span><span>=&gt;</span><span> prev </span><span>+</span><span> item</span><span>.</span><span>totalPriceCents</span><span>);</span><span>
    </span><span>return</span><span> </span><span>'\$${(totalPriceCents / 100.0).toStringAsFixed(2)}'</span><span>;</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

The `CustomerCart` widget displays the customer’s photo, name, total, and item count based on a `Customer` instance.

To update a customer’s cart when a menu item is dropped, add the dropped item to the associated `Customer` object.

```
<span>void</span><span> _itemDroppedOnCustomerCart</span><span>({</span><span>
  </span><span>required</span><span> </span><span>Item</span><span> item</span><span>,</span><span>
  </span><span>required</span><span> </span><span>Customer</span><span> customer</span><span>,</span><span>
</span><span>})</span><span> </span><span>{</span><span>
  setState</span><span>(()</span><span> </span><span>{</span><span>
    customer</span><span>.</span><span>items</span><span>.</span><span>add</span><span>(</span><span>item</span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

The `_itemDroppedOnCustomerCart` method is invoked in `onAccept()` when the user drops a menu item on a `CustomerCart` widget. By adding the dropped item to the `customer` object, and invoking `setState()` to cause a layout update, the UI refreshes with the new customer’s price total and item count.

Congratulations! You have a drag-and-drop interaction that adds food items to a customer’s shopping cart.

## Interactive example

Run the app:

-   Scroll through the food items.
-   Press and hold on one with your finger or click and hold with the mouse.
-   While holding, the food item’s image will appear above the list.
-   Drag the image and drop it on one of the people at the bottom of the screen. The text under the image updates to reflect the charge for that person. You can continue to add food items and watch the charges accumulate.