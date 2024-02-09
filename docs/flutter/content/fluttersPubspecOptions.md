1.  [Tools](https://docs.flutter.dev/tools)
2.  [Flutter and the pubspec file](https://docs.flutter.dev/tools/pubspec)

Every Flutter project includes a `pubspec.yaml` file, often referred to as _the pubspec_. A basic pubspec is generated when you create a new Flutter project. It’s located at the top of the project tree and contains metadata about the project that the Dart and Flutter tooling needs to know. The pubspec is written in [YAML](https://yaml.org/), which is human readable, but be aware that _white space (tabs v spaces) matters_.

The pubspec file specifies dependencies that the project requires, such as particular packages (and their versions), fonts, or image files. It also specifies other requirements, such as dependencies on developer packages (like testing or mocking packages), or particular constraints on the version of the Flutter SDK.

Fields common to both Dart and Flutter projects are described in [the pubspec file](https://dart.dev/tools/pub/pubspec) on [dart.dev](https://dart.dev/). This page lists _Flutter-specific_ fields that are only valid for a Flutter project.

When you create a new project with the `flutter create` command (or by using the equivalent button in your IDE), it creates a pubspec for a basic Flutter app.

Here is an example of a Flutter project pubspec file. The Flutter only fields are highlighted.

```
<span>name: </span><span>&lt;project name</span><span>&gt;</span><span>
</span><span>description: </span><span>A new Flutter project.

</span><span>publish_to: </span><span>none

</span><span>version: </span><span>1.0.0+1

</span><span>environment:
</span><span>  </span><span>sdk: </span><span>'&gt;=3.2.0 &lt;4.0.0'</span><span>

</span><span>dependencies:
</span><span>  </span><span><span>flutter:</span></span><span> </span><span>      </span><span># Required for every Flutter project</span><span>
    </span><span><span>sdk: </span><span>flutter</span></span><span> </span><span># Required for every Flutter project</span><span>
  </span><span><span>flutter_localizations:</span></span><span> </span><span># Required to enable localization</span><span>
    </span><span><span>sdk: </span><span>flutter</span></span><span>         </span><span># Required to enable localization</span><span>

  </span><span><span>cupertino_icons: </span><span>^1.0.6</span></span><span> </span><span># Only required if you use Cupertino (iOS style) icons</span><span>

</span><span>dev_dependencies:
</span><span>  </span><span><span>flutter_test:</span></span><span>
</span><span>    </span><span><span>sdk: </span><span>flutter</span></span><span> </span><span># Required for a Flutter project that includes tests</span><span>

  </span><span><span>flutter_lints: </span><span>^3.0.0</span></span><span> </span><span># Contains a set of recommended lints for Flutter code</span><span>

</span><span><span>flutter:</span></span><span>
</span><span>
  </span><span><span>uses-material-design: </span><span>true</span></span><span> </span><span># Required if you use the Material icon font</span><span>

  </span><span><span>generate: </span><span>true</span></span><span> </span><span># Enables generation of localized strings from arb files</span><span>

  </span><span><span>assets:</span></span><span> </span><span> </span><span># Lists assets, such as image files</span><span>
    </span><span><span>-</span><span> images/a_dot_burr.jpeg</span></span><span>
    </span><span><span>-</span><span> images/a_dot_ham.jpeg</span></span><span>

  </span><span><span>fonts:</span></span><span> </span><span>             </span><span># Required if your app uses custom fonts</span><span>
    </span><span><span>-</span><span> </span><span>family: </span><span>Schyler</span></span><span>
      </span><span><span>fonts:</span></span><span>
</span><span>        </span><span><span>-</span><span> </span><span>asset: </span><span>fonts/Schyler</span><span>-</span><span>Regular.ttf</span></span><span>
        </span><span><span>-</span><span> </span><span>asset: </span><span>fonts/Schyler</span><span>-</span><span>Italic.ttf</span></span><span>
          </span><span><span>style: </span><span>italic</span></span><span>
    </span><span><span>-</span><span> </span><span>family: </span><span>Trajan Pro</span></span><span>
      </span><span><span>fonts:</span></span><span>
</span><span>        </span><span><span>-</span><span> </span><span>asset: </span><span>fonts/TrajanPro.ttf</span></span><span>
        </span><span><span>-</span><span> </span><span>asset: </span><span>fonts/TrajanPro_Bold.ttf</span></span><span>
          </span><span><span>weight: </span><span>700</span></span>
```

## Assets

Common types of assets include static data (for example, JSON files), configuration files, icons, and images (JPEG, WebP, GIF, animated WebP/GIF, PNG, BMP, and WBMP).

Besides listing the images that are included in the app package, an image asset can also refer to one or more resolution-specific “variants”. For more information, see the [resolution aware](https://docs.flutter.dev/ui/assets/assets-and-images#resolution-aware) section of the [Assets and images](https://docs.flutter.dev/ui/assets/assets-and-images) page. For information on adding assets from package dependencies, see the [asset images in package dependencies](https://docs.flutter.dev/ui/assets/assets-and-images#from-packages) section in the same page.

## Fonts

As shown in the above example, each entry in the fonts section should have a `family` key with the font family name, and a `fonts` key with a list specifying the asset and other descriptors for the font.

For examples of using fonts see the [Use a custom font](https://docs.flutter.dev/cookbook/design/fonts) and [Export fonts from a package](https://docs.flutter.dev/cookbook/design/package-fonts) recipes in the [Flutter cookbook](https://docs.flutter.dev/cookbook).

## More information

For more information on packages, plugins, and pubspec files, see the following:

-   [Creating packages](https://dart.dev/guides/libraries/create-library-packages) on dart.dev
-   [Glossary of package terms](https://dart.dev/tools/pub/glossary) on dart.dev
-   [Package dependencies](https://dart.dev/tools/pub/dependencies) on dart.dev
-   [Using packages](https://docs.flutter.dev/packages-and-plugins/using-packages)
-   [What not to commit](https://dart.dev/guides/libraries/private-files#pubspeclock) on dart.dev