1.  [UI](https://docs.flutter.dev/ui)
2.  [Design & theming](https://docs.flutter.dev/ui/design)
3.  [Drawing & graphics](https://docs.flutter.dev/ui/design/graphics)
4.  [Fragment shaders](https://docs.flutter.dev/ui/design/graphics/fragment-shaders)

Custom shaders can be used to provide rich graphical effects beyond those provided by the Flutter SDK. A shader is a program authored in a small, Dart-like language, known as GLSL, and executed on the user’s GPU.

Custom shaders are added to a Flutter project by listing them in the `pubspec.yaml` file, and obtained using the [`FragmentProgram`](https://api.flutter.dev/flutter/dart-ui/FragmentProgram-class.html) API.

## Adding shaders to an application

Shaders, in the form of GLSL files with the `.frag` extension, must be declared in the `shaders` section of your project’s `pubspec.yaml` file. The Flutter command-line tool compiles the shader to its appropriate backend format, and generates its necessary runtime metadata. The compiled shader is then included in the application just like an asset.

```
<span>flutter</span><span>:</span>
  <span>shaders</span><span>:</span>
    <span>-</span> <span>shaders/myshader.frag</span>
```

When running in debug mode, changes to a shader program trigger recompilation and update the shader during hot reload or hot restart.

Shaders from packages are added to a project with `packages/$pkgname` prefixed to the shader program’s name (where `$pkgname` is the name of the package).

### Loading shaders at runtime

To load a shader into a `FragmentProgram` object at runtime, use the [`FragmentProgram.fromAsset`](https://api.flutter.dev/flutter/dart-ui/FragmentProgram/fromAsset.html) constructor. The asset’s name is the same as the path to the shader given in the `pubspec.yaml` file.

```
<span>void</span> <span>loadMyShader</span><span>()</span> <span>async</span> <span>{</span>
  <span>var</span> <span>program</span> <span>=</span> <span>await</span> <span>FragmentProgram</span><span>.</span><span>fromAsset</span><span>(</span><span>'shaders/myshader.frag'</span><span>);</span>
<span>}</span>
```

The `FragmentProgram` object can be used to create one or more [`FragmentShader`](https://api.flutter.dev/flutter/dart-ui/FragmentShader-class.html) instances. A `FragmentShader` object represents a fragment program along with a particular set of _uniforms_ (configuration parameters). The available uniforms depends on how the shader was defined.

```
<span>void</span> <span>updateShader</span><span>(</span><span>Canvas</span> <span>canvas</span><span>,</span> <span>Rect</span> <span>rect</span><span>,</span> <span>FragmentProgram</span> <span>program</span><span>)</span> <span>{</span>
  <span>var</span> <span>shader</span> <span>=</span> <span>program</span><span>.</span><span>fragmentShader</span><span>();</span>
  <span>shader</span><span>.</span><span>setFloat</span><span>(</span><span>0</span><span>,</span> <span>42.0</span><span>);</span>
  <span>canvas</span><span>.</span><span>drawRect</span><span>(</span><span>rect</span><span>,</span> <span>Paint</span><span>().</span><span>.</span><span>shader</span> <span>=</span> <span>shader</span><span>);</span>
<span>}</span>
```

### Canvas API

Fragment shaders can be used with most Canvas APIs by setting [`Paint.shader`](https://api.flutter.dev/flutter/dart-ui/Paint/shader.html). For example, when using [`Canvas.drawRect`](https://api.flutter.dev/flutter/dart-ui/Canvas/drawRect.html) the shader is evaluated for all fragments within the rectangle. For an API like [`Canvas.drawPath`](https://api.flutter.dev/flutter/dart-ui/Canvas/drawPath.html) with a stroked path, the shader is evaluated for all fragments within the stroked line. Some APIs, such as [`Canvas.drawImage`](https://api.flutter.dev/flutter/dart-ui/Canvas/drawImage.html), ignore the value of the shader.

```
<span>void</span> <span>paint</span><span>(</span><span>Canvas</span> <span>canvas</span><span>,</span> <span>Size</span> <span>size</span><span>,</span> <span>FragmentShader</span> <span>shader</span><span>)</span> <span>{</span>
  <span>// Draws a rectangle with the shader used as a color source.</span>
  <span>canvas</span><span>.</span><span>drawRect</span><span>(</span>
    <span>Rect</span><span>.</span><span>fromLTWH</span><span>(</span><span>0</span><span>,</span> <span>0</span><span>,</span> <span>size</span><span>.</span><span>width</span><span>,</span> <span>size</span><span>.</span><span>height</span><span>),</span>
    <span>Paint</span><span>().</span><span>.</span><span>shader</span> <span>=</span> <span>shader</span><span>,</span>
  <span>);</span>

  <span>// Draws a stroked rectangle with the shader only applied to the fragments</span>
  <span>// that lie within the stroke.</span>
  <span>canvas</span><span>.</span><span>drawRect</span><span>(</span>
    <span>Rect</span><span>.</span><span>fromLTWH</span><span>(</span><span>0</span><span>,</span> <span>0</span><span>,</span> <span>size</span><span>.</span><span>width</span><span>,</span> <span>size</span><span>.</span><span>height</span><span>),</span>
    <span>Paint</span><span>()</span>
      <span>.</span><span>.</span><span>style</span> <span>=</span> <span>PaintingStyle</span><span>.</span><span>stroke</span>
      <span>.</span><span>.</span><span>shader</span> <span>=</span> <span>shader</span><span>,</span>
  <span>)</span>
<span>}</span>

```

Fragment shaders are authored as GLSL source files. By convention, these files have the `.frag` extension. (Flutter doesn’t support vertex shaders, which would have the `.vert` extension.)

Any GLSL version from 460 down to 100 is supported, though some available features are restricted. The rest of the examples in this document use version `460 core`.

Shaders are subject to the following limitations when used with Flutter:

-   UBOs and SSBOs aren’t supported
-   `sampler2D` is the only supported sampler type
-   Only the two-argument version of `texture` (sampler and uv) is supported
-   No additional varying inputs can be declared
-   All precision hints are ignored when targeting Skia
-   Unsigned integers and booleans aren’t supported

### Uniforms

A fragment program can be configured by defining `uniform` values in the GLSL shader source and then setting these values in Dart for each fragment shader instance.

Floating point uniforms with the GLSL types `float`, `vec2`, `vec3`, and `vec4` are set using the [`FragmentShader.setFloat`](https://api.flutter.dev/flutter/dart-ui/FragmentShader/setFloat.html) method. GLSL sampler values, which use the `sampler2D` type, are set using the [`FragmentShader.setImageSampler`](https://api.flutter.dev/flutter/dart-ui/FragmentShader/setImageSampler.html) method.

The correct index for each `uniform` value is determined by the order that the uniform values are defined in the fragment program. For data types composed of multiple floats, such as a `vec4`, you must call [`FragmentShader.setFloat`](https://api.flutter.dev/flutter/dart-ui/FragmentShader/setFloat.html) once for each value.

For example, given the following uniforms declarations in a GLSL fragment program:

```
<span>uniform</span> <span>float</span> <span>uScale</span><span>;</span>
<span>uniform</span> <span>sampler2D</span> <span>uTexture</span><span>;</span>
<span>uniform</span> <span>vec2</span> <span>uMagnitude</span><span>;</span>
<span>uniform</span> <span>vec4</span> <span>uColor</span><span>;</span>
```

The corresponding Dart code to initialize these `uniform` values is as follows:

```
<span>void</span> <span>updateShader</span><span>(</span><span>FragmentShader</span> <span>shader</span><span>,</span> <span>Color</span> <span>color</span><span>,</span> <span>Image</span> <span>image</span><span>)</span> <span>{</span>
  <span>shader</span><span>.</span><span>setFloat</span><span>(</span><span>0</span><span>,</span> <span>23</span><span>);</span>  <span>// uScale</span>
  <span>shader</span><span>.</span><span>setFloat</span><span>(</span><span>1</span><span>,</span> <span>114</span><span>);</span> <span>// uMagnitude x</span>
  <span>shader</span><span>.</span><span>setFloat</span><span>(</span><span>2</span><span>,</span> <span>83</span><span>);</span>  <span>// uMagnitude y</span>

  <span>// Convert color to premultiplied opacity.</span>
  <span>shader</span><span>.</span><span>setFloat</span><span>(</span><span>3</span><span>,</span> <span>color</span><span>.</span><span>red</span> <span>/</span> <span>255</span> <span>*</span> <span>color</span><span>.</span><span>opacity</span><span>);</span>   <span>// uColor r</span>
  <span>shader</span><span>.</span><span>setFloat</span><span>(</span><span>4</span><span>,</span> <span>color</span><span>.</span><span>green</span> <span>/</span> <span>255</span> <span>*</span> <span>color</span><span>.</span><span>opacity</span><span>);</span> <span>// uColor g</span>
  <span>shader</span><span>.</span><span>setFloat</span><span>(</span><span>5</span><span>,</span> <span>color</span><span>.</span><span>blue</span> <span>/</span> <span>255</span> <span>*</span> <span>color</span><span>.</span><span>opacity</span><span>);</span>  <span>// uColor b</span>
  <span>shader</span><span>.</span><span>setFloat</span><span>(</span><span>6</span><span>,</span> <span>color</span><span>.</span><span>opacity</span><span>);</span>                     <span>// uColor a</span>

  <span>// Initialize sampler uniform.</span>
  <span>shader</span><span>.</span><span>setImageSampler</span><span>(</span><span>0</span><span>,</span> <span>image</span><span>);</span>
 <span>}</span>
```

Observe that the indices used with [`FragmentShader.setFloat`](https://api.flutter.dev/flutter/dart-ui/FragmentShader/setFloat.html) do not count the `sampler2D` uniform. This uniform is set separately with [`FragmentShader.setImageSampler`](https://api.flutter.dev/flutter/dart-ui/FragmentShader/setImageSampler.html), with the index starting over at 0.

Any float uniforms that are left uninitialized will default to `0.0`.

#### Current position

The shader has access to a `varying` value that contains the local coordinates for the particular fragment being evaluated. Use this feature to compute effects that depend on the current position, which can be accessed by importing the `flutter/runtime_effect.glsl` library and calling the `FlutterFragCoord` function. For example:

```
<span>#include</span> <span>&lt;flutter/runtime_effect.glsl&gt;</span><span>
</span>
<span>void</span> <span>main</span><span>()</span> <span>{</span>
  <span>vec2</span> <span>currentPos</span> <span>=</span> <span>FlutterFragCoord</span><span>().</span><span>xy</span><span>;</span>
<span>}</span>
```

The value returned from `FlutterFragCoord` is distinct from `gl_FragCoord`. `gl_FragCoord` provides the screen space coordinates and should generally be avoided to ensure that shaders are consistent across backends. When targeting a Skia backend, the calls to `gl_FragCoord` are rewritten to access local coordinates but this rewriting isn’t possible with Impeller.

#### Colors

There isn’t a built-in data type for colors. Instead they are commonly represented as a `vec4` with each component corresponding to one of the RGBA color channels.

The single output `fragColor` expects that the color value is normalized to be in the range of `0.0` to `1.0` and that it has premultiplied alpha. This is different than typical Flutter colors which use a `0-255` value encoding and have unpremultipled alpha.

#### Samplers

A sampler provides access to a `dart:ui` `Image` object. This image can be acquired either from a decoded image or from part of the application using [`Scene.toImageSync`](https://api.flutter.dev/flutter/dart-ui/Scene/toImageSync.html) or [`Picture.toImageSync`](https://api.flutter.dev/flutter/dart-ui/Picture/toImageSync.html).

```
<span>#include</span> <span>&lt;flutter/runtime_effect.glsl&gt;</span><span>
</span>
<span>uniform</span> <span>vec2</span> <span>uSize</span><span>;</span>
<span>uniform</span> <span>sampler2D</span> <span>uTexture</span><span>;</span>

<span>out</span> <span>vec4</span> <span>fragColor</span><span>;</span>

<span>void</span> <span>main</span><span>()</span> <span>{</span>
  <span>vec2</span> <span>uv</span> <span>=</span> <span>FlutterFragCoord</span><span>().</span><span>xy</span> <span>/</span> <span>uSize</span><span>;</span>
  <span>fragColor</span> <span>=</span> <span>texture</span><span>(</span><span>uTexture</span><span>,</span> <span>uv</span><span>);</span>
<span>}</span>
```

By default, the image uses [`TileMode.clamp`](https://api.flutter.dev/flutter/dart-ui/TileMode.html) to determine how values outside of the range of `[0, 1]` behave. Customization of the tile mode is not supported and needs to be emulated in the shader.

### Performance considerations

When targeting the Skia backend, loading the shader might be expensive since it must be compiled to the appropriate platform-specific shader at runtime. If you intend to use one or more shaders during an animation, consider precaching the fragment program objects before starting the animation.

You can reuse a `FragmentShader` object across frames; this is more efficient than creating a new `FragmentShader` for each frame.

For a more detailed guide on writing performant shaders, check out [Writing efficient shaders](https://github.com/flutter/engine/blob/main/impeller/docs/shader_optimization.md) on GitHub.

### Other resources

For more information, here are a few resources.

-   [The Book of Shaders](https://thebookofshaders.com/) by Patricio Gonzalez Vivo and Jen Lowe
-   [Shader toy](https://www.shadertoy.com/), a collaborative shader playground
-   [`simple_shader`](https://github.com/flutter/samples/tree/main/simple_shader), a simple Flutter fragment shaders sample project