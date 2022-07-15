# R10

![R10 logo](https://r10.netlify.app/images/r10.png)

**R10** is a library of interactive building blocks written in [Elm](https://elm-lang.org/) and [elm-ui](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) that we use at [Rakuten](https://global.rakuten.com/) for creating user interfaces.

**Disclaimer**: This library is actively used in our live projects and the code and the documentation can be rough in most places because, you know, deadlines! It is also tailored for our use so it is probably useful as source of information rather than as a real dependency to add in your projects.

### Links

* [R10 demo with documentation and examples](https://r10.netlify.app/)
* [R10 in the Elm's package website](https://package.elm-lang.org/packages/rakutentech/r10/latest/)
* [R10 in Github](https://github.com/rakutentech/r10)
* [Ellie: R10 Simple View](https://ellie-app.com/j3Xg2HZ4V62a1)
* [Ellie: R10 Simple Form](https://ellie-app.com/j3Xj8dmJzvja1)
* [Ellie: R10 Credit Card Form](https://ellie-app.com/j3Xk8ZqvKGYa1)

# How to use the R10 library

If you already have an existing Elm project, install the library with

```bash
elm install rakutentech/r10
```

See [this Ellie](https://ellie-app.com/gCQvcN4gy3Ra1).


               
# How to bootstrap a new project

You can find a fully functional project in the folder [`examples/pwa`](https://github.com/rakutentech/r10/tree/master/examples/pwa). You can use it as a base for a new project simply copying it.

From the root folder of the example, run

```bash
npm install
npm start
```

Then you can preview the website at http://localhost:8000.

Changing `src/Main.elm` will automatically recompile the application and refresh the browser.

To build the files optimized for the release in production, run:

```bash
npm run build
```

You can then find the files in `elm-stuff/elm-starter-files/build`.


## Website characteristics

The bootstrapped website showcases has these characteristics:

* Single Page Application (**SPA**)
* Progressive Web Application (**PWA**)
* **Static SSR** (pre-render during the build)
* Works **off-line** and **without Javascript**
* **Installable** on desktop and mobile
* Friendly to search engines (**SEO**)
* Supports **custom previews** so it looks good when you share links
* **Best practices**, **Accessibility**, etc. (High scores with Lighthouse)
* Includes **R10 building blocks** such as logos, icons, buttons, forms, etc. with coding playgrounds.
* Supports **multi language** websites
* Standard **header and footer**

To know more, read the [`elm-starter` documentation](https://github.com/lucamug/elm-starter) and the [`r10` documentation](https://package.elm-lang.org/packages/rakutentech/r10/latest/).
    
Note: If you copied the file in a new folder you need to modify the `elm.json` file:

1. Remove `../../src` from the list of `source-directories`
2. Run `elm install rakutentech/r10` that will add this library as dependency



# Other languages or frameworks

If you are looking for Rakuten UI components written in other languages or frameworks, have a look at the [ReX Github repository](https://github.com/rakuten-rex) and the [ReX Frontend Components Library](https://zeroheight.com/390c074f3/p/080991-).



# Thanks

Thanks to Evan Czaplicki, Matthew Griffith, Richard Feldman, the folks at NoRedInk, Ryan Haskell-Glatz, Ilias Van Peer, Aaron VonderHaar, Abadi Kurniawaan, Dillon Kearns, Jeroen Engels, Keith Lazuka, Luke Westby, Alex Korban, Thibaut Assus, Brian Hicks and many more from the Elm community that directly or indirectly supported us in this journey.



# Examples

These are real-life fully working code samples that render these views:

![Examples](https://r10.netlify.app/images/examples-600.png)

The primary color and the light/dark mode can be changed through the `theme` definitions. For example:

```elm
theme =
    { mode = R10.Mode.Light
    , primaryColor = R10.Color.primary.blueSky
    }

theme =
    { mode = R10.Mode.Light
    , primaryColor = R10.Color.primary.green
    }

theme =
    { mode = R10.Mode.Dark
    , primaryColor = R10.Color.primary.blueSky
    }
```

This is the source code for the example with two buttons: [Source code](https://github.com/rakutentech/r10/tree/master/examples/simpleView/src/Main.elm).

This is the code sample for the view with the form: ([Source code](https://github.com/rakutentech/r10/blob/master/examples/simpleForm/src/Main.elm)).
