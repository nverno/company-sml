*Author:* Noah Peart <noah.v.peart@gmail.com><br>
*URL:* [https://github.com/nverno/company-sml](https://github.com/nverno/company-sml)<br>

Emacs completion support for SML using company mode

Install: 

You will need to install `company-mode` and to add this file to your `load-path`, ie

```lisp
(add-to-list 'load-path path/to/this/file)
```

Then either create autoloads/compile with make file and load
the autoloads or just add to your .emacs

```lisp
(require 'company-sml)
(add-hook 'company-sml 'company-sml-setup)
```

Example:

![example](example.png)


---
Converted from `company-sml.el` by [*el2markdown*](https://github.com/Lindydancer/el2markdown).
