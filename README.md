# elm-experimental

This is a playground for experimental work with Elm.

## Page stacks

```
Files:

    src/Pages.elm
    src/Data/Page.elm
    src/Pages/One.elm
    src/Pages/Two.elm
```

Very ugly proof of concept regarding nav stacks in Elm. Pages can be added to the stack without
losing the state of previous pages. Each page has a "unique" context that identifies it along with its type.

WARNING: This has a lot of boilerplate...
