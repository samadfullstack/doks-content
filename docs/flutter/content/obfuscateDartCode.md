1.  [Deployment](https://docs.flutter.dev/deployment)
2.  [Obfuscate Dart code](https://docs.flutter.dev/deployment/obfuscate)

## What is code obfuscation?

[Code obfuscation](https://en.wikipedia.org/wiki/Obfuscation_(software)) is the process of modifying an app’s binary to make it harder for humans to understand. Obfuscation hides function and class names in your compiled Dart code, replacing each symbol with another symbol, making it difficult for an attacker to reverse engineer your proprietary app.

**Flutter’s code obfuscation works only on a [release build](https://docs.flutter.dev/testing/build-modes#release).**

## Limitations

Note that obfuscating your code does _not_ encrypt resources nor does it protect against reverse engineering. It only renames symbols with more obscure names.

## Supported targets

The following build targets support the obfuscation process described on this page:

-   `aar`
-   `apk`
-   `appbundle`
-   `ios`
-   `ios-framework`
-   `ipa`
-   `linux`
-   `macos`
-   `macos-framework`
-   `windows`

## Obfuscate your app

To obfuscate your app, use the `flutter build` command in release mode with the `--obfuscate` and `--split-debug-info` options. The `--split-debug-info` option specifies the directory where Flutter outputs debug files. In the case of obfuscation, it outputs a symbol map. For example:

```
<span>$</span><span> </span>flutter build apk <span>--obfuscate</span> <span>--split-debug-info</span><span>=</span>/&lt;project-name&gt;/&lt;directory&gt;
```

Once you’ve obfuscated your binary, **save the symbols file**. You need this if you later want to de-obfuscate a stack trace.

For detailed information on these flags, run the help command for your specific target, for example:

If these flags are not listed in the output, run `flutter --version` to check your version of Flutter.

## Read an obfuscated stack trace

To debug a stack trace created by an obfuscated app, use the following steps to make it human readable:

1.  Find the matching symbols file. For example, a crash from an Android arm64 device would need `app.android-arm64.symbols`.
    
2.  Provide both the stack trace (stored in a file) and the symbols file to the `flutter symbolize` command. For example:
    
    ```
    <span>$</span><span> </span>flutter symbolize <span>-i</span> &lt;stack trace file&gt; <span>-d</span> out/android/app.android-arm64.symbols
    ```
    
    For more information on the `symbolize` command, run `flutter symbolize -h`.
    

## Read an obfuscated name

To make the name that an app obfuscated human readable, use the following steps:

1.  To save the name obfuscation map at app build time, use `--extra-gen-snapshot-options=--save-obfuscation-map=/<your-path>`. For example:
    
    ```
    <span>$</span><span> </span>flutter build apk <span>--obfuscate</span> <span>--split-debug-info</span><span>=</span>/&lt;project-name&gt;/&lt;directory&gt; <span>--extra-gen-snapshot-options</span><span>=</span><span>--save-obfuscation-map</span><span>=</span>/&lt;your-path&gt;
    ```
    
2.  To recover the name, use the generated obfuscation map. The obfuscation map is a flat JSON array with pairs of original names and obfuscated names. For example, `["MaterialApp", "ex", "Scaffold", "ey"]`, where `ex` is the obfuscated name of `MaterialApp`.
    

## Caveat

Be aware of the following when coding an app that will eventually be an obfuscated binary.

-   Code that relies on matching specific class, function, or library names will fail. For example, the following call to `expect()` won’t work in an obfuscated binary:

```
<span>expect</span><span>(</span><span>foo</span><span>.</span><span>runtimeType</span><span>.</span><span>toString</span><span>(),</span><span> equals</span><span>(</span><span>'Foo'</span><span>));</span>
```

-   Enum names are not obfuscated currently.