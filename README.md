# Font Awesome Extension for Quarto

This extension provides support including free icons provided by [Font Awesome](https://fontawesome.com). Icons can be used in both HTML (via [Font Awesome 6 Free](https://fontawesome.com/search?m=free)) and PDF (via the [fontawesome5 LaTeX package](https://ctan.org/pkg/fontawesome5?lang=en)).

## Installing

```
$ quarto install extension quarto-ext/fontawesome
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

To embed an icon, use the `{{< fa >}}` shortcode. For example:

```
{{< fa thumbs-up >}} 
{{< fa folder >}}
{{< fa chess-pawn >}}
{{< fa brands bluetooth >}}
```

This extension includes support for only free Font Awesome icons (there are roughly 2,000 free icons, while the complete set of Pro icons consists of more than 16,000). You can browse all of the available free icons here:

<https://fontawesome.com/search?m=free>

### Brands

Note that there is a `brands` prefix used within the `bluetooth` example above. If you choose an icon from the `brands` collection, you will need to add a `brands` collection specifier. For example, if you search the free icons for "github" and then click on the `github` icon, you'll see this as the suggested HTML to embed the icon:

```html
<i class="fa-brands fa-github"></i>
```

The `fa-brands` indicates that the icon is in the `brands` collection. To use this with Quarto just add the `brands` collection prefix as follows:

```default
{{< fa brands github >}}
```

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd)

This is the output of `example.qmd` for [HTML](https://quarto-ext.github.io/fontawesome/) and [PDF](https://quarto-ext.github.io/fontawesome/example.pdf).

