# Font Awesome Extension for Quarto

This extension provides support including free icons provided by [Font Awesome](https://fontawesome.com). Icons can be used in HTML (via [Font Awesome 6.7.2](https://fontawesome.com/search?m=free)), PDF (via the [fontawesome6 LaTeX package](https://ctan.org/pkg/fontawesome6)), and Typst (via the [fontawesome Typst package](https://typst.app/universe/package/fontawesome)).

## Installing

```sh
quarto add quarto-ext/fontawesome
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

Do note that this extension requires quarto 1.2.198 or higher. We strongly recommend you ensure you're running a recent version of quarto, and download/install one [from the download page](https://quarto.org/docs/download/) if needed.

## Using

To embed an icon, use the `{{< fa >}}` shortcode. For example:

```default
{{< fa thumbs-up >}} 
{{< fa folder >}}
{{< fa chess-pawn >}}
{{< fa brands bluetooth >}}
{{< fa brands twitter size=2xl >}}
{{< fa brands github size=5x >}}
{{< fa battery-half size=Huge >}}
{{< fa envelope title="An envelope" >}}
```

This extension includes support for only free Font Awesome icons (there are roughly 2,000 free icons, while the complete set of Pro icons consists of more than 16,000).
You can browse all of the available free icons here:

<https://fontawesome.com/search?m=free>

All icons available in this extensions are coming from <https://github.com/FortAwesome/Font-Awesome>

### Brands

Note that there is a `brands` prefix used within the `bluetooth` example above.
If you choose an icon from the `brands` collection, you will need to add a `brands` collection specifier.
For example, if you search the free icons for "github" and then click on the `github` icon, you'll see this as the suggested HTML to embed the icon:

```html
<i class="fa-brands fa-github"></i>
```

The `fa-brands` indicates that the icon is in the `brands` collection. To use this with Quarto just add the `brands` collection prefix as follows:

```default
{{< fa brands github >}}
```

### Sizing Icons

Font Awesome provides relative and literal sizing for icons as described in <https://fontawesome.com/docs/web/style/size>. Using these sizing values will work for HTML and PDF with Typst. For PDF through LaTeX, only using the named values related to LaTeX command will work, and in that case they are translated to compatible sized for HTML and PDF with Typst. 

When the `size` option is passed an invalid value, no size changes are made.

- Relative sizing[^1]: `{{< fa battery-half size=2xl >}}`.

  | Relative Sizing Class | Font Size | Equivalent in Pixels |
  |-----------------------|-----------|----------------------|
  | 2xs                   | 0.625em   | 10px                 |
  | xs                    | 0.75em    | 12px                 |
  | sm                    | 0.875em   | 14px                 |
  | lg                    | 1.25em    | 20px                 |
  | xl                    | 1.5em     | 24px                 |
  | 2xl                   | 2em       | 32px                 |

- Literal sizing[^1]: `{{< fa battery-half size=5x >}}`.

  | Literal Sizing Class | Font Size |
  |----------------------|-----------|
  | 1x                   | 1em       |
  | 2x                   | 2em       |
  | 3x                   | 3em       |
  | 4x                   | 4em       |
  | 5x                   | 5em       |
  | 6x                   | 6em       |
  | 7x                   | 7em       |
  | 8x                   | 8em       |
  | 9x                   | 9em       |
  | 10x                  | 10em      |

- LaTeX sizing[^2]: `{{< fa battery-half size=Huge >}}`.

  | Sizing Command                   | Font Size (PDF)      | Font Size (HTML/Typst) |
  | -------------------------------- | -------------------- | ---------------------- |
  | tiny (= `\tiny`)                 | 5pt                  | 0.5em                  |
  | scriptsize (= `\scriptsize`)     | 7pt                  | 0.7em                  |
  | footnotesize (= `\footnotesize`) | 8pt                  | 0.8em                  |
  | small (= `\small`)               | 9pt                  | 0.9em                  |
  | normalsize (= `\normalsize`)     | 10pt (document size) | 1em                    |
  | large (= `\large`)               | 12pt                 | 1.2em                  |
  | Large (= `\Large`)               | 14.4pt               | 1.5em                  |
  | LARGE (= `\LARGE`)               | 17.28pt              | 1.75em                 |
  | huge (= `\huge`)                 | 20.74pt              | 2em                    |
  | Huge (= `\Huge`)                 | 24.88pt              | 2.5em                  |

### Accessibility[^3]

If the icon is being used in place of some text,
just add some descriptive text in the title argument:

```default
{{< fa envelope title="An envelope" >}}
```

This will produce the following HTML:

```html
<i class="fa-solid fa-envelope" title="An envelope" aria-hidden="true"></i>
```

More details on Font Awesome accessibility at <https://fontawesome.com/docs/web/dig-deeper/accessibility>.

[^1]: HTML and Typst formats only.
[^2]: All formats supported.
[^3]: HTML format only.

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).

This is the output of `example.qmd` for [HTML](https://quarto-ext.github.io/fontawesome/) and [PDF](https://quarto-ext.github.io/fontawesome/example.pdf).
