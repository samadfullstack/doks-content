1.  [Performance](https://docs.flutter.dev/perf)

<iframe width="560" height="315" src="https://www.youtube.com/embed/PKGguGUwSYE?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Flutter performance tips - Flutter in Focus" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-9257802_51="true" id="990291494" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true" data-gtm-yt-inspected-6="true"></iframe>

[Flutter performance basics](https://www.youtube.com/watch?v=PKGguGUwSYE)

What is performance? Why is performance important? How do I improve performance?

Our goal is to answer those three questions (mainly the third one), and anything related to them. This document should serve as the single entry point or the root node of a tree of resources that addresses any questions that you have about performance.

The answers to the first two questions are mostly philosophical, and not as helpful to many developers who visit this page with specific performance issues that need to be solved. Therefore, the answers to those questions are in the [appendix](https://docs.flutter.dev/perf/appendix).

To improve performance, you first need metrics: some measurable numbers to verify the problems and improvements. In the [metrics](https://docs.flutter.dev/perf/metrics) page, you’ll see which metrics are currently used, and which tools and APIs are available to get the metrics.

There is a list of [Frequently asked questions](https://docs.flutter.dev/perf/faq), so you can find out if the questions you have or the problems you’re having were already answered or encountered, and whether there are existing solutions. (Alternatively, you can check the Flutter GitHub issue database using the [performance](https://github.com/flutter/flutter/issues?q=+label%3A%22severe%3A+performance%22) label.)

Finally, the performance issues are divided into four categories. They correspond to the four labels that are used in the Flutter GitHub issue database: “[perf: speed](https://github.com/flutter/flutter/issues?q=is%3Aopen+label%3A%22perf%3A+speed%22+sort%3Aupdated-asc+)”, “[perf: memory](https://github.com/flutter/flutter/issues?q=is%3Aopen+label%3A%22perf%3A+memory%22+sort%3Aupdated-asc+)”, “[perf: app size](https://github.com/flutter/flutter/issues?q=is%3Aopen+label%3A%22perf%3A+app+size%22+sort%3Aupdated-asc+)”, “[perf: energy](https://github.com/flutter/flutter/issues?q=is%3Aopen+label%3A%22perf%3A+energy%22+sort%3Aupdated-asc+)”.

The rest of the content is organized using those four categories.

## Speed

Are your animations janky (not smooth)? Learn how to evaluate and fix rendering issues.

[Improving rendering performance](https://docs.flutter.dev/perf/rendering-performance)

## App size

How to measure your app’s size. The smaller the size, the quicker it is to download.

[Measuring your app’s size](https://docs.flutter.dev/perf/app-size)