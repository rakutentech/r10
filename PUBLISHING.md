# PUBLISHING

## Documentation

You can verify the documentation of the project running

```
elm-doc-preview
```

installable with
```
npm install -g elm-doc-preview
```

These are good guidelines to follow while coding and writing documentation:

* https://package.elm-lang.org/help/design-guidelines
* https://elm-lang.org/docs/style-guide

## Dependencies

You can add or remove dependencies with `elm-json`

## Publishing

Run the following to bump && publish the version in elm.json:

```
elm bump
```

Commit and push your changes in a PR. Once it's approved and merged, then:

```
git tag -a 5.10.0 -m "release version 5.10.0"
git push origin 5.10.0
elm publish
```

You can also add a tag in https://github.com/rakutentech/r10/releases/new if you want to add more detail.

Once you've published, you should see the latest version at https://package.elm-lang.org/packages/rakutentech/r10/ or https://elm.dmy.fr/packages/rakutentech/r10/.

## Best practices

Imports should be plain, without aliases and without exposing particular functions. This make the code more clear as it immediately understanding if a resource is defined in the present module or somewhere else. It also makes code block more portable.

These are the exceptions to this rule: 

    import Element exposing (..)
    import Element.Background as Background
    import Element.Border as Border
    import Element.Events as Events
    import Element.Font as Font
    import Element.Input as Input
    import Element.Keyed as Keyed
    import Json.Decode as D
    import Json.Encode as E
    import Svg.Attributes as SA
    import Html exposing (..)
    import Html.Attributes exposing (..)

`Html` and `Html.Attributes` can be esposed only if `Element` is not used, otherwise there are conflicts.

----

Modules that are not exposed should have `Internal` somewhere in their path.

## How to develop

For testing or modification to R10 on a local environment, clone R10 (https://github.com/rakutentech/r10) in a sibling folder of projects that use R10, then, in the elm.json file of such project:
 
* Remove the dependency from r10 (or run `elm-json uninstall rakutenteck/r10`)
* Add in the list of `"source-directories"` folders: `"../r10/src"`