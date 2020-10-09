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