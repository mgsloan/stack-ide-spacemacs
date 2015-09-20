# stack-ide-spacemacs

This is WIP spacemacs layer for
[stack-mode](https://github.com/commercialhaskell/stack-ide/tree/master/stack-mode).

## What this layer provides

* A minimal configuration of haskell-mode.  ** NOTE: can't be used with the haskell
  layer. ** This is mostly a decision of convenience rather than technical
  necessity, and may change in the future.

* A few spacemacs bindings

```
<SPC> m t      Get type information
<SPC> m i      Get identifier info
<SPC> m g      Go to definition
<SPC> m s c    Clear stack mode buffer
```

* Usage of [company-stack-ide](https://github.com/drwebb/company-stack-ide)

* Hacky display of stack-ide progress updates in the powerline (instead of
messages).

## Installation

Setting this up isn't very streamlined yet:

```
git clone --recursive https://github.com/mgsloan/stack-ide-spacemacs.git ~/.emacs.d/private/stack-ide
ln -s PATH_TO_STACK_IDE/stack-mode .emacs.d/private/stack-ide/extensions/stack-mode
```

where `PATH_TO_STACK_IDE` is a path to a cloned version of
[stack-ide](https://github.com/commercialhaskell/stack-ide) (`git clone
https://github.com/commercialhaskell/stack-ide.git`)

Then, add the following to your `dotspacemacs-configuration-layers`:

```
   dotspacemacs-configuration-layers
   '(
     auto-completion
     syntax-checking
     stack-ide
    )
```

Note that this layer initializes `haskell-mode`, and can't currently be used
with the `haskell` layer.

## Other Notes

* This sets the flycheck mode to only compile when the monad is enabled and when
  the file is saved. I found this to work better for me than
  compilation-on-change.
