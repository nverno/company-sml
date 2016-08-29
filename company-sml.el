;;; company-sml --- Emacs completion support for SML using company-mode

;; Author: Noah Peart <noah.v.peart@gmail.com>
;; URL: https://github.com/nverno/company-sml
;; Copyright (C) 2016, Noah Peart, all rights reserved.
;; Created: 28 July 2016
;; Package-Requires ((emacs "24.1") (cl-lib "0.5") (company "0.8.0"))

;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:

;; Emacs completion support for SML using company mode

;; Install: 

;; You will need to install `company-mode' and to add this file to your `load-path', ie

;; ```lisp
;; (add-to-list 'load-path path/to/this/file)
;; ```

;; Then either create autoloads/compile with make file and load
;; the autoloads or just add to your .emacs

;; ```lisp
;; (require 'company-sml)
;; (add-hook 'company-sml 'company-sml-setup)
;; ```

;; Example:

;; ![example](example.png)

;;; Code:

(require 'company)
(require 'company-keywords)

(defgroup company-sml nil
  "Completion for SML scripting files."
  :group 'languages
  :group 'company
  :prefix "company-sml-")

;; ------------------------------------------------------------
;;* User Variables

;; doesn't seem to been any completion-at-point support
;; for `sml-mode', so most backends won't be useful
(defcustom company-sml-backends
  '((company-keywords company-dabbrev-code) company-dabbrev)
  "Default company completion backends for SML. If non-nil, setup
these in `company-sml-setup' as local `company-backends' for sml files."
  :group 'company-sml
  :type `(choice nil sexp))

;; ------------------------------------------------------------
;;* Keywords
(defvar company-keywords-alist)
(eval-and-compile

  (defvar company-sml-builtin
   '(
     "abstraction" "abstype" "and" "andalso" "as" "before" "case"
     "datatype" "div" "do" "else" "end" "eqtype" "exception" "false"
     "fn" "fun" "functor" "handle" "if" "in" "include" "infix" "infixr"
     "let" "local" "mod" "nonfix" "o" "of" "op" "open" "orelse" "overload"
     "raise" "rec" "sharing" "sig" "signature" "struct" "structure"
     "then" "true" "type" "use" "val" "withtype" "with" "where" "while"
     )
   "SML keywords taken from `sml-mode'.")

 (defvar company-sml-more-words
   '("abstype"
     "and"
     "andalso"
     "as"
     "case"
     "do"
     "datatype"
     "div"
     "else"
     "end"
     "eqtype"
     "exception"
     "extract"
     "fn"
     "fun"
     "functor"
     "handle"
     "if"
     "in"
     "include"
     "infix"
     "infixr"
     "let"
     "local"
     "mod"
     "nonfix"
     "of"
     "op"
     "open"
     "orelse"
     "raise"
     "rec"
     "sharing"
     "sig"
     "signature"
     "struct"
     "structure"
     "then"
     "type"
     "val"
     "where"
     "with"
     "withtype"
     "while"
     ":>"
     "=>"
     "->"
     "..."
     "unit"
     "bool"
     "order"
     "int"
     "real"
     "char"
     "string"
     "list"
     "exn"
     "SOME"
     "NONE"
     "LESS"
     "EQUAL"
     "GREATER"
     "getOpt"
     "isSome"
     "valOf"
     "Option.filter"
     "Option.map"
     "Option.app"
     "Option.join"
     "Option.compose"
     "Option.mapPartial"
     "Option.composePartial"
     "ref"
     ":="
     "ignore"
     "before"
     "::"
     "<="
     ">="
     "abs"
     "Int.precision"
     "Int.minlnt"
     "Int.maxlnt"
     "Int.quot"
     "Int.rem"
     "Word.wordSize"
     "Int.min"
     "Int.max"
     "Int.sign"
     "Int.sameSign"
     "Int.compare"
     "Real.min"
     "Real.max"
     "Real.sign"
     "Real.sameSign"
     "Real.compare"
     "Math.pi"
     "Math.e"
     "Math.sqrt"
     "Math.exp"
     "Math.sin"
     "Math.cos"
     "Math.tan"
     "Math.atan"
     "Math.asin"
     "Math.acos"
     "Math.atan2"
     "Math.pow"
     "Math.ln"
     "Math.logl0"
     "Math.sinh"
     "Math.cosh"
     "Math.tanh"
     "Word.orb"
     "Word.andb"
     "Word.xorb"
     "Word.notb"
     "Word.<<"
     "Word.>>"
     "Char.compare"
     "String.compare"
     "Char.minChar"
     "Char.maxChar"
     "Char.maxOrd"
     "Char.succ"
     "Char.pred"
     "ord"
     "chr"
     "str"
     "Char.toLower"
     "Char.toUpper"
     "Char.fromString"
     "Char.toString"
     "Char.fromCString"
     "Char.toCString"
     "Char.contains"
     "Char.notContains"
     "Char.isLower"
     "Char.isUpper"
     "Char.isDigit"
     "Char.isAlpha"
     "Char.isHexDigit"
     "Char.isAlphaNum"
     "Char.isPrint"
     "Char.isSpace"
     "Char.isPunct"
     "Char.isGraph"
     "Char.isAscii"
     "Char.isCntrl"
     "concat"
     "implode"
     "explode"
     "size"
     "String.sub"
     "String.substring"
     "String.isPrefix"
     "String.collate"
     "Char.contains"
     "Char.notContains"
     "String.maxSize"
     "String.fromString"
     "String.toString"
     "String.fromCString"
     "String.toCString"
     "String.translate"
     "Substring.substring"
     "Substring.extract"
     "Substring.all"
     "Substring.string"
     "Substring.base"
     "Substring.isEmpty"
     "Substring.getc"
     "Substring.first"
     "Substring.triml"
     "Substring.trimr"
     "Substring.sub"
     "Substring.size"
     "Substring.slice"
     "Substring.concat"
     "Substring.explode"
     "Substring.isPrefix"
     "Substring.compare"
     "Substring.collate"
     "Substring.dropl"
     "Substring.dropr"
     "Substring.takel"
     "Substring.taker"
     "Substring.splitl"
     "Substring.splitr"
     "Substring.splitAt"
     "Substr1ng.position"
     "Subatring.span"
     "Subatring.tranalate"
     "Substring.foldl"
     "Substring.foldr"
     "Substring.app"
     "rev"
     "length"
     "foldr"
     "foldl"
     "app"
     "map"
     "null"
     "hd"
     "tl"
     "List.nth"
     "List.last"
     "List.length"
     "List.take"
     "List.drop"
     "List.concat"
     "List.revAppend"
     "List.mapPartial"
     "List.find"
     "List.filter"
     "List.partition"
     "List.exists"
     "List.all"
     "List.tabulate"
     "List.getItem"
     "ListPair.zip"
     "ListPair.unzip"
     "ListPair.map"
     "ListPair.app"
     "ListPair.all"
     "ListPair.exists"
     "ListPair.foldr"
     "ListPair.foldl"
     "Vector.maxLen"
     "Vector.fromList"
     "Vector.tabulate"
     "Vector.length"
     "Vector.sub"
     "Vector.extract"
     "Vector.concat"
     "Vector.app"
     "Vector.foldl"
     "Vector.foldr"
     "Vector.appi"
     "Vector.foldli"
     "Vector.foldri"
     "Array.maxLen"
     "Array.array"
     "Array.tabulate"
     "Array.fromList"
     "Array.length"
     "Array.sub"
     "Array.app"
     "Array.foldl"
     "Array.foldr"
     "Array.modify"
     "Array.appi"
     "Array.foldli"
     "Array.foldri"
     "Array.modifyi"
     "Array.update"
     "Array.extract"
     "Array.copy"
     "Array.copyVec"
     "Time.time"
     "Timer.real_timer"
     "Timer.cpu_timer"
     "Timer.startCPUTimer"
     "Timer.totalCPUTimer"
     "Timer.checkCPUTimer"
     "Timer.startRealTimer"
     "Timer.totalRealTimer"
     "Timer.checkRealTimer"
     "Time.zeroTime"
     "Time.now "
     "Time.+"
     "Time.-"
     "Time.<"
     "Time.<-"
     "Time.>"
     "Time.>-"
     "Time.compare"
     "date"
     "weekday"
     "Date.fromTimeLocal"
     "Date.fromTimeUniv"
     "Date.toTime"
     "Date.year"
     "Date.month"
     "Date.day"
     "Date.hour"
     "Date.minute"
     "Date.second"
     "Date.weekDay"
     "Date.yearDay"
     "Date.isDst"
     "Date.offset"
     "Dat.localOffse"
     "Date.compare"
     "Bool.toString"
     "Int.toString"
     "Word.toString"
     "Real.toString"
     "Date.toString"
     "Time.toString"
     "Bool.fromString"
     "Int.fromString"
     "Word.fromString"
     "Real.fromString"
     "Date.fromString"
     "Time.fromString"
     "Date.toTime"
     "Time.toSeconds"
     "Time.toMilliseconds"
     "Time.toMicroseconds"
     "Time.fromSeconds"
     "Time.fromMilliseconds"
     "Time.fromMicroseconds"
     "Time.toReal"
     "Time.fromReal"
     "String.tokens"
     "String.fields "
     "Substring.tokens"
     "Substring.fields"
     "TextIO.stdln"
     "TextIO.openln"
     "TextIO.closeln"
     "TextIO.input"
     "TextIO.inputAll"
     "TextIO.inputNoBlock"
     "TextIO.input1"
     "TextIO.inputN"
     "TextIO.inputLine"
     "TextIO.endOfStream"
     "TextIO.lookahead"
     "TextIO.stdOut"
     "TextIO.stdErr"
     "TextIO.openOut"
     "TextIO.openAppend"
     "TextIO.closeOut"
     "TextIO.output"
     "TextIO.outputSubstr"
     "TextIO.output1"
     "TextIO.flushOut"
     "print"))

 (defvar company-sml-words
   (cl-remove-duplicates
    (append company-sml-builtin
            company-sml-more-words))))

(defun company-sml-check (backend backends)
  (cond
   ((atom backends) (eq backend backends))
   ((listp (car backends)) (or (company-sml-check backend (car backends))
                          (company-sml-check backend (cdr backends))))
   (t (or (eq backend (car backends))
          (company-sml-check backend (cdr backends))))))

;; ------------------------------------------------------------
;;* Setup

;;;###autoload
(defun company-sml-setup ()
  "Add SML words to `company-keywords-alist'."
  (setcdr
   (nthcdr (1- (length company-keywords-alist)) company-keywords-alist)
   `(,(append '(sml-mode) company-sml-words))))

;;;###autoload
(eval-after-load "sml-mode"
  '(company-sml-setup))

;; ;;;###autoload
;; (defun company-sml-setup ()
;;   "Set up company backends for `sml-mode'. Suitable for a hook."
;;   (when (and (not (assq 'sml-mode company-keywords-alist))
;;              (company-sml-check 'company-keywords
;;                                 company-sml-backends))
;;     (company-sml-keywords-setup))
;;   (when company-sml-backends
;;     (set (make-local-variable 'company-backends)
;;          company-sml-backends)))

(provide 'company-sml)

;;; company-sml.el ends here
