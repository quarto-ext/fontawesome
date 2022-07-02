# Font Awesome extension for Quarto

This extension allows you to use [Font Awesome](https://fontawesome.com/) icons in your quarto documents. 

## Installation

From the command line, at the root directory of your quarto project:

```
$ quarto install extension https://github.com/quarto-dev/quarto-ext/fontawesome
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Usage

This extension provides the `fa` shortcode:

```
{{< fa icon-name >}}
```

For example, here's a minimal full document that uses Font Awesome icons in both PDF and HTML:

    ---
    format:
        pdf: default
        html: default
    ---

    This is a test. {{< fa book >}} {{< fa download >}}

## Known Issues

* The PDF format uses fontawesome5, while the HTML format uses fontawesome6.
* No formatting 