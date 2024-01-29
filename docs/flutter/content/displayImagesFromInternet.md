1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Images](https://docs.flutter.dev/cookbook/images)
3.  [Display images from the internet](https://docs.flutter.dev/cookbook/images/network-image)

Displaying images is fundamental for most mobile apps. Flutter provides the [`Image`](https://api.flutter.dev/flutter/widgets/Image-class.html) widget to display different types of images.

To work with images from a URL, use the [`Image.network()`](https://api.flutter.dev/flutter/widgets/Image/Image.network.html) constructor.

```
<span>Image</span><span>.</span><span>network</span><span>(</span><span>'https://picsum.photos/250?image=9'</span><span>),</span>
```

## Bonus: animated gifs

One useful thing about the `Image` widget: It supports animated gifs.

```
<span>Image</span><span>.</span><span>network</span><span>(</span><span>
    </span><span>'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'</span><span>);</span>
```

## Placeholders and caching

The default `Image.network` constructor doesn’t handle more advanced functionality, such as fading images in after loading, or caching images to the device after they’re downloaded. To accomplish these tasks, see the following recipes:

-   [Fade in images with a placeholder](https://docs.flutter.dev/cookbook/images/fading-in-images)
-   [Work with cached images](https://docs.flutter.dev/cookbook/images/cached-images)

## Interactive example