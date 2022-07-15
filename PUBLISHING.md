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

**Notes about elm-bump: Read below about the error "I got the data back, but it was not what I was expecting"**

Run the following to bump && publish the version in elm.json:

```
npx -p elm@0.19.0-no-deps elm bump
```

or

```
elm bump
```

---

If you get something like this:

```
-- PROBLEM LOADING DOCS --------------------------------------------------------

I need the docs for 12.17.0 to compute the next version number, so I fetched:

    https://package.elm-lang.org/packages/NoRedInk/noredink-ui/12.17.0/docs.json

I got the data back, but it was not what I was expecting. The response body
contains 195076 bytes. Here is the beginning:

    [{"name":"Nri.Ui","comment":" A collection of helpers for working with No...

Does this error keep showing up? Maybe there is something weird with your
internet connection. We have gotten reports that schools, businesses, airports,
etc. sometimes intercept requests and add things to the body or change its
contents entirely. Could that be the problem?
```

Then run it with 0.19.0 explicitly (0.19.1 has some problems with big docs):

```
npx -p elm@0.19.0-no-deps elm bump
```

---

Commit and push your changes in a PR. Once it's approved and merged, then:

```
git tag -a 6.1.0 -m "release version 6.1.0"
git push origin 6.1.0
npx -p elm@0.19.0-no-deps elm publish
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