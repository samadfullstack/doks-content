1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [Web](https://docs.flutter.dev/platform-integration/web)
3.  [Web renderers](https://docs.flutter.dev/platform-integration/web/renderers)

When running and building apps for the web, you can choose between two different renderers. This page describes both renderers and how to choose the best one for your needs. The two renderers are:

**HTML renderer**

This renderer, which has a smaller download size than the CanvasKit renderer, uses a combination of HTML elements, CSS, Canvas elements, and SVG elements.

**CanvasKit renderer**

This renderer is fully consistent with Flutter mobile and desktop, has faster performance with higher widget density, but adds about 1.5MB in download size. [CanvasKit](https://skia.org/docs/user/modules/canvaskit/) uses WebGL to render Skia paint commands.

## Command line options

The `--web-renderer` command line option takes one of three values, `auto`, `html`, or `canvaskit`.

-   `auto` (default) - automatically chooses which renderer to use. This option chooses the HTML renderer when the app is running in a mobile browser, and CanvasKit renderer when the app is running in a desktop browser.
-   `html` - always use the HTML renderer
-   `canvaskit` - always use the CanvasKit renderer

This flag can be used with the `run` or `build` subcommands. For example:

```
<span>flutter run -d chrome --web-renderer html
</span>
```

```
<span>flutter build web --web-renderer canvaskit
</span>
```

This flag is ignored when a non-browser (mobile or desktop) device target is selected.

## Runtime configuration

To override the web renderer at runtime:

-   Build the app with the `auto` option.
-   Prepare a configuration object with the `renderer` property set to `"canvaskit"` or `"html"`.
-   Pass that object to the `engineInitializer.initializeEngine(configuration);` method in the [Flutter Web app initialization](https://docs.flutter.dev/platform-integration/web/initialization) script.

```
<span>&lt;body&gt;</span>
  <span>&lt;script&gt;</span>
    <span>let</span> <span>useHtml</span> <span>=</span> <span>true</span><span>;</span>

    <span>window</span><span>.</span><span>addEventListener</span><span>(</span><span>'</span><span>load</span><span>'</span><span>,</span> <span>function</span><span>(</span><span>ev</span><span>)</span> <span>{</span>
    <span>_flutter</span><span>.</span><span>loader</span><span>.</span><span>loadEntrypoint</span><span>({</span>
      <span>serviceWorker</span><span>:</span> <span>{</span>
        <span>serviceWorkerVersion</span><span>:</span> <span>serviceWorkerVersion</span><span>,</span>
      <span>},</span>
      <span>onEntrypointLoaded</span><span>:</span> <span>function</span><span>(</span><span>engineInitializer</span><span>)</span> <span>{</span>
        <span>let</span> <span>config</span> <span>=</span> <span>{</span>
          <span>renderer</span><span>:</span> <span>useHtml</span> <span>?</span> <span>"</span><span>html</span><span>"</span> <span>:</span> <span>"</span><span>canvaskit</span><span>"</span><span>,</span>
        <span>};</span>
        <span>engineInitializer</span><span>.</span><span>initializeEngine</span><span>(</span><span>config</span><span>).</span><span>then</span><span>(</span><span>function</span><span>(</span><span>appRunner</span><span>)</span> <span>{</span>
          <span>appRunner</span><span>.</span><span>runApp</span><span>();</span>
        <span>});</span>
      <span>}</span>
    <span>});</span>
  <span>});</span>
  <span>&lt;/script&gt;</span>
<span>&lt;/body&gt;</span>
```

The web renderer can’t be changed after the Flutter engine startup process begins in `main.dart.js`.

## Choosing which option to use

Choose the `auto` option (default) if you are optimizing for download size on mobile browsers and optimizing for performance on desktop browsers.

Choose the `html` option if you are optimizing download size over performance on both desktop and mobile browsers.

Choose the `canvaskit` option if you are prioritizing performance and pixel-perfect consistency on both desktop and mobile browsers.

## Examples

Run in Chrome using the default renderer option (`auto`):

Build your app in release mode, using the default (auto) option:

```
flutter build web --release
```

Build your app in release mode, using just the CanvasKit renderer:

```
flutter build web --web-renderer canvaskit --release
```

Run your app in profile mode using the HTML renderer:

```
flutter run -d chrome --web-renderer html --profile
```