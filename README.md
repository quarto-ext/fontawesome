# Font Awesome extension for Quarto

This extension allows you to use [Font Awesome](https://fontawesome.com/) icons in your quarto documents. 

## Installation

Download the [release file](https://github.com/quarto-ext/fontawesome/releases/tag/v0.0.1) and unzip it.

From the command line, at the root directory of your quarto project:

```
$ quarto install extension <path-to-unzipped-directory>
```

For example, in macOS:

```
$ cd ~/Downloads
$ tar xzvf fontawesome-0.0.1.tar.gz
x fontawesome-0.0.1/
   ... (more output from the tar command)
$ cd PATH-TO-YOUR-QUARTO-PROJECT
$ quarto install extension ~/Downloads/fontawesome-0.0.1/
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Usage

The extension provides the `fa` shortcode:

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
* No formatting options
