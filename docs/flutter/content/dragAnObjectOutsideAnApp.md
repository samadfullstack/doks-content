1.  [UI](https://docs.flutter.dev/ui)
2.  [Interactivity](https://docs.flutter.dev/ui/interactivity)
3.  [Gestures](https://docs.flutter.dev/ui/interactivity/gestures)
4.  [Drag outside an app](https://docs.flutter.dev/ui/interactivity/gestures/drag-outside)

You might want to implement drag and drop somewhere in your app.

You have a couple potential approaches that you can take. One directly uses Flutter widgets and the other uses a package ([super\_drag\_and\_drop](https://pub.dev/packages/super_drag_and_drop)), available on [pub.dev](https://pub.dev/).

If you want to implement drag and drop within your application, you can use the [`Draggable`](https://api.flutter.dev/flutter/widgets/Draggable-class.html) widget. For insight into this approach, see the [Drag a UI element within an app](https://docs.flutter.dev/cookbook/effects/drag-a-widget) recipe.

An advantage of using `Draggable` and and `DragTarget` is that you can supply Dart code to decide whether to accept a drop.

For more information, check out the [`Draggable` widget of the week](https://youtu.be/q4x2G_9-Mu0?si=T4679e90U2yrloCs) video.

## Implement drag and drop between apps

If you want to implement drag and drop within your application and _also_ between your application and another (possibly non-Flutter) app, check out the [super\_drag\_and\_drop](https://pub.dev/packages/super_drag_and_drop) package.

To avoid implementing two styles of drag and drop, one for drags outside of the app and another for dragging inside the app, you can supply [local data](https://pub.dev/documentation/super_drag_and_drop/latest/super_drag_and_drop/DragItem/localData.html) to the package to perform drags within your app.

Another difference between this approach and using `Draggable` directly, is that you must tell the package up front what data your app accepts because the platform APIs need a synchronous response, which doesn’t allow an asynchronous response from the framework.

An advantage of using this approach is that it works across desktop, mobile, _and_ web.