# Font Awesome Extension for Quarto

This extension allows you to use [Font Awesome](https://fontawesome.com/) icons in your quarto documents. 

## Installing

```
quarto install extension quarto-ext/fontawesome
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

The extension provides the `fa` shortcode. For example:

```
{{< fa thumbs-up >}} 
{{< fa folder >}}
```

Here is the source code for a minimal example: [example.qmd](example.qmd)

This is the output of `example.qmd` for [HTML](https://quarto-ext.github.io/fontawesome/) and [PDF](https://quarto-ext.github.io/fontawesome/example.pdf).


# Known Issues

* The PDF format uses fontawesome5, while the HTML format uses fontawesome6.
* No additional styling or formatting options
