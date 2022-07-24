# Font Awesome Extension for Quarto

This extension provides support including free icons provided by [Font Awesome](https://fontawesome.com). Icons can be used in both HTML (via [Font Awesome 6 Free](https://fontawesome.com/search?m=free)) and PDF (via the [fontawesome5 LaTeX package](https://ctan.org/pkg/fontawesome5?lang=en)).

## Installing

```sh
quarto install extension quarto-ext/fontawesome
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

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

### Brands[^1]

Note that there is a `brands` prefix used within the `bluetooth` example above.
If you choose an icon from the `brands` collection, you will need to add a `brands` collection specifier when using any HTML format.
For example, if you search the free icons for "github" and then click on the `github` icon, you'll see this as the suggested HTML to embed the icon:

```html
<i class="fa-brands fa-github"></i>
```

The `fa-brands` indicates that the icon is in the `brands` collection. To use this with Quarto just add the `brands` collection prefix as follows:

```default
{{< fa brands github >}}
```

### Sizing Icons

Font Awesome provides relative and literal sizing for icons as described in <https://fontawesome.com/docs/web/style/size>.  
When the size is invalid, no size changes are made.

- Relative sizing[^1]: `{{< fa battery-half size=2xl >}}`.

  | Relative Sizing Class | Font Size | Equivalent in Pixels |
  |-----------------------|-----------|----------------------|
  | fa-2xs                | 0.625em   | 10px                 |
  | fa-xs                 | 0.75em    | 12px                 |
  | fa-sm                 | 0.875em   | 14px                 |
  | fa-lg                 | 1.25em    | 20px                 |
  | fa-xl                 | 1.5em     | 24px                 |
  | fa-2xl                | 2em       | 32px                 |

- Literal sizing[^1]: `{{< fa battery-half size=5x >}}`.

  | Literal Sizing Class | Font Size |
  |----------------------|-----------|
  | fa-1x                | 1em       |
  | fa-2x                | 2em       |
  | fa-3x                | 3em       |
  | fa-4x                | 4em       |
  | fa-5x                | 5em       |
  | fa-6x                | 6em       |
  | fa-7x                | 7em       |
  | fa-8x                | 8em       |
  | fa-9x                | 9em       |
  | fa-10x               | 10em      |

- LaTeX sizing: `{{< fa battery-half size=Huge >}}`.

  | Sizing Command                   | Font Size (LaTeX)    | Font Size (HTML) |
  | -------------------------------- | -------------------- | ---------------- |
  | tiny (= `\tiny`)                 | 5pt                  | 0.5em            |
  | scriptsize (= `\scriptsize`)     | 7pt                  | 0.7em            |
  | footnotesize (= `\footnotesize`) | 8pt                  | 0.8em            |
  | small (= `\small`)               | 9pt                  | 0.9em            |
  | normalsize (= `\normalsize`)     | 10pt (document size) | 1em              |
  | large (= `\large`)               | 12pt                 | 1.25em           |
  | Large (= `\Large`)               | 14.4pt               | 1.5em            |
  | LARGE (= `\LARGE`)               | 17.28pt              | 1.75em           |
  | huge (= `\huge`)                 | 20.74pt              | 2em              |
  | Huge (= `\Huge`)                 | 24.88pt              | 2.5em            |

### Accessibility[^1]

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

[^1]: HTML formats only.

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).

This is the output of `example.qmd` for [HTML](https://quarto-ext.github.io/fontawesome/) and [PDF](https://quarto-ext.github.io/fontawesome/example.pdf).
