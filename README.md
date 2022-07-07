# Font Awesome extension for Quarto

This extension allows you to use [Font Awesome](https://fontawesome.com/) icons in your quarto documents. 

## Installing

```
$ quarto install extension quarto-ext/fontawesome
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

The extension provides the `fa` shortcode:

```
{{< fa icon-name >}}
```

See the source code of a [minimal example](index.qmd), or see it [live](https://quarto-ext.github.io/fontawesome/).

# Known Issues

* The PDF format uses fontawesome5, while the HTML format uses fontawesome6.
* No additional styling or formatting options
