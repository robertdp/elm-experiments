# elm-experimental

This is a playground for experimental work with Elm.

## Page stacks

```
Files:

    page-stacks/Pages.elm
    page-stacks/Data/Page.elm
    page-stacks/Pages/One.elm
    page-stacks/Pages/Two.elm
```

Very ugly proof of concept regarding nav stacks in Elm. Pages can be added to the stack without
losing the state of previous pages. Each page has a "unique" context that identifies it along with its type.

WARNING: This has a lot of boilerplate...
