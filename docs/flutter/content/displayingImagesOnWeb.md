1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [Web](https://docs.flutter.dev/platform-integration/web)
3.  [Web images](https://docs.flutter.dev/platform-integration/web/web-images)

The web supports the standard [`Image`](https://api.flutter.dev/flutter/widgets/Image-class.html) widget to display images. However, because web browsers are built to run untrusted code safely, there are certain limitations in what you can do with images compared to mobile and desktop platforms. This page explains these limitations and offers ways to work around them.

## Background

This section summarizes the technologies available across Flutter and the web, on which the solutions below are based on.

## Images in Flutter

Flutter offers the [`Image`](https://api.flutter.dev/flutter/widgets/Image-class.html) widget as well as the low-level [`dart:ui/Image`](https://api.flutter.dev/flutter/dart-ui/Image-class.html) class for rendering images. The `Image` widget has enough functionality for most use-cases. The `dart:ui/Image` class can be used in advanced situations where fine-grained control of the image is needed.

## Images on the web

The web offers several methods for displaying images. Below are some of the common ones:

-   The built-in [`<img>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/img) and [`<picture>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/picture) HTML elements.
-   The [`drawImage`](https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/drawImage) method on the [`<canvas>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/canvas) element.
-   Custom image codec that renders to a WebGL canvas.

Each option has its own benefits and drawbacks. For example, the built-in elements fit nicely among other HTML elements, and they automatically take advantage of browser caching, and built-in image optimization and memory management. They allow you to safely display images from arbitrary sources (more on than in the CORS section below). `drawImage` is great when the image must fit within other content rendered using the `<canvas>` element. You also gain control over image sizing and, when the CORS policy allows it, read the pixels of the image back for further processing. Finally, WebGL gives you the highest degree of control over the image. Not only can you read the pixels and apply custom image algorithms, but you can also use GLSL for hardware-acceleration.

## Cross-Origin Resource Sharing (CORS)

[CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) is a mechanism that browsers use to control how one site accesses the resources of another site. It is designed such that, by default, one web-site is not allowed to make HTTP requests to another site using [XHR](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest) or [`fetch`](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch). This prevents scripts on another site from acting on behalf of the user and from gaining access to another site’s resources without permission.

When using `<img>`, `<picture>`, or `<canvas>`, the browser automatically blocks access to pixels when it knows that an image is coming from another site and the CORS policy disallows access to data.

WebGL requires access to the image data in order to be able to render the image. Therefore, images to be rendered using WebGL must only come from servers that have a CORS policy configured to work with the domain that serves your application.

## Flutter renderers on the web

Flutter offers a choice of two renderers on the web:

-   **HTML**: this renderer uses a combination of HTML, CSS, Canvas 2D, and SVG to render UI. It uses the `<img>` element to render images.
-   **CanvasKit**: this renderer uses WebGL to render UI, and therefore requires access to the pixels of the image.

Because the HTML renderer uses the `<img>` element it can display images from arbitrary sources. However, this places the following limitations on what you can do with them:

-   Limited support for [`Image.toByteData`](https://api.flutter.dev/flutter/dart-ui/Image/toByteData.html).
-   No support for [`OffsetLayer.toImage`](https://api.flutter.dev/flutter/rendering/OffsetLayer/toImage.html) and [`Scene.toImage`](https://api.flutter.dev/flutter/dart-ui/Scene/toImage.html).
-   No access to frame data in animated images ([`Codec.getNextFrame`](https://api.flutter.dev/flutter/dart-ui/Codec/getNextFrame.html), `frameCount` is always 1, `repetitionCount` is always 0).
-   No support for `ImageShader`.
-   Limited support for shader effects that can be applied to images.
-   No control over image memory (`Image.dispose` has no effect). The memory is managed by the browser behind-the-scenes.

The CanvasKit renderer implements Flutter’s image API fully. However, it requires access to image pixels to do so, and is therefore subject to the CORS policy.

## Solutions

## In-memory, asset, and same-origin network images

If the app has the bytes of the encoded image in memory, provided as an [asset](https://docs.flutter.dev/ui/assets/assets-and-images), or stored on the same server that serves the application (also known as _same-origin_), no extra effort is necessary. The image can be displayed using [`Image.memory`](https://api.flutter.dev/flutter/widgets/Image/Image.memory.html), [`Image.asset`](https://api.flutter.dev/flutter/widgets/Image/Image.asset.html), and [`Image.network`](https://api.flutter.dev/flutter/widgets/Image/Image.network.html) in both HTML and CanvasKit modes.

## Cross-origin images

The HTML renderer can load cross-origin images without extra configuration.

CanvasKit requires that the app gets the bytes of the encoded image. There are several ways to do this, discussed below.

### Host your images in a CORS-enabled CDN.

Typically, content delivery networks (CDN) can be configured to customize what domains are allowed to access your content. For example, Firebase site hosting allows [specifying a custom](https://firebase.google.com/docs/hosting/full-config#headers) `Access-Control-Allow-Origin` header in the `firebase.json` file.

### Lack control over the image server? Use a CORS proxy.

If the image server cannot be configured to allow CORS requests from your application, you might still be able to load images by proxying the requests through another server. This requires that the intermediate server has sufficient access to load the images.

This method can be used in situations when the original image server serves images publicly, but is not configured with the correct CORS headers.

Examples:

-   Using [CloudFlare Workers](https://developers.cloudflare.com/workers/examples/cors-header-proxy).
-   Using [Firebase Functions](https://github.com/7kfpun/cors-proxy).

### Use `<img>` in a platform view.

Flutter supports embedding HTML inside the app using [`HtmlElementView`](https://api.flutter.dev/flutter/widgets/HtmlElementView-class.html). Use it to create an `<img>` element to render the image from another domain. However, do keep in mind that this comes with the limitations explained in the section “Flutter renderers on the web” above.

[As of today](https://github.com/flutter/flutter/issues/71884), using too many HTML elements with the CanvasKit renderer might hurt performance. If images interleave non-image content Flutter needs to create extra WebGL contexts between the `<img>` elements. If your application needs to display a lot of images on the same screen all at once, consider using the HTML renderer instead of CanvasKit.