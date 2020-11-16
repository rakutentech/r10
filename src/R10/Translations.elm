module R10.Translations exposing (language, signIn, signInHeader, signOut)

{-| Text translations.

This is an examples of translation:

    signInHeader : R10.Language.Translations
    signInHeader =
        { key = "signInHeader"
        , en_us = "Sign in to your Rakuten account"
        , ja_jp = "楽天会員 ログイン"
        , zh_tw = "登錄您的Rakuten帳戶"
        , de_de = "Loggen Sie sich in Ihr Rakuten-Konto ein"
        , fr_fr = "Connectez-vous à votre compte Rakuten"
        , it_it = "Accedi al tuo account Rakuten"
        , es_es = "Inicie sesión en su cuenta de Rakuten"
        , nl_nl = "Log in op uw Rakuten-account"
        , pt_pt = "Faça login em sua conta Rakuten"
        , nb_no = "Logg på Rakuten-kontoen din"
        , fi_fl = "Kirjaudu Rakuten-tilillesi"
        , da_dk = "Log ind på din Rakuten-konto"
        , sv_se = "Logga in på ditt Rakuten-konto"
        }

@docs language, signIn, signInHeader, signOut

-}

import R10.Language


{-| -}
signInHeader : R10.Language.Translations
signInHeader =
    { key = "signInHeader"
    , en_us = "Sign in to your Rakuten account"
    , ja_jp = "楽天会員 ログイン"
    , zh_tw = "登錄您的Rakuten帳戶"
    , de_de = "Loggen Sie sich in Ihr Rakuten-Konto ein[[R]]"
    , fr_fr = "Connectez-vous à votre compte Rakuten"
    , it_it = "Accedi al tuo account Rakuten"
    , es_es = "Inicie sesión en su cuenta de Rakuten"
    , nl_nl = "Log in op uw Rakuten-account"
    , pt_pt = "Faça login em sua conta Rakuten"
    , nb_no = "Logg på Rakuten-kontoen din"
    , fi_fl = "Kirjaudu Rakuten-tilillesi"
    , da_dk = "Log ind på din Rakuten-konto"
    , sv_se = "Logga in på ditt Rakuten-konto"
    }


{-| -}
language : R10.Language.Translations
language =
    { key = "language"
    , en_us = "Language"
    , ja_jp = "言語"
    , zh_tw = "語言"
    , de_de = "Sprache"
    , fr_fr = "Langue"
    , it_it = "Lingua"
    , es_es = "Idioma"
    , nl_nl = "Taal"
    , pt_pt = "Língua"
    , nb_no = "Språk"
    , fi_fl = "Kieli"
    , da_dk = "Sprog"
    , sv_se = "Språk"
    }


{-| -}
signOut : R10.Language.Translations
signOut =
    { key = "signOut"
    , en_us = "Sign Out"
    , ja_jp = "ログアウト"
    , zh_tw = "登出"
    , de_de = "Ausloggen"
    , fr_fr = "Déconnexion"
    , it_it = "Disconnessione"
    , es_es = "Desconectar"
    , nl_nl = "Afmelden"
    , pt_pt = "Sair"
    , nb_no = "Logg ut"
    , fi_fl = "Kirjaudu ulos"
    , da_dk = "Log ud"
    , sv_se = "Logga ut"
    }


{-| -}
signIn : R10.Language.Translations
signIn =
    { key = "signIn"
    , en_us = "Sign in"
    , ja_jp = "ログイン"
    , zh_tw = "登入"
    , de_de = "Anmelden"
    , fr_fr = "Se connecter"
    , it_it = "Registrati"
    , es_es = "Registrarse"
    , nl_nl = "Inloggen"
    , pt_pt = "Assinar em"
    , nb_no = "Logg inn"
    , fi_fl = "Kirjaudu sisään"
    , da_dk = "Log ind"
    , sv_se = "Logga in"
    }
