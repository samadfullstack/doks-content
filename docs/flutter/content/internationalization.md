1.  [UI](https://docs.flutter.dev/ui)
2.  [a11y & i18n](https://docs.flutter.dev/ui/accessibility-and-internationalization)
3.  [i18n](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization)

If your app might be deployed to users who speak another language then you’ll need to internationalize it. That means you need to write the app in a way that makes it possible to localize values like text and layouts for each language or locale that the app supports. Flutter provides widgets and classes that help with internationalization and the Flutter libraries themselves are internationalized.

This page covers concepts and workflows necessary to localize a Flutter application using the `MaterialApp` and `CupertinoApp` classes, as most apps are written that way. However, applications written using the lower level `WidgetsApp` class can also be internationalized using the same classes and logic.

## Introduction to localizations in Flutter

This section provides a tutorial on how to create and internationalize a new Flutter application, along with any additional setup that a target platform might require.

You can find the source code for this example in [`gen_l10n_example`](https://github.com/flutter/website/tree/main/examples/internationalization/gen_l10n_example).

### Setting up an internationalized app: the Flutter\_localizations package

By default, Flutter only provides US English localizations. To add support for other languages, an application must specify additional `MaterialApp` (or `CupertinoApp`) properties, and include a package called `flutter_localizations`. As of December 2023, this package supports [115 languages](https://api.flutter.dev/flutter/flutter_localizations/GlobalMaterialLocalizations-class.html) and language variants.

To begin, start by creating a new Flutter application in a directory of your choice with the `flutter create` command.

```
<span>$</span><span> </span>flutter create &lt;name_of_flutter_app&gt;
```

To use `flutter_localizations`, add the package as a dependency to your `pubspec.yaml` file, as well as the `intl` package:

```
<span>$</span><span> </span>flutter pub add flutter_localizations <span>--sdk</span><span>=</span>flutter
<span>$</span><span> </span>flutter pub add intl:any
```

This creates a `pubspec.yml` file with the following entries:

```
<span>dependencies:
</span><span>  </span><span>flutter:
</span><span>    </span><span>sdk: </span><span>flutter
  </span><span>flutter_localizations:
</span><span>    </span><span>sdk: </span><span>flutter
  </span><span>intl: </span><span>any</span>
```

Then import the `flutter_localizations` library and specify `localizationsDelegates` and `supportedLocales` for your `MaterialApp` or `CupertinoApp`:

```
<span>import</span><span> </span><span>'package:flutter_localizations/flutter_localizations.dart'</span><span>;</span>
```

```
<span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
  title</span><span>:</span><span> </span><span>'Localizations Sample App'</span><span>,</span><span>
  localizationsDelegates</span><span>:</span><span> </span><span>[</span><span>
    </span><span>GlobalMaterialLocalizations</span><span>.</span><span>delegate</span><span>,</span><span>
    </span><span>GlobalWidgetsLocalizations</span><span>.</span><span>delegate</span><span>,</span><span>
    </span><span>GlobalCupertinoLocalizations</span><span>.</span><span>delegate</span><span>,</span><span>
  </span><span>],</span><span>
  supportedLocales</span><span>:</span><span> </span><span>[</span><span>
    </span><span>Locale</span><span>(</span><span>'en'</span><span>),</span><span> </span><span>// English</span><span>
    </span><span>Locale</span><span>(</span><span>'es'</span><span>),</span><span> </span><span>// Spanish</span><span>
  </span><span>],</span><span>
  home</span><span>:</span><span> </span><span>MyHomePage</span><span>(),</span><span>
</span><span>);</span>
```

After introducing the `flutter_localizations` package and adding the previous code, the `Material` and `Cupertino` packages should now be correctly localized in one of the 115 supported locales. Widgets should be adapted to the localized messages, along with correct left-to-right or right-to-left layout.

Try switching the target platform’s locale to Spanish (`es`) and the messages should be localized.

Apps based on `WidgetsApp` are similar except that the `GlobalMaterialLocalizations.delegate` isn’t needed.

The full `Locale.fromSubtags` constructor is preferred as it supports [`scriptCode`](https://api.flutter.dev/flutter/package-intl_locale/Locale/scriptCode.html), though the `Locale` default constructor is still fully valid.

The elements of the `localizationsDelegates` list are factories that produce collections of localized values. `GlobalMaterialLocalizations.delegate` provides localized strings and other values for the Material Components library. `GlobalWidgetsLocalizations.delegate` defines the default text direction, either left-to-right or right-to-left, for the widgets library.

More information about these app properties, the types they depend on, and how internationalized Flutter apps are typically structured, is covered in this page.

### Overriding the locale

`Localizations.override` is a factory constructor for the `Localizations` widget that allows for (the typically rare) situation where a section of your application needs to be localized to a different locale than the locale configured for your device.

To observe this behavior, add a call to `Localizations.override` and a simple `CalendarDatePicker`:

```
<span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
    appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>widget</span><span>.</span><span>title</span><span>),</span><span>
    </span><span>),</span><span>
    body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
        mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
        children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
          </span><span>// Add the following code</span><span>
          </span><span>Localizations</span><span>.</span><span>override</span><span>(</span><span>
            context</span><span>:</span><span> context</span><span>,</span><span>
            locale</span><span>:</span><span> </span><span>const</span><span> </span><span>Locale</span><span>(</span><span>'es'</span><span>),</span><span>
            </span><span>// Using a Builder to get the correct BuildContext.</span><span>
            </span><span>// Alternatively, you can create a new widget and Localizations.override</span><span>
            </span><span>// will pass the updated BuildContext to the new widget.</span><span>
            child</span><span>:</span><span> </span><span>Builder</span><span>(</span><span>
              builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>{</span><span>
                </span><span>// A toy example for an internationalized Material widget.</span><span>
                </span><span>return</span><span> </span><span>CalendarDatePicker</span><span>(</span><span>
                  initialDate</span><span>:</span><span> </span><span>DateTime</span><span>.</span><span>now</span><span>(),</span><span>
                  firstDate</span><span>:</span><span> </span><span>DateTime</span><span>(</span><span>1900</span><span>),</span><span>
                  lastDate</span><span>:</span><span> </span><span>DateTime</span><span>(</span><span>2100</span><span>),</span><span>
                  onDateChanged</span><span>:</span><span> </span><span>(</span><span>value</span><span>)</span><span> </span><span>{},</span><span>
                </span><span>);</span><span>
              </span><span>},</span><span>
            </span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>],</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

Hot reload the app and the `CalendarDatePicker` widget should re-render in Spanish.

### Adding your own localized messages

After adding the `flutter_localizations` package, you can configure localization. To add localized text to your application, complete the following instructions:

1.  Add the `intl` package as a dependency, pulling in the version pinned by `flutter_localizations`:
    
    ```
    <span>$</span><span> </span>flutter pub add intl:any
    ```
    
2.  Open the `pubspec.yaml` file and enable the `generate` flag. This flag is found in the `flutter` section in the pubspec file.
    
    ```
    <span># The following section is specific to Flutter.</span><span>
    </span><span>flutter:
    </span><span>  </span><span>generate: </span><span>true </span><span># Add this line</span>
    ```
    
3.  Add a new yaml file to the root directory of the Flutter project. Name this file `l10n.yaml` and include following content:
    
    ```
    <span>arb-dir: </span><span>lib/l10n
    </span><span>template-arb-file: </span><span>app_en.arb
    </span><span>output-localization-file: </span><span>app_localizations.dart</span>
    ```
    
    This file configures the localization tool. In this example, you’ve done the following:
    
    -   Put the [App Resource Bundle](https://github.com/google/app-resource-bundle) (`.arb`) input files in `${FLUTTER_PROJECT}/lib/l10n`. The `.arb` provide localization resources for your app.
    -   Set the English template as `app_en.arb`.
    -   Told Flutter to generate localizations in the `app_localizations.dart` file.
4.  In `${FLUTTER_PROJECT}/lib/l10n`, add the `app_en.arb` template file. For example:
    
    ```
    <span>{</span><span>
      </span><span>"helloWorld"</span><span>:</span><span> </span><span>"Hello World!"</span><span>,</span><span>
      </span><span>"@helloWorld"</span><span>:</span><span> </span><span>{</span><span>
        </span><span>"description"</span><span>:</span><span> </span><span>"The conventional newborn programmer greeting"</span><span>
      </span><span>}</span><span>
    </span><span>}</span>
    ```
    
5.  Add another bundle file called `app_es.arb` in the same directory. In this file, add the Spanish translation of the same message.
    
    ```
    <span>{</span><span>
        </span><span>"helloWorld"</span><span>:</span><span> </span><span>"¡Hola Mundo!"</span><span>
    </span><span>}</span>
    ```
    
6.  Now, run `flutter pub get` or `flutter run` and codegen takes place automatically. You should find generated files in `${FLUTTER_PROJECT}/.dart_tool/flutter_gen/gen_l10n`. Alternatively, you can also run `flutter gen-l10n` to generate the same files without running the app.
    
7.  Add the import statement on `app_localizations.dart` and `AppLocalizations.delegate` in your call to the constructor for `MaterialApp`:
    
    ```
    <span>import</span><span> </span><span>'package:flutter_gen/gen_l10n/app_localizations.dart'</span><span>;</span>
    ```
    
    ```
    <span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Localizations Sample App'</span><span>,</span><span>
      localizationsDelegates</span><span>:</span><span> </span><span>[</span><span>
        </span><span>AppLocalizations</span><span>.</span><span>delegate</span><span>,</span><span> </span><span>// Add this line</span><span>
        </span><span>GlobalMaterialLocalizations</span><span>.</span><span>delegate</span><span>,</span><span>
        </span><span>GlobalWidgetsLocalizations</span><span>.</span><span>delegate</span><span>,</span><span>
        </span><span>GlobalCupertinoLocalizations</span><span>.</span><span>delegate</span><span>,</span><span>
      </span><span>],</span><span>
      supportedLocales</span><span>:</span><span> </span><span>[</span><span>
        </span><span>Locale</span><span>(</span><span>'en'</span><span>),</span><span> </span><span>// English</span><span>
        </span><span>Locale</span><span>(</span><span>'es'</span><span>),</span><span> </span><span>// Spanish</span><span>
      </span><span>],</span><span>
      home</span><span>:</span><span> </span><span>MyHomePage</span><span>(),</span><span>
    </span><span>);</span>
    ```
    
    The `AppLocalizations` class also provides auto-generated `localizationsDelegates` and `supportedLocales` lists. You can use these instead of providing them manually.
    
    ```
    <span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Localizations Sample App'</span><span>,</span><span>
      localizationsDelegates</span><span>:</span><span> </span><span>AppLocalizations</span><span>.</span><span>localizationsDelegates</span><span>,</span><span>
      supportedLocales</span><span>:</span><span> </span><span>AppLocalizations</span><span>.</span><span>supportedLocales</span><span>,</span><span>
    </span><span>);</span>
    ```
    
8.  Once the Material app has started, you can use `AppLocalizations` anywhere in your app:
    
    ```
    <span>appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
      </span><span>// The [AppBar] title text should update its message</span><span>
      </span><span>// according to the system locale of the target platform.</span><span>
      </span><span>// Switching between English and Spanish locales should</span><span>
      </span><span>// cause this text to update.</span><span>
      title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>AppLocalizations</span><span>.</span><span>of</span><span>(</span><span>context</span><span>)!.</span><span>helloWorld</span><span>),</span><span>
    </span><span>),</span>
    ```
    

This code generates a `Text` widget that displays “Hello World!” if the target device’s locale is set to English, and “¡Hola Mundo!” if the target device’s locale is set to Spanish. In the `arb` files, the key of each entry is used as the method name of the getter, while the value of that entry contains the localized message.

The [`gen_l10n_example`](https://github.com/flutter/website/tree/main/examples/internationalization/gen_l10n_example) uses this tool.

To localize your device app description, pass the localized string to [`MaterialApp.onGenerateTitle`](https://api.flutter.dev/flutter/material/MaterialApp/onGenerateTitle.html):

```
<span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
  onGenerateTitle</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>DemoLocalizations</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>title</span><span>,</span>
```

### Placeholders, plurals, and selects

You can also include application values in a message with special syntax that uses a _placeholder_ to generate a method instead of a getter. A placeholder, which must be a valid Dart identifier name, becomes a positional parameter in the generated method in the `AppLocalizations` code. Define a placeholder name by wrapping it in curly braces as follows:

Define each placeholder in the `placeholders` object in the app’s `.arb` file. For example, to define a hello message with a `userName` parameter, add the following to `lib/l10n/app_en.arb`:

```
<span>"hello"</span><span>:</span><span> </span><span>"Hello {userName}"</span><span>,</span><span>
</span><span>"@hello"</span><span>:</span><span> </span><span>{</span><span>
  </span><span>"description"</span><span>:</span><span> </span><span>"A message with a single parameter"</span><span>,</span><span>
  </span><span>"placeholders"</span><span>:</span><span> </span><span>{</span><span>
    </span><span>"userName"</span><span>:</span><span> </span><span>{</span><span>
      </span><span>"type"</span><span>:</span><span> </span><span>"String"</span><span>,</span><span>
      </span><span>"example"</span><span>:</span><span> </span><span>"Bob"</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

This code snippet adds a `hello` method call to the `AppLocalizations.of(context)` object, and the method accepts a parameter of type `String`; the `hello` method returns a string. Regenerate the `AppLocalizations` file.

Replace the code passed into `Builder` with the following:

```
<span>// Examples of internationalized strings.</span><span>
</span><span>return</span><span> </span><span>Column</span><span>(</span><span>
  children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
    </span><span>// Returns 'Hello John'</span><span>
    </span><span>Text</span><span>(</span><span>AppLocalizations</span><span>.</span><span>of</span><span>(</span><span>context</span><span>)!.</span><span>hello</span><span>(</span><span>'John'</span><span>)),</span><span>
  </span><span>],</span><span>
</span><span>);</span>
```

You can also use numerical placeholders to specify multiple values. Different languages have different ways to pluralize words. The syntax also supports specifying _how_ a word should be pluralized. A _pluralized_ message must include a `num` parameter indicating how to pluralize the word in different situations. English, for example, pluralizes “person” to “people”, but that doesn’t go far enough. The `message0` plural might be “no people” or “zero people”. The `messageFew` plural might be “several people”, “some people”, or “a few people”. The `messageMany` plural might be “most people” or “many people”, or “a crowd”. Only the more general `messageOther` field is required. The following example shows what options are available:

```
<span>"{countPlaceholder, plural, =0{message0} =1{message1} =2{message2} few{messageFew} many{messageMany} other{messageOther}}"</span><span>
</span>
```

The previous expression is replaced by the message variation (`message0`, `message1`, …) corresponding to the value of the `countPlaceholder`. Only the `messageOther` field is required.

The following example defines a message that pluralizes the word, “wombat”:

```
<span>"nWombats"</span><span>:</span><span> </span><span>"{count, plural, =0{no wombats} =1{1 wombat} other{{count} wombats}}"</span><span>,</span><span>
</span><span>"@nWombats"</span><span>:</span><span> </span><span>{</span><span>
  </span><span>"description"</span><span>:</span><span> </span><span>"A plural message"</span><span>,</span><span>
  </span><span>"placeholders"</span><span>:</span><span> </span><span>{</span><span>
    </span><span>"count"</span><span>:</span><span> </span><span>{</span><span>
      </span><span>"type"</span><span>:</span><span> </span><span>"num"</span><span>,</span><span>
      </span><span>"format"</span><span>:</span><span> </span><span>"compact"</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Use a plural method by passing in the `count` parameter:

```
<span>// Examples of internationalized strings.</span><span>
</span><span>return</span><span> </span><span>Column</span><span>(</span><span>
  children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
    </span><span>...</span><span>
    </span><span>// Returns 'no wombats'</span><span>
    </span><span>Text</span><span>(</span><span>AppLocalizations</span><span>.</span><span>of</span><span>(</span><span>context</span><span>)!.</span><span>nWombats</span><span>(</span><span>0</span><span>)),</span><span>
    </span><span>// Returns '1 wombat'</span><span>
    </span><span>Text</span><span>(</span><span>AppLocalizations</span><span>.</span><span>of</span><span>(</span><span>context</span><span>)!.</span><span>nWombats</span><span>(</span><span>1</span><span>)),</span><span>
    </span><span>// Returns '5 wombats'</span><span>
    </span><span>Text</span><span>(</span><span>AppLocalizations</span><span>.</span><span>of</span><span>(</span><span>context</span><span>)!.</span><span>nWombats</span><span>(</span><span>5</span><span>)),</span><span>
  </span><span>],</span><span>
</span><span>);</span>
```

Similar to plurals, you can also choose a value based on a `String` placeholder. This is most often used to support gendered languages. The syntax is as follows:

```
<span>"{selectPlaceholder, select, case{message} ... other{messageOther}}"</span><span>
</span>
```

The next example defines a message that selects a pronoun based on gender:

```
<span>"pronoun"</span><span>:</span><span> </span><span>"{gender, select, male{he} female{she} other{they}}"</span><span>,</span><span>
</span><span>"@pronoun"</span><span>:</span><span> </span><span>{</span><span>
  </span><span>"description"</span><span>:</span><span> </span><span>"A gendered message"</span><span>,</span><span>
  </span><span>"placeholders"</span><span>:</span><span> </span><span>{</span><span>
    </span><span>"gender"</span><span>:</span><span> </span><span>{</span><span>
      </span><span>"type"</span><span>:</span><span> </span><span>"String"</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Use this feature by passing the gender string as a parameter:

```
<span>// Examples of internationalized strings.</span><span>
</span><span>return</span><span> </span><span>Column</span><span>(</span><span>
  children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
    </span><span>...</span><span>
    </span><span>// Returns 'he'</span><span>
    </span><span>Text</span><span>(</span><span>AppLocalizations</span><span>.</span><span>of</span><span>(</span><span>context</span><span>)!.</span><span>pronoun</span><span>(</span><span>'male'</span><span>)),</span><span>
    </span><span>// Returns 'she'</span><span>
    </span><span>Text</span><span>(</span><span>AppLocalizations</span><span>.</span><span>of</span><span>(</span><span>context</span><span>)!.</span><span>pronoun</span><span>(</span><span>'female'</span><span>)),</span><span>
    </span><span>// Returns 'they'</span><span>
    </span><span>Text</span><span>(</span><span>AppLocalizations</span><span>.</span><span>of</span><span>(</span><span>context</span><span>)!.</span><span>pronoun</span><span>(</span><span>'other'</span><span>)),</span><span>
  </span><span>],</span><span>
</span><span>);</span>
```

Keep in mind that when using `select` statements, comparison between the parameter and the actual value is case-sensitive. That is, `AppLocalizations.of(context)!.pronoun("Male")` defaults to the “other” case, and returns “they”.

### Escaping syntax

Sometimes, you have to use tokens, such as `{` and `}`, as normal characters. To ignore such tokens from being parsed, enable the `use-escaping` flag by adding the following to `l10n.yaml`:

The parser ignores any string of characters wrapped with a pair of single quotes. To use a normal single quote character, use a pair of consecutive single quotes. For example, the follow text is converted to a Dart `String`:

```
<span>{</span><span>
  </span><span>"helloWorld"</span><span>:</span><span> </span><span>"Hello! '{Isn''t}' this a wonderful day?"</span><span>
</span><span>}</span><span>
</span>
```

The resulting string is as follows:

```
<span>"Hello! {Isn't} this a wonderful day?"</span>
```

### Messages with numbers and currencies

Numbers, including those that represent currency values, are displayed very differently in different locales. The localizations generation tool in `flutter_localizations` uses the [`NumberFormat`](https://api.flutter.dev/flutter/intl/NumberFormat-class.html) class in the `intl` package to format numbers based on the locale and the desired format.

The `int`, `double`, and `number` types can use any of the following `NumberFormat` constructors:

| Message “format” value | Output for 1200000 |
| --- | --- |
| `compact` | “1.2M” |
| `compactCurrency`\* | “$1.2M” |
| `compactSimpleCurrency`\* | “$1.2M” |
| `compactLong` | “1.2 million” |
| `currency`\* | “USD1,200,000.00” |
| `decimalPattern` | “1,200,000” |
| `decimalPercentPattern`\* | “120,000,000%” |
| `percentPattern` | “120,000,000%” |
| `scientificPattern` | “1E6” |
| `simpleCurrency`\* | “$1,200,000” |

The starred `NumberFormat` constructors in the table offer optional, named parameters. Those parameters can be specified as the value of the placeholder’s `optionalParameters` object. For example, to specify the optional `decimalDigits` parameter for `compactCurrency`, make the following changes to the `lib/l10n/app_en.arg` file:

```
<span>"numberOfDataPoints"</span><span>:</span><span> </span><span>"Number of data points: {value}"</span><span>,</span><span>
</span><span>"@numberOfDataPoints"</span><span>:</span><span> </span><span>{</span><span>
  </span><span>"description"</span><span>:</span><span> </span><span>"A message with a formatted int parameter"</span><span>,</span><span>
  </span><span>"placeholders"</span><span>:</span><span> </span><span>{</span><span>
    </span><span>"value"</span><span>:</span><span> </span><span>{</span><span>
      </span><span>"type"</span><span>:</span><span> </span><span>"int"</span><span>,</span><span>
      </span><span>"format"</span><span>:</span><span> </span><span>"compactCurrency"</span><span>,</span><span>
      </span><span>"optionalParameters"</span><span>:</span><span> </span><span>{</span><span>
        </span><span>"decimalDigits"</span><span>:</span><span> </span><span>2</span><span>
      </span><span>}</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### Messages with dates

Dates strings are formatted in many different ways depending both the locale and the app’s needs.

Placeholder values with type `DateTime` are formatted with [`DateFormat`](https://api.flutter.dev/flutter/intl/DateFormat-class.html) in the `intl` package.

There are 41 format variations, identified by the names of their `DateFormat` factory constructors. In the following example, the `DateTime` value that appears in the `helloWorldOn` message is formatted with `DateFormat.yMd`:

```
<span>"helloWorldOn"</span><span>:</span><span> </span><span>"Hello World on {date}"</span><span>,</span><span>
</span><span>"@helloWorldOn"</span><span>:</span><span> </span><span>{</span><span>
  </span><span>"description"</span><span>:</span><span> </span><span>"A message with a date parameter"</span><span>,</span><span>
  </span><span>"placeholders"</span><span>:</span><span> </span><span>{</span><span>
    </span><span>"date"</span><span>:</span><span> </span><span>{</span><span>
      </span><span>"type"</span><span>:</span><span> </span><span>"DateTime"</span><span>,</span><span>
      </span><span>"format"</span><span>:</span><span> </span><span>"yMd"</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>
</span>
```

In an app where the locale is US English, the following expression would produce “7/9/1959”. In a Russian locale, it would produce “9.07.1959”.

```
<span>AppLocalizations</span><span>.</span><span>of</span><span>(</span><span>context</span><span>)</span><span>.</span><span>helloWorldOn</span><span>(</span><span>DateTime</span><span>.</span><span>utc</span><span>(</span><span>1959</span><span>,</span> <span>7</span><span>,</span> <span>9</span><span>))</span>
```

### Localizing for iOS: Updating the iOS app bundle

Typically, iOS applications define key application metadata, including supported locales, in an `Info.plist` file that is built into the application bundle. To configure the locales supported by your app, use the following instructions:

1.  Open your project’s `ios/Runner.xcworkspace` Xcode file.
    
2.  In the **Project Navigator**, open the `Info.plist` file under the `Runner` project’s `Runner` folder.
    
3.  Select the **Information Property List** item. Then select **Add Item** from the **Editor** menu, and select **Localizations** from the pop-up menu.
    
4.  Select and expand the newly-created `Localizations` item. For each locale your application supports, add a new item and select the locale you wish to add from the pop-up menu in the **Value** field. This list should be consistent with the languages listed in the [`supportedLocales`](https://api.flutter.dev/flutter/material/MaterialApp/supportedLocales.html) parameter.
    
5.  Once all supported locales have been added, save the file.
    

## Advanced topics for further customization

This section covers additional ways to customize a localized Flutter application.

### Advanced locale definition

Some languages with multiple variants require more than just a language code to properly differentiate.

For example, fully differentiating all variants of Chinese requires specifying the language code, script code, and country code. This is due to the existence of simplified and traditional script, as well as regional differences in the way characters are written within the same script type.

In order to fully express every variant of Chinese for the country codes `CN`, `TW`, and `HK`, the list of supported locales should include:

```
<span>supportedLocales</span><span>:</span><span> </span><span>[</span><span>
  </span><span>Locale</span><span>.</span><span>fromSubtags</span><span>(</span><span>languageCode</span><span>:</span><span> </span><span>'zh'</span><span>),</span><span> </span><span>// generic Chinese 'zh'</span><span>
  </span><span>Locale</span><span>.</span><span>fromSubtags</span><span>(</span><span>
      languageCode</span><span>:</span><span> </span><span>'zh'</span><span>,</span><span>
      scriptCode</span><span>:</span><span> </span><span>'Hans'</span><span>),</span><span> </span><span>// generic simplified Chinese 'zh_Hans'</span><span>
  </span><span>Locale</span><span>.</span><span>fromSubtags</span><span>(</span><span>
      languageCode</span><span>:</span><span> </span><span>'zh'</span><span>,</span><span>
      scriptCode</span><span>:</span><span> </span><span>'Hant'</span><span>),</span><span> </span><span>// generic traditional Chinese 'zh_Hant'</span><span>
  </span><span>Locale</span><span>.</span><span>fromSubtags</span><span>(</span><span>
      languageCode</span><span>:</span><span> </span><span>'zh'</span><span>,</span><span>
      scriptCode</span><span>:</span><span> </span><span>'Hans'</span><span>,</span><span>
      countryCode</span><span>:</span><span> </span><span>'CN'</span><span>),</span><span> </span><span>// 'zh_Hans_CN'</span><span>
  </span><span>Locale</span><span>.</span><span>fromSubtags</span><span>(</span><span>
      languageCode</span><span>:</span><span> </span><span>'zh'</span><span>,</span><span>
      scriptCode</span><span>:</span><span> </span><span>'Hant'</span><span>,</span><span>
      countryCode</span><span>:</span><span> </span><span>'TW'</span><span>),</span><span> </span><span>// 'zh_Hant_TW'</span><span>
  </span><span>Locale</span><span>.</span><span>fromSubtags</span><span>(</span><span>
      languageCode</span><span>:</span><span> </span><span>'zh'</span><span>,</span><span>
      scriptCode</span><span>:</span><span> </span><span>'Hant'</span><span>,</span><span>
      countryCode</span><span>:</span><span> </span><span>'HK'</span><span>),</span><span> </span><span>// 'zh_Hant_HK'</span><span>
</span><span>],</span>
```

This explicit full definition ensures that your app can distinguish between and provide the fully nuanced localized content to all combinations of these country codes. If a user’s preferred locale isn’t specified, Flutter selects the closest match, which likely contains differences to what the user expects. Flutter only resolves to locales defined in `supportedLocales` and provides scriptCode-differentiated localized content for commonly used languages. See [`Localizations`](https://api.flutter.dev/flutter/widgets/WidgetsApp/supportedLocales.html) for information on how the supported locales and the preferred locales are resolved.

Although Chinese is a primary example, other languages like French (`fr_FR`, `fr_CA`) should also be fully differentiated for more nuanced localization.

### Tracking the locale: The Locale class and the Localizations widget

The [`Locale`](https://api.flutter.dev/flutter/dart-ui/Locale-class.html) class identifies the user’s language. Mobile devices support setting the locale for all applications, usually using a system settings menu. Internationalized apps respond by displaying values that are locale-specific. For example, if the user switches the device’s locale from English to French, then a `Text` widget that originally displayed “Hello World” would be rebuilt with “Bonjour le monde”.

The [`Localizations`](https://api.flutter.dev/flutter/flutter_localizations/GlobalWidgetsLocalizations-class.html) widget defines the locale for its child and the localized resources that the child depends on. The [`WidgetsApp`](https://api.flutter.dev/flutter/widgets/WidgetsApp-class.html) widget creates a `Localizations` widget and rebuilds it if the system’s locale changes.

You can always look up an app’s current locale with `Localizations.localeOf()`:

```
<span>Locale</span><span> myLocale </span><span>=</span><span> </span><span>Localizations</span><span>.</span><span>localeOf</span><span>(</span><span>context</span><span>);</span>
```

### Specifying the app’s supportedLocales parameter

Although the `flutter_localizations` library currently supports 115 languages and language variants, only English language translations are available by default. It’s up to the developer to decide exactly which languages to support.

The `MaterialApp` [`supportedLocales`](https://api.flutter.dev/flutter/material/MaterialApp/supportedLocales.html) parameter limits locale changes. When the user changes the locale setting on their device, the app’s `Localizations` widget only follows suit if the new locale is a member of this list. If an exact match for the device locale isn’t found, then the first supported locale with a matching [`languageCode`](https://api.flutter.dev/flutter/dart-ui/Locale/languageCode.html) is used. If that fails, then the first element of the `supportedLocales` list is used.

An app that wants to use a different “locale resolution” method can provide a [`localeResolutionCallback`](https://api.flutter.dev/flutter/widgets/LocaleResolutionCallback.html). For example, to have your app unconditionally accept whatever locale the user selects:

```
<span>MaterialApp</span><span>(</span><span>
  localeResolutionCallback</span><span>:</span><span> </span><span>(</span><span>
    locale</span><span>,</span><span>
    supportedLocales</span><span>,</span><span>
  </span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> locale</span><span>;</span><span>
  </span><span>},</span><span>
</span><span>);</span>
```

### Configuring the l10n.yaml file

The `l10n.yaml` file allows you to configure the `gen-l10n` tool to specify the following:

-   where all the input files are located
-   where all the output files should be created
-   what Dart class name to give your localizations delegate

For a full list of options, either run `flutter gen-l10n --help` at the command line or refer to the following table:

| Option | Description |
| --- | --- |
| `arb-dir` | The directory where the template and translated arb files are located. The default is `lib/l10n`. |
| `output-dir` | The directory where the generated localization classes are written. This option is only relevant if you want to generate the localizations code somewhere else in the Flutter project. You also need to set the `synthetic-package` flag to false.
The app must import the file specified in the `output-localization-file` option from this directory. If unspecified, this defaults to the same directory as the input directory specified in `arb-dir`.

 |
| `template-arb-file` | The template arb file that is used as the basis for generating the Dart localization and messages files. The default is `app_en.arb`. |
| `output-localization-file` | The filename for the output localization and localizations delegate classes. The default is `app_localizations.dart`. |
| `untranslated-messages-file` | The location of a file that describes the localization messages haven’t been translated yet. Using this option creates a JSON file at the target location, in the following format:

`"locale": ["message_1", "message_2" ... "message_n"]`

If this option is not specified, a summary of the messages that haven’t been translated are printed on the command line.

 |
| `output-class` | The Dart class name to use for the output localization and localizations delegate classes. The default is `AppLocalizations`. |
| `preferred-supported-locales` | The list of preferred supported locales for the application. By default, the tool generates the supported locales list in alphabetical order. Use this flag to default to a different locale.

For example, pass in `[ en_US ]` to default to American English if a device supports it.

 |
| `header` | The header to prepend to the generated Dart localizations files. This option takes in a string.

For example, pass in `"/// All localized files."` to prepend this string to the generated Dart file.

Alternatively, check out the `header-file` option to pass in a text file for longer headers.

 |
| `header-file` | The header to prepend to the generated Dart localizations files. The value of this option is the name of the file that contains the header text that is inserted at the top of each generated Dart file.

Alternatively, check out the `header` option to pass in a string for a simpler header.

This file should be placed in the directory specified in `arb-dir`.

 |
| `[no-]use-deferred-loading` | Specifies whether to generate the Dart localization file with locales imported as deferred, allowing for lazy loading of each locale in Flutter web.

This can reduce a web app’s initial startup time by decreasing the size of the JavaScript bundle. When this flag is set to true, the messages for a particular locale are only downloaded and loaded by the Flutter app as they are needed. For projects with a lot of different locales and many localization strings, it can improve performance to defer loading. For projects with a small number of locales, the difference is negligible, and might slow down the start up compared to bundling the localizations with the rest of the application.

Note that this flag doesn’t affect other platforms such as mobile or desktop.

 |
| `gen-inputs-and-outputs-list` | When specified, the tool generates a JSON file containing the tool’s inputs and outputs, named `gen_l10n_inputs_and_outputs.json`.

This can be useful for keeping track of which files of the Flutter project were used when generating the latest set of localizations. For example, the Flutter tool’s build system uses this file to keep track of when to call gen\_l10n during hot reload.

The value of this option is the directory where the JSON file is generated. When null, the JSON file won’t be generated.

 |
| `synthetic-package` | Determines whether the generated output files are generated as a synthetic package or at a specified directory in the Flutter project. This flag is `true` by default. When `synthetic-package` is set to `false`, it generates the localizations files in the directory specified by `arb-dir` by default. If `output-dir` is specified, files are generated there. |
| `project-dir` | When specified, the tool uses the path passed into this option as the directory of the root Flutter project.

When null, the relative path to the present working directory is used.

 |
| `[no-]required-resource-attributes` | Requires all resource ids to contain a corresponding resource attribute.

By default, simple messages won’t require metadata, but it’s highly recommended as this provides context for the meaning of a message to readers.

Resource attributes are still required for plural messages.

 |
| `[no-]nullable-getter` | Specifies whether the localizations class getter is nullable.

By default, this value is true so that `Localizations.of(context)` returns a nullable value for backwards compatibility. If this value is false, then a null check is performed on the returned value of `Localizations.of(context)`, removing the need for null checking in user code.

 |
| `[no-]format` | When specified, the `dart format` command is run after generating the localization files. |
| `use-escaping` | Specifies whether to enable the use of single quotes as escaping syntax. |
| `[no-]suppress-warnings` | When specified, all warnings are suppressed. |

## How internationalization in Flutter works

This section covers the technical details of how localizations work in Flutter. If you’re planning on supporting your own set of localized messages, the following content would be helpful. Otherwise, you can skip this section.

### Loading and retrieving localized values

The `Localizations` widget is used to load and look up objects that contain collections of localized values. Apps refer to these objects with [`Localizations.of(context,type)`](https://api.flutter.dev/flutter/widgets/Localizations/of.html). If the device’s locale changes, the `Localizations` widget automatically loads values for the new locale and then rebuilds widgets that used it. This happens because `Localizations` works like an [`InheritedWidget`](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html). When a build function refers to an inherited widget, an implicit dependency on the inherited widget is created. When an inherited widget changes (when the `Localizations` widget’s locale changes), its dependent contexts are rebuilt.

Localized values are loaded by the `Localizations` widget’s list of [`LocalizationsDelegate`](https://api.flutter.dev/flutter/widgets/LocalizationsDelegate-class.html)s. Each delegate must define an asynchronous [`load()`](https://api.flutter.dev/flutter/widgets/LocalizationsDelegate/load.html) method that produces an object that encapsulates a collection of localized values. Typically these objects define one method per localized value.

In a large app, different modules or packages might be bundled with their own localizations. That’s why the `Localizations` widget manages a table of objects, one per `LocalizationsDelegate`. To retrieve the object produced by one of the `LocalizationsDelegate`’s `load` methods, specify a `BuildContext` and the object’s type.

For example, the localized strings for the Material Components widgets are defined by the [`MaterialLocalizations`](https://api.flutter.dev/flutter/material/MaterialLocalizations-class.html) class. Instances of this class are created by a `LocalizationDelegate` provided by the [`MaterialApp`](https://api.flutter.dev/flutter/material/MaterialApp-class.html) class. They can be retrieved with `Localizations.of()`:

```
<span>Localizations</span><span>.</span><span>of</span><span>&lt;</span><span>MaterialLocalizations</span><span>&gt;(</span><span>context</span><span>,</span> <span>MaterialLocalizations</span><span>);</span>
```

This particular `Localizations.of()` expression is used frequently, so the `MaterialLocalizations` class provides a convenient shorthand:

```
<span>static</span> <span>MaterialLocalizations</span> <span>of</span><span>(</span><span>BuildContext</span> <span>context</span><span>)</span> <span>{</span>
  <span>return</span> <span>Localizations</span><span>.</span><span>of</span><span>&lt;</span><span>MaterialLocalizations</span><span>&gt;(</span><span>context</span><span>,</span> <span>MaterialLocalizations</span><span>);</span>
<span>}</span>

<span>/// References to the localized values defined by MaterialLocalizations</span>
<span>/// are typically written like this:</span>

<span>tooltip:</span> <span>MaterialLocalizations</span><span>.</span><span>of</span><span>(</span><span>context</span><span>)</span><span>.</span><span>backButtonTooltip</span><span>,</span>
```

### Defining a class for the app’s localized resources

Putting together an internationalized Flutter app usually starts with the class that encapsulates the app’s localized values. The example that follows is typical of such classes.

Complete source code for the [`intl_example`](https://github.com/flutter/website/tree/main/examples/internationalization/intl_example) for this app.

This example is based on the APIs and tools provided by the [`intl`](https://pub.dev/packages/intl) package. The [An alternative class for the app’s localized resources](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization#alternative-class) section describes [an example](https://github.com/flutter/website/tree/main/examples/internationalization/minimal) that doesn’t depend on the `intl` package.

The `DemoLocalizations` class (defined in the following code snippet) contains the app’s strings (just one for the example) translated into the locales that the app supports. It uses the `initializeMessages()` function generated by Dart’s [`intl`](https://pub.dev/packages/intl) package, [`Intl.message()`](https://pub.dev/documentation/intl/latest/intl/Intl/message.html), to look them up.

```
<span>class</span><span> </span><span>DemoLocalizations</span><span> </span><span>{</span><span>
  </span><span>DemoLocalizations</span><span>(</span><span>this</span><span>.</span><span>localeName</span><span>);</span><span>

  </span><span>static</span><span> </span><span>Future</span><span>&lt;</span><span>DemoLocalizations</span><span>&gt;</span><span> load</span><span>(</span><span>Locale</span><span> locale</span><span>)</span><span> </span><span>{</span><span>
    </span><span>final</span><span> </span><span>String</span><span> name </span><span>=</span><span>
        locale</span><span>.</span><span>countryCode </span><span>==</span><span> </span><span>null</span><span> </span><span>||</span><span> locale</span><span>.</span><span>countryCode</span><span>!.</span><span>isEmpty
            </span><span>?</span><span> locale</span><span>.</span><span>languageCode
            </span><span>:</span><span> locale</span><span>.</span><span>toString</span><span>();</span><span>
    </span><span>final</span><span> </span><span>String</span><span> localeName </span><span>=</span><span> </span><span>Intl</span><span>.</span><span>canonicalizedLocale</span><span>(</span><span>name</span><span>);</span><span>

    </span><span>return</span><span> initializeMessages</span><span>(</span><span>localeName</span><span>).</span><span>then</span><span>((</span><span>_</span><span>)</span><span> </span><span>{</span><span>
      </span><span>return</span><span> </span><span>DemoLocalizations</span><span>(</span><span>localeName</span><span>);</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  </span><span>static</span><span> </span><span>DemoLocalizations</span><span> of</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Localizations</span><span>.</span><span>of</span><span>&lt;</span><span>DemoLocalizations</span><span>&gt;(</span><span>context</span><span>,</span><span> </span><span>DemoLocalizations</span><span>)!;</span><span>
  </span><span>}</span><span>

  </span><span>final</span><span> </span><span>String</span><span> localeName</span><span>;</span><span>

  </span><span>String</span><span> </span><span>get</span><span> title </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Intl</span><span>.</span><span>message</span><span>(</span><span>
      </span><span>'Hello World'</span><span>,</span><span>
      name</span><span>:</span><span> </span><span>'title'</span><span>,</span><span>
      desc</span><span>:</span><span> </span><span>'Title for the Demo application'</span><span>,</span><span>
      locale</span><span>:</span><span> localeName</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

A class based on the `intl` package imports a generated message catalog that provides the `initializeMessages()` function and the per-locale backing store for `Intl.message()`. The message catalog is produced by an [`intl` tool](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization#dart-tools) that analyzes the source code for classes that contain `Intl.message()` calls. In this case that would just be the `DemoLocalizations` class.

### Adding support for a new language

An app that needs to support a language that’s not included in [`GlobalMaterialLocalizations`](https://api.flutter.dev/flutter/flutter_localizations/GlobalMaterialLocalizations-class.html) has to do some extra work: it must provide about 70 translations (“localizations”) for words or phrases and the date patterns and symbols for the locale.

See the following for an example of how to add support for the Norwegian Nynorsk language.

A new `GlobalMaterialLocalizations` subclass defines the localizations that the Material library depends on. A new `LocalizationsDelegate` subclass, which serves as factory for the `GlobalMaterialLocalizations` subclass, must also be defined.

Here’s the source code for the complete [`add_language`](https://github.com/flutter/website/tree/main/examples/internationalization/add_language/lib/main.dart) example, minus the actual Nynorsk translations.

The locale-specific `GlobalMaterialLocalizations` subclass is called `NnMaterialLocalizations`, and the `LocalizationsDelegate` subclass is `_NnMaterialLocalizationsDelegate`. The value of `NnMaterialLocalizations.delegate` is an instance of the delegate, and is all that’s needed by an app that uses these localizations.

The delegate class includes basic date and number format localizations. All of the other localizations are defined by `String` valued property getters in `NnMaterialLocalizations`, like this:

```
<span>@override
</span><span>String</span><span> </span><span>get</span><span> moreButtonTooltip </span><span>=&gt;</span><span> </span><span>r'More'</span><span>;</span><span>

@override
</span><span>String</span><span> </span><span>get</span><span> aboutListTileTitleRaw </span><span>=&gt;</span><span> </span><span>r'About $applicationName'</span><span>;</span><span>

@override
</span><span>String</span><span> </span><span>get</span><span> alertDialogLabel </span><span>=&gt;</span><span> </span><span>r'Alert'</span><span>;</span>
```

These are the English translations, of course. To complete the job you need to change the return value of each getter to an appropriate Nynorsk string.

The getters return “raw” Dart strings that have an `r` prefix, such as `r'About $applicationName'`, because sometimes the strings contain variables with a `$` prefix. The variables are expanded by parameterized localization methods:

```
<span>@override
</span><span>String</span><span> </span><span>get</span><span> pageRowsInfoTitleRaw </span><span>=&gt;</span><span> </span><span>r'$firstRow–$lastRow of $rowCount'</span><span>;</span><span>

@override
</span><span>String</span><span> </span><span>get</span><span> pageRowsInfoTitleApproximateRaw </span><span>=&gt;</span><span>
    </span><span>r'$firstRow–$lastRow of about $rowCount'</span><span>;</span>
```

The date patterns and symbols of the locale also need to be specified, which are defined in the source code as follows:

```
<span>const</span><span> nnLocaleDatePatterns </span><span>=</span><span> </span><span>{</span><span>
  </span><span>'d'</span><span>:</span><span> </span><span>'d.'</span><span>,</span><span>
  </span><span>'E'</span><span>:</span><span> </span><span>'ccc'</span><span>,</span><span>
  </span><span>'EEEE'</span><span>:</span><span> </span><span>'cccc'</span><span>,</span><span>
  </span><span>'LLL'</span><span>:</span><span> </span><span>'LLL'</span><span>,</span><span>
  </span><span>// ...</span><span>
</span><span>}</span>
```

```
<span>const</span><span> nnDateSymbols </span><span>=</span><span> </span><span>{</span><span>
  </span><span>'NAME'</span><span>:</span><span> </span><span>'nn'</span><span>,</span><span>
  </span><span>'ERAS'</span><span>:</span><span> </span><span>&lt;</span><span>dynamic</span><span>&gt;[</span><span>
    </span><span>'f.Kr.'</span><span>,</span><span>
    </span><span>'e.Kr.'</span><span>,</span><span>
  </span><span>],</span><span>
  </span><span>// ...</span><span>
</span><span>}</span>
```

These values need to be modified for the locale to use the correct date formatting. Unfortunately, since the `intl` library doesn’t share the same flexibility for number formatting, the formatting for an existing locale must be used as a substitute in `_NnMaterialLocalizationsDelegate`:

```
<span>class</span><span> _NnMaterialLocalizationsDelegate
    </span><span>extends</span><span> </span><span>LocalizationsDelegate</span><span>&lt;</span><span>MaterialLocalizations</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>const</span><span> _NnMaterialLocalizationsDelegate</span><span>();</span><span>

  @override
  </span><span>bool</span><span> isSupported</span><span>(</span><span>Locale</span><span> locale</span><span>)</span><span> </span><span>=&gt;</span><span> locale</span><span>.</span><span>languageCode </span><span>==</span><span> </span><span>'nn'</span><span>;</span><span>

  @override
  </span><span>Future</span><span>&lt;</span><span>MaterialLocalizations</span><span>&gt;</span><span> load</span><span>(</span><span>Locale</span><span> locale</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>final</span><span> </span><span>String</span><span> localeName </span><span>=</span><span> intl</span><span>.</span><span>Intl</span><span>.</span><span>canonicalizedLocale</span><span>(</span><span>locale</span><span>.</span><span>toString</span><span>());</span><span>

    </span><span>// The locale (in this case `nn`) needs to be initialized into the custom</span><span>
    </span><span>// date symbols and patterns setup that Flutter uses.</span><span>
    date_symbol_data_custom</span><span>.</span><span>initializeDateFormattingCustom</span><span>(</span><span>
      locale</span><span>:</span><span> localeName</span><span>,</span><span>
      patterns</span><span>:</span><span> nnLocaleDatePatterns</span><span>,</span><span>
      symbols</span><span>:</span><span> intl</span><span>.</span><span>DateSymbols</span><span>.</span><span>deserializeFromMap</span><span>(</span><span>nnDateSymbols</span><span>),</span><span>
    </span><span>);</span><span>

    </span><span>return</span><span> </span><span>SynchronousFuture</span><span>&lt;</span><span>MaterialLocalizations</span><span>&gt;(</span><span>
      </span><span>NnMaterialLocalizations</span><span>(</span><span>
        localeName</span><span>:</span><span> localeName</span><span>,</span><span>
        </span><span>// The `intl` library's NumberFormat class is generated from CLDR data</span><span>
        </span><span>// (see https://github.com/dart-lang/i18n/blob/main/pkgs/intl/lib/number_symbols_data.dart).</span><span>
        </span><span>// Unfortunately, there is no way to use a locale that isn't defined in</span><span>
        </span><span>// this map and the only way to work around this is to use a listed</span><span>
        </span><span>// locale's NumberFormat symbols. So, here we use the number formats</span><span>
        </span><span>// for 'en_US' instead.</span><span>
        decimalFormat</span><span>:</span><span> intl</span><span>.</span><span>NumberFormat</span><span>(</span><span>'#,##0.###'</span><span>,</span><span> </span><span>'en_US'</span><span>),</span><span>
        twoDigitZeroPaddedFormat</span><span>:</span><span> intl</span><span>.</span><span>NumberFormat</span><span>(</span><span>'00'</span><span>,</span><span> </span><span>'en_US'</span><span>),</span><span>
        </span><span>// DateFormat here will use the symbols and patterns provided in the</span><span>
        </span><span>// `date_symbol_data_custom.initializeDateFormattingCustom` call above.</span><span>
        </span><span>// However, an alternative is to simply use a supported locale's</span><span>
        </span><span>// DateFormat symbols, similar to NumberFormat above.</span><span>
        fullYearFormat</span><span>:</span><span> intl</span><span>.</span><span>DateFormat</span><span>(</span><span>'y'</span><span>,</span><span> localeName</span><span>),</span><span>
        compactDateFormat</span><span>:</span><span> intl</span><span>.</span><span>DateFormat</span><span>(</span><span>'yMd'</span><span>,</span><span> localeName</span><span>),</span><span>
        shortDateFormat</span><span>:</span><span> intl</span><span>.</span><span>DateFormat</span><span>(</span><span>'yMMMd'</span><span>,</span><span> localeName</span><span>),</span><span>
        mediumDateFormat</span><span>:</span><span> intl</span><span>.</span><span>DateFormat</span><span>(</span><span>'EEE, MMM d'</span><span>,</span><span> localeName</span><span>),</span><span>
        longDateFormat</span><span>:</span><span> intl</span><span>.</span><span>DateFormat</span><span>(</span><span>'EEEE, MMMM d, y'</span><span>,</span><span> localeName</span><span>),</span><span>
        yearMonthFormat</span><span>:</span><span> intl</span><span>.</span><span>DateFormat</span><span>(</span><span>'MMMM y'</span><span>,</span><span> localeName</span><span>),</span><span>
        shortMonthDayFormat</span><span>:</span><span> intl</span><span>.</span><span>DateFormat</span><span>(</span><span>'MMM d'</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span>bool</span><span> shouldReload</span><span>(</span><span>_NnMaterialLocalizationsDelegate old</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>false</span><span>;</span><span>
</span><span>}</span>
```

For more information about localization strings, check out the [flutter\_localizations README](https://github.com/flutter/flutter/blob/master/packages/flutter_localizations/lib/src/l10n/README.md).

Once you’ve implemented your language-specific subclasses of `GlobalMaterialLocalizations` and `LocalizationsDelegate`, you need to add the language and a delegate instance to your app. The following code sets the app’s language to Nynorsk and adds the `NnMaterialLocalizations` delegate instance to the app’s `localizationsDelegates` list:

```
<span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
  localizationsDelegates</span><span>:</span><span> </span><span>[</span><span>
    </span><span>GlobalWidgetsLocalizations</span><span>.</span><span>delegate</span><span>,</span><span>
    </span><span>GlobalMaterialLocalizations</span><span>.</span><span>delegate</span><span>,</span><span>
    </span><span>NnMaterialLocalizations</span><span>.</span><span>delegate</span><span>,</span><span> </span><span>// Add the newly created delegate</span><span>
  </span><span>],</span><span>
  supportedLocales</span><span>:</span><span> </span><span>[</span><span>
    </span><span>Locale</span><span>(</span><span>'en'</span><span>,</span><span> </span><span>'US'</span><span>),</span><span>
    </span><span>Locale</span><span>(</span><span>'nn'</span><span>),</span><span>
  </span><span>],</span><span>
  home</span><span>:</span><span> </span><span>Home</span><span>(),</span><span>
</span><span>),</span>
```

## Alternative internationalization workflows

This section describes different approaches to internationalize your Flutter application.

### An alternative class for the app’s localized resources

The previous example was defined in terms of the Dart `intl` package. You can choose your own approach for managing localized values for the sake of simplicity or perhaps to integrate with a different i18n framework.

Complete source code for the [`minimal`](https://github.com/flutter/website/tree/main/examples/internationalization/minimal) app.

In the following example, the `DemoLocalizations` class includes all of its translations directly in per language Maps:

```
<span>class</span><span> </span><span>DemoLocalizations</span><span> </span><span>{</span><span>
  </span><span>DemoLocalizations</span><span>(</span><span>this</span><span>.</span><span>locale</span><span>);</span><span>

  </span><span>final</span><span> </span><span>Locale</span><span> locale</span><span>;</span><span>

  </span><span>static</span><span> </span><span>DemoLocalizations</span><span> of</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Localizations</span><span>.</span><span>of</span><span>&lt;</span><span>DemoLocalizations</span><span>&gt;(</span><span>context</span><span>,</span><span> </span><span>DemoLocalizations</span><span>)!;</span><span>
  </span><span>}</span><span>

  </span><span>static</span><span> </span><span>const</span><span> _localizedValues </span><span>=</span><span> </span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>String</span><span>&gt;&gt;{</span><span>
    </span><span>'en'</span><span>:</span><span> </span><span>{</span><span>
      </span><span>'title'</span><span>:</span><span> </span><span>'Hello World'</span><span>,</span><span>
    </span><span>},</span><span>
    </span><span>'es'</span><span>:</span><span> </span><span>{</span><span>
      </span><span>'title'</span><span>:</span><span> </span><span>'Hola Mundo'</span><span>,</span><span>
    </span><span>},</span><span>
  </span><span>};</span><span>

  </span><span>static</span><span> </span><span>List</span><span>&lt;</span><span>String</span><span>&gt;</span><span> languages</span><span>()</span><span> </span><span>=&gt;</span><span> _localizedValues</span><span>.</span><span>keys</span><span>.</span><span>toList</span><span>();</span><span>

  </span><span>String</span><span> </span><span>get</span><span> title </span><span>{</span><span>
    </span><span>return</span><span> _localizedValues</span><span>[</span><span>locale</span><span>.</span><span>languageCode</span><span>]![</span><span>'title'</span><span>]!;</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

In the minimal app the `DemoLocalizationsDelegate` is slightly different. Its `load` method returns a [`SynchronousFuture`](https://api.flutter.dev/flutter/foundation/SynchronousFuture-class.html) because no asynchronous loading needs to take place.

```
<span>class</span><span> </span><span>DemoLocalizationsDelegate</span><span>
    </span><span>extends</span><span> </span><span>LocalizationsDelegate</span><span>&lt;</span><span>DemoLocalizations</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>DemoLocalizationsDelegate</span><span>();</span><span>

  @override
  </span><span>bool</span><span> isSupported</span><span>(</span><span>Locale</span><span> locale</span><span>)</span><span> </span><span>=&gt;</span><span>
      </span><span>DemoLocalizations</span><span>.</span><span>languages</span><span>().</span><span>contains</span><span>(</span><span>locale</span><span>.</span><span>languageCode</span><span>);</span><span>

  @override
  </span><span>Future</span><span>&lt;</span><span>DemoLocalizations</span><span>&gt;</span><span> load</span><span>(</span><span>Locale</span><span> locale</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// Returning a SynchronousFuture here because an async "load" operation</span><span>
    </span><span>// isn't needed to produce an instance of DemoLocalizations.</span><span>
    </span><span>return</span><span> </span><span>SynchronousFuture</span><span>&lt;</span><span>DemoLocalizations</span><span>&gt;(</span><span>DemoLocalizations</span><span>(</span><span>locale</span><span>));</span><span>
  </span><span>}</span><span>

  @override
  </span><span>bool</span><span> shouldReload</span><span>(</span><span>DemoLocalizationsDelegate</span><span> old</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>false</span><span>;</span><span>
</span><span>}</span>
```

### Using the Dart intl tools

Before building an API using the Dart [`intl`](https://pub.dev/packages/intl) package, review the `intl` package’s documentation. The following list summarizes the process for localizing an app that depends on the `intl` package:

The demo app depends on a generated source file called `l10n/messages_all.dart`, which defines all of the localizable strings used by the app.

Rebuilding `l10n/messages_all.dart` requires two steps.

1.  With the app’s root directory as the current directory, generate `l10n/intl_messages.arb` from `lib/main.dart`:
    
    ```
    <span>$</span><span> </span>dart run intl_translation:extract_to_arb <span>--output-dir</span><span>=</span>lib/l10n lib/main.dart
    ```
    
    The `intl_messages.arb` file is a JSON format map with one entry for each `Intl.message()` function defined in `main.dart`. This file serves as a template for the English and Spanish translations, `intl_en.arb` and `intl_es.arb`. These translations are created by you, the developer.
    
2.  With the app’s root directory as the current directory, generate `intl_messages_<locale>.dart` for each `intl_<locale>.arb` file and `intl_messages_all.dart`, which imports all of the messages files:
    
    ```
    <span>$</span><span> </span>dart run intl_translation:generate_from_arb <span>\</span>
    <span>    --output-dir=lib/l10n --no-use-deferred-loading \
        lib/main.dart lib/l10n/intl_*.arb
    </span>
    ```
    
    **_Windows doesn’t support file name wildcarding._** Instead, list the .arb files that were generated by the `intl_translation:extract_to_arb` command.
    
    ```
    <span>$</span><span> </span>dart run intl_translation:generate_from_arb <span>\</span>
    <span>    --output-dir=lib/l10n --no-use-deferred-loading \
        lib/main.dart \
        lib/l10n/intl_en.arb lib/l10n/intl_fr.arb lib/l10n/intl_messages.arb
    </span>
    ```
    
    The `DemoLocalizations` class uses the generated `initializeMessages()` function (defined in `intl_messages_all.dart`) to load the localized messages and `Intl.message()` to look them up.
    

## More information

If you learn best by reading code, check out the following examples.

-   [`minimal`](https://github.com/flutter/website/tree/main/examples/internationalization/minimal)  
    The `minimal` example is designed to be as simple as possible.
-   [`intl_example`](https://github.com/flutter/website/tree/main/examples/internationalization/intl_example)  
    uses APIs and tools provided by the [`intl`](https://pub.dev/packages/intl) package.

If Dart’s `intl` package is new to you, check out [Using the Dart intl tools](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization#dart-tools).