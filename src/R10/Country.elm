module R10.Country exposing (Country(..), codeAndNameList, emptyFlag, fromCountryCode, fromCountryTelCode, fromString, list, listHead, listTail, toCountryCode, toCountryTelCode, toFlag, toString, fromTelephoneAsString, toCountryNameWithAlias)

{-|

@docs Country, codeAndNameList, emptyFlag, fromCountryCode, fromCountryTelCode, fromString, list, listHead, listTail, toCountryCode, toCountryTelCode, toFlag, toString, fromTelephoneAsString, toCountryNameWithAlias

-}

import String.Extra


{-| -}
type Country
    = Afghanistan
    | Albania
    | Algeria
    | AmericanSamoa
    | Andorra
    | Angola
    | Anguilla
    | Antarctica
    | AntiguaandBarbuda
    | Argentina
    | Armenia
    | Aruba
    | Australia
    | Austria
    | Azerbaijan
    | Bahamas
    | Bahrain
    | Bangladesh
    | Barbados
    | Belarus
    | Belgium
    | Belize
    | Benin
    | Bermuda
    | Bhutan
    | Bolivia
    | BosniaandHerzegovina
    | Botswana
    | Brazil
    | BritishIndianOceanTerritory
    | BritishVirginIslands
    | Brunei
    | Bulgaria
    | BurkinaFaso
    | Burundi
    | Cambodia
    | Cameroon
    | Canada
    | CapeVerde
    | CaymanIslands
    | CentralAfricanRepublic
    | Chad
    | Chile
    | China
    | ChristmasIsland
    | CocosIslands
    | Colombia
    | Comoros
    | CookIslands
    | CostaRica
    | Croatia
    | Cuba
    | Curacao
    | Cyprus
    | CzechRepublic
    | DemocraticRepublicoftheCongo
    | Denmark
    | Djibouti
    | Dominica
    | DominicanRepublic
    | EastTimor
    | Ecuador
    | Egypt
    | ElSalvador
    | EquatorialGuinea
    | Eritrea
    | Estonia
    | Ethiopia
    | FalklandIslands
    | FaroeIslands
    | Fiji
    | Finland
    | France
    | FrenchPolynesia
    | Gabon
    | Gambia
    | Georgia
    | Germany
    | Ghana
    | Gibraltar
    | Greece
    | Greenland
    | Grenada
    | Guam
    | Guatemala
    | Guernsey
    | Guinea
    | GuineaBissau
    | Guyana
    | Haiti
    | Honduras
    | HongKong
    | Hungary
    | Iceland
    | India
    | Indonesia
    | Iran
    | Iraq
    | Ireland
    | IsleofMan
    | Israel
    | Italy
    | IvoryCoast
    | Jamaica
    | Japan
    | Jersey
    | Jordan
    | Kazakhstan
    | Kenya
    | Kiribati
    | Kosovo
    | Kuwait
    | Kyrgyzstan
    | Laos
    | Latvia
    | Lebanon
    | Lesotho
    | Liberia
    | Libya
    | Liechtenstein
    | Lithuania
    | Luxembourg
    | Macau
    | Macedonia
    | Madagascar
    | Malawi
    | Malaysia
    | Maldives
    | Mali
    | Malta
    | MarshallIslands
    | Mauritania
    | Mauritius
    | Mayotte
    | Mexico
    | Micronesia
    | Moldova
    | Monaco
    | Mongolia
    | Montenegro
    | Montserrat
    | Morocco
    | Mozambique
    | Myanmar
    | Namibia
    | Nauru
    | Nepal
    | Netherlands
    | NewCaledonia
    | NewZealand
    | Nicaragua
    | Niger
    | Nigeria
    | Niue
    | NorthKorea
    | NorthernMarianaIslands
    | Norway
    | Oman
    | Pakistan
    | Palau
    | Palestine
    | Panama
    | PapuaNewGuinea
    | Paraguay
    | Peru
    | Philippines
    | Pitcairn
    | Poland
    | Portugal
    | PuertoRico
    | Qatar
    | RepublicoftheCongo
    | Reunion
    | Romania
    | Russia
    | Rwanda
    | SaintBarthelemy
    | SaintHelena
    | SaintKittsandNevis
    | SaintLucia
    | SaintMartin
    | SaintPierreandMiquelon
    | SaintVincentandTheGrenadines
    | Samoa
    | SanMarino
    | SaoTomeandPrincipe
    | SaudiArabia
    | Senegal
    | Serbia
    | Seychelles
    | SierraLeone
    | Singapore
    | SintMaarten
    | Slovakia
    | Slovenia
    | SolomonIslands
    | Somalia
    | SouthAfrica
    | SouthKorea
    | SouthSudan
    | Spain
    | SriLanka
    | Sudan
    | Suriname
    | SvalbardandJanMayen
    | Swaziland
    | Sweden
    | Switzerland
    | Syria
    | Taiwan
    | Tajikistan
    | Tanzania
    | Thailand
    | Togo
    | Tokelau
    | Tonga
    | TrinidadandTobago
    | Tunisia
    | Turkey
    | Turkmenistan
    | TurksandCaicosIslands
    | Tuvalu
    | USVirginIslands
    | Uganda
    | Ukraine
    | UnitedArabEmirates
    | UnitedKingdom
    | UnitedStates
    | Uruguay
    | Uzbekistan
    | Vanuatu
    | Vatican
    | Venezuela
    | Vietnam
    | WallisandFutuna
    | WesternSahara
    | Yemen
    | Zambia
    | Zimbabwe


{-| -}
emptyFlag : String
emptyFlag =
    "🏳️"


{-| -}
list : List Country
list =
    [ Afghanistan, Albania, Algeria, AmericanSamoa, Andorra, Angola, Anguilla, Antarctica, AntiguaandBarbuda, Argentina, Armenia, Aruba, Australia, Austria, Azerbaijan, Bahamas, Bahrain, Bangladesh, Barbados, Belarus, Belgium, Belize, Benin, Bermuda, Bhutan, Bolivia, BosniaandHerzegovina, Botswana, Brazil, BritishIndianOceanTerritory, BritishVirginIslands, Brunei, Bulgaria, BurkinaFaso, Burundi, Cambodia, Cameroon, Canada, CapeVerde, CaymanIslands, CentralAfricanRepublic, Chad, Chile, China, ChristmasIsland, CocosIslands, Colombia, Comoros, CookIslands, CostaRica, Croatia, Cuba, Curacao, Cyprus, CzechRepublic, DemocraticRepublicoftheCongo, Denmark, Djibouti, Dominica, DominicanRepublic, EastTimor, Ecuador, Egypt, ElSalvador, EquatorialGuinea, Eritrea, Estonia, Ethiopia, FalklandIslands, FaroeIslands, Fiji, Finland, France, FrenchPolynesia, Gabon, Gambia, Georgia, Germany, Ghana, Gibraltar, Greece, Greenland, Grenada, Guam, Guatemala, Guernsey, Guinea, GuineaBissau, Guyana, Haiti, Honduras, HongKong, Hungary, Iceland, India, Indonesia, Iran, Iraq, Ireland, IsleofMan, Israel, Italy, IvoryCoast, Jamaica, Japan, Jersey, Jordan, Kazakhstan, Kenya, Kiribati, Kosovo, Kuwait, Kyrgyzstan, Laos, Latvia, Lebanon, Lesotho, Liberia, Libya, Liechtenstein, Lithuania, Luxembourg, Macau, Macedonia, Madagascar, Malawi, Malaysia, Maldives, Mali, Malta, MarshallIslands, Mauritania, Mauritius, Mayotte, Mexico, Micronesia, Moldova, Monaco, Mongolia, Montenegro, Montserrat, Morocco, Mozambique, Myanmar, Namibia, Nauru, Nepal, Netherlands, NewCaledonia, NewZealand, Nicaragua, Niger, Nigeria, Niue, NorthKorea, NorthernMarianaIslands, Norway, Oman, Pakistan, Palau, Palestine, Panama, PapuaNewGuinea, Paraguay, Peru, Philippines, Pitcairn, Poland, Portugal, PuertoRico, Qatar, RepublicoftheCongo, Reunion, Romania, Russia, Rwanda, SaintBarthelemy, SaintHelena, SaintKittsandNevis, SaintLucia, SaintMartin, SaintPierreandMiquelon, SaintVincentandTheGrenadines, Samoa, SanMarino, SaoTomeandPrincipe, SaudiArabia, Senegal, Serbia, Seychelles, SierraLeone, Singapore, SintMaarten, Slovakia, Slovenia, SolomonIslands, Somalia, SouthAfrica, SouthKorea, SouthSudan, Spain, SriLanka, Sudan, Suriname, SvalbardandJanMayen, Swaziland, Sweden, Switzerland, Syria, Taiwan, Tajikistan, Tanzania, Thailand, Togo, Tokelau, Tonga, TrinidadandTobago, Tunisia, Turkey, Turkmenistan, TurksandCaicosIslands, Tuvalu, USVirginIslands, Uganda, Ukraine, UnitedArabEmirates, UnitedKingdom, UnitedStates, Uruguay, Uzbekistan, Vanuatu, Vatican, Venezuela, Vietnam, WallisandFutuna, WesternSahara, Yemen, Zambia, Zimbabwe ]


{-| -}
listHead : Country
listHead =
    Afghanistan


{-| -}
listTail : Country
listTail =
    Zimbabwe


{-| -}
fromTelephoneAsString : String -> Maybe Country
fromTelephoneAsString telephone =
    --
    -- Check also Flow.FormStateBeforeValidationFixer.cleanPhoneNumber for inspirations
    --
    -- Max length of prefix is 7, for Example: "+6189164"
    telephone
        -- Trim empty space on both sides
        |> String.Extra.clean
        -- Max length of prefix is 7, for Example: "+6189164"
        |> String.left 8
        -- Generate a list like ["+6","+61","+618","+6189","+61891","+618916","+6189164"]
        |> generatePrefixes []
        -- Generate a list like ["+6189164","+618916","+61891","+6189","+618","+61","+6"]
        |> List.reverse
        -- Search the phone
        |> List.foldl
            (\string acc ->
                case acc of
                    Just _ ->
                        -- Short circuit
                        acc

                    Nothing ->
                        fromCountryTelCode string
            )
            Nothing


generatePrefixes : List String -> String -> List String
generatePrefixes listPrefixes telephone =
    if String.length telephone <= 1 then
        listPrefixes

    else
        generatePrefixes (telephone :: listPrefixes) (String.dropRight 1 telephone)


{-| -}
fromString : String -> Maybe Country
fromString str =
    case str of
        "Afghanistan" ->
            Just Afghanistan

        "Albania" ->
            Just Albania

        "Algeria" ->
            Just Algeria

        "American Samoa" ->
            Just AmericanSamoa

        "Andorra" ->
            Just Andorra

        "Angola" ->
            Just Angola

        "Anguilla" ->
            Just Anguilla

        "Antarctica" ->
            Just Antarctica

        "Antigua and Barbuda" ->
            Just AntiguaandBarbuda

        "Argentina" ->
            Just Argentina

        "Armenia" ->
            Just Armenia

        "Aruba" ->
            Just Aruba

        "Australia" ->
            Just Australia

        "Austria" ->
            Just Austria

        "Azerbaijan" ->
            Just Azerbaijan

        "Bahamas" ->
            Just Bahamas

        "Bahrain" ->
            Just Bahrain

        "Bangladesh" ->
            Just Bangladesh

        "Barbados" ->
            Just Barbados

        "Belarus" ->
            Just Belarus

        "Belgium" ->
            Just Belgium

        "Belize" ->
            Just Belize

        "Benin" ->
            Just Benin

        "Bermuda" ->
            Just Bermuda

        "Bhutan" ->
            Just Bhutan

        "Bolivia" ->
            Just Bolivia

        "Bosnia and Herzegovina" ->
            Just BosniaandHerzegovina

        "Botswana" ->
            Just Botswana

        "Brazil" ->
            Just Brazil

        "British Indian Ocean Territory" ->
            Just BritishIndianOceanTerritory

        "British Virgin Islands" ->
            Just BritishVirginIslands

        "Brunei" ->
            Just Brunei

        "Bulgaria" ->
            Just Bulgaria

        "Burkina Faso" ->
            Just BurkinaFaso

        "Burundi" ->
            Just Burundi

        "Cambodia" ->
            Just Cambodia

        "Cameroon" ->
            Just Cameroon

        "Canada" ->
            Just Canada

        "Cape Verde" ->
            Just CapeVerde

        "Cayman Islands" ->
            Just CaymanIslands

        "Central African Republic" ->
            Just CentralAfricanRepublic

        "Chad" ->
            Just Chad

        "Chile" ->
            Just Chile

        "China" ->
            Just China

        "Christmas Island" ->
            Just ChristmasIsland

        "Cocos Islands" ->
            Just CocosIslands

        "Colombia" ->
            Just Colombia

        "Comoros" ->
            Just Comoros

        "Cook Islands" ->
            Just CookIslands

        "Costa Rica" ->
            Just CostaRica

        "Croatia" ->
            Just Croatia

        "Cuba" ->
            Just Cuba

        "Curacao" ->
            Just Curacao

        "Cyprus" ->
            Just Cyprus

        "Czech Republic" ->
            Just CzechRepublic

        "Democratic Republic of the Congo" ->
            Just DemocraticRepublicoftheCongo

        "Denmark" ->
            Just Denmark

        "Djibouti" ->
            Just Djibouti

        "Dominica" ->
            Just Dominica

        "Dominican Republic" ->
            Just DominicanRepublic

        "East Timor" ->
            Just EastTimor

        "Ecuador" ->
            Just Ecuador

        "Egypt" ->
            Just Egypt

        "El Salvador" ->
            Just ElSalvador

        "Equatorial Guinea" ->
            Just EquatorialGuinea

        "Eritrea" ->
            Just Eritrea

        "Estonia" ->
            Just Estonia

        "Ethiopia" ->
            Just Ethiopia

        "Falkland Islands" ->
            Just FalklandIslands

        "Faroe Islands" ->
            Just FaroeIslands

        "Fiji" ->
            Just Fiji

        "Finland" ->
            Just Finland

        "France" ->
            Just France

        "French Polynesia" ->
            Just FrenchPolynesia

        "Gabon" ->
            Just Gabon

        "Gambia" ->
            Just Gambia

        "Georgia" ->
            Just Georgia

        "Germany" ->
            Just Germany

        "Ghana" ->
            Just Ghana

        "Gibraltar" ->
            Just Gibraltar

        "Greece" ->
            Just Greece

        "Greenland" ->
            Just Greenland

        "Grenada" ->
            Just Grenada

        "Guam" ->
            Just Guam

        "Guatemala" ->
            Just Guatemala

        "Guernsey" ->
            Just Guernsey

        "Guinea" ->
            Just Guinea

        "Guinea-Bissau" ->
            Just GuineaBissau

        "Guyana" ->
            Just Guyana

        "Haiti" ->
            Just Haiti

        "Honduras" ->
            Just Honduras

        "Hong Kong" ->
            Just HongKong

        "Hungary" ->
            Just Hungary

        "Iceland" ->
            Just Iceland

        "India" ->
            Just India

        "Indonesia" ->
            Just Indonesia

        "Iran" ->
            Just Iran

        "Iraq" ->
            Just Iraq

        "Ireland" ->
            Just Ireland

        "Isle of Man" ->
            Just IsleofMan

        "Israel" ->
            Just Israel

        "Italy" ->
            Just Italy

        "Ivory Coast" ->
            Just IvoryCoast

        "Jamaica" ->
            Just Jamaica

        "Japan" ->
            Just Japan

        "Jersey" ->
            Just Jersey

        "Jordan" ->
            Just Jordan

        "Kazakhstan" ->
            Just Kazakhstan

        "Kenya" ->
            Just Kenya

        "Kiribati" ->
            Just Kiribati

        "Kosovo" ->
            Just Kosovo

        "Kuwait" ->
            Just Kuwait

        "Kyrgyzstan" ->
            Just Kyrgyzstan

        "Laos" ->
            Just Laos

        "Latvia" ->
            Just Latvia

        "Lebanon" ->
            Just Lebanon

        "Lesotho" ->
            Just Lesotho

        "Liberia" ->
            Just Liberia

        "Libya" ->
            Just Libya

        "Liechtenstein" ->
            Just Liechtenstein

        "Lithuania" ->
            Just Lithuania

        "Luxembourg" ->
            Just Luxembourg

        "Macau" ->
            Just Macau

        "Macedonia" ->
            Just Macedonia

        "Madagascar" ->
            Just Madagascar

        "Malawi" ->
            Just Malawi

        "Malaysia" ->
            Just Malaysia

        "Maldives" ->
            Just Maldives

        "Mali" ->
            Just Mali

        "Malta" ->
            Just Malta

        "Marshall Islands" ->
            Just MarshallIslands

        "Mauritania" ->
            Just Mauritania

        "Mauritius" ->
            Just Mauritius

        "Mayotte" ->
            Just Mayotte

        "Mexico" ->
            Just Mexico

        "Micronesia" ->
            Just Micronesia

        "Moldova" ->
            Just Moldova

        "Monaco" ->
            Just Monaco

        "Mongolia" ->
            Just Mongolia

        "Montenegro" ->
            Just Montenegro

        "Montserrat" ->
            Just Montserrat

        "Morocco" ->
            Just Morocco

        "Mozambique" ->
            Just Mozambique

        "Myanmar" ->
            Just Myanmar

        "Namibia" ->
            Just Namibia

        "Nauru" ->
            Just Nauru

        "Nepal" ->
            Just Nepal

        "Netherlands" ->
            Just Netherlands

        "New Caledonia" ->
            Just NewCaledonia

        "New Zealand" ->
            Just NewZealand

        "Nicaragua" ->
            Just Nicaragua

        "Niger" ->
            Just Niger

        "Nigeria" ->
            Just Nigeria

        "Niue" ->
            Just Niue

        "North Korea" ->
            Just NorthKorea

        "Northern Mariana Islands" ->
            Just NorthernMarianaIslands

        "Norway" ->
            Just Norway

        "Oman" ->
            Just Oman

        "Pakistan" ->
            Just Pakistan

        "Palau" ->
            Just Palau

        "Palestine" ->
            Just Palestine

        "Panama" ->
            Just Panama

        "Papua New Guinea" ->
            Just PapuaNewGuinea

        "Paraguay" ->
            Just Paraguay

        "Peru" ->
            Just Peru

        "Philippines" ->
            Just Philippines

        "Pitcairn" ->
            Just Pitcairn

        "Poland" ->
            Just Poland

        "Portugal" ->
            Just Portugal

        "Puerto Rico" ->
            Just PuertoRico

        "Qatar" ->
            Just Qatar

        "Republic of the Congo" ->
            Just RepublicoftheCongo

        "Reunion" ->
            Just Reunion

        "Romania" ->
            Just Romania

        "Russia" ->
            Just Russia

        "Rwanda" ->
            Just Rwanda

        "Saint Barthelemy" ->
            Just SaintBarthelemy

        "Saint Helena" ->
            Just SaintHelena

        "Saint Kitts and Nevis" ->
            Just SaintKittsandNevis

        "Saint Lucia" ->
            Just SaintLucia

        "Saint Martin" ->
            Just SaintMartin

        "Saint Pierre and Miquelon" ->
            Just SaintPierreandMiquelon

        "Saint Vincent and The Grenadines" ->
            Just SaintVincentandTheGrenadines

        "Samoa" ->
            Just Samoa

        "San Marino" ->
            Just SanMarino

        "Sao Tome and Principe" ->
            Just SaoTomeandPrincipe

        "Saudi Arabia" ->
            Just SaudiArabia

        "Senegal" ->
            Just Senegal

        "Serbia" ->
            Just Serbia

        "Seychelles" ->
            Just Seychelles

        "Sierra Leone" ->
            Just SierraLeone

        "Singapore" ->
            Just Singapore

        "Sint Maarten" ->
            Just SintMaarten

        "Slovakia" ->
            Just Slovakia

        "Slovenia" ->
            Just Slovenia

        "Solomon Islands" ->
            Just SolomonIslands

        "Somalia" ->
            Just Somalia

        "South Africa" ->
            Just SouthAfrica

        "South Korea" ->
            Just SouthKorea

        "South Sudan" ->
            Just SouthSudan

        "Spain" ->
            Just Spain

        "Sri Lanka" ->
            Just SriLanka

        "Sudan" ->
            Just Sudan

        "Suriname" ->
            Just Suriname

        "Svalbard and Jan Mayen" ->
            Just SvalbardandJanMayen

        "Swaziland" ->
            Just Swaziland

        "Sweden" ->
            Just Sweden

        "Switzerland" ->
            Just Switzerland

        "Syria" ->
            Just Syria

        "Taiwan" ->
            Just Taiwan

        "Tajikistan" ->
            Just Tajikistan

        "Tanzania" ->
            Just Tanzania

        "Thailand" ->
            Just Thailand

        "Togo" ->
            Just Togo

        "Tokelau" ->
            Just Tokelau

        "Tonga" ->
            Just Tonga

        "Trinidad and Tobago" ->
            Just TrinidadandTobago

        "Tunisia" ->
            Just Tunisia

        "Turkey" ->
            Just Turkey

        "Turkmenistan" ->
            Just Turkmenistan

        "Turks and Caicos Islands" ->
            Just TurksandCaicosIslands

        "Tuvalu" ->
            Just Tuvalu

        "U.S. Virgin Islands" ->
            Just USVirginIslands

        "Uganda" ->
            Just Uganda

        "Ukraine" ->
            Just Ukraine

        "United Arab Emirates" ->
            Just UnitedArabEmirates

        "United Kingdom" ->
            Just UnitedKingdom

        "United States" ->
            Just UnitedStates

        "Uruguay" ->
            Just Uruguay

        "Uzbekistan" ->
            Just Uzbekistan

        "Vanuatu" ->
            Just Vanuatu

        "Vatican" ->
            Just Vatican

        "Venezuela" ->
            Just Venezuela

        "Vietnam" ->
            Just Vietnam

        "Wallis and Futuna" ->
            Just WallisandFutuna

        "Western Sahara" ->
            Just WesternSahara

        "Yemen" ->
            Just Yemen

        "Zambia" ->
            Just Zambia

        "Zimbabwe" ->
            Just Zimbabwe

        _ ->
            Nothing


{-| -}
fromCountryTelCode : String -> Maybe Country
fromCountryTelCode code =
    case code of
        "+93" ->
            Just Afghanistan

        "+355" ->
            Just Albania

        "+213" ->
            Just Algeria

        "+1684" ->
            Just AmericanSamoa

        "+376" ->
            Just Andorra

        "+244" ->
            Just Angola

        "+1264" ->
            Just Anguilla

        "+672" ->
            Just Antarctica

        "+1268" ->
            Just AntiguaandBarbuda

        "+54" ->
            Just Argentina

        "+374" ->
            Just Armenia

        "+297" ->
            Just Aruba

        "+61" ->
            Just Australia

        "+43" ->
            Just Austria

        "+994" ->
            Just Azerbaijan

        "+1242" ->
            Just Bahamas

        "+973" ->
            Just Bahrain

        "+880" ->
            Just Bangladesh

        "+1246" ->
            Just Barbados

        "+375" ->
            Just Belarus

        "+32" ->
            Just Belgium

        "+501" ->
            Just Belize

        "+229" ->
            Just Benin

        "+1441" ->
            Just Bermuda

        "+975" ->
            Just Bhutan

        "+591" ->
            Just Bolivia

        "+387" ->
            Just BosniaandHerzegovina

        "+267" ->
            Just Botswana

        "+55" ->
            Just Brazil

        "+246" ->
            Just BritishIndianOceanTerritory

        "+1284" ->
            Just BritishVirginIslands

        "+673" ->
            Just Brunei

        "+359" ->
            Just Bulgaria

        "+226" ->
            Just BurkinaFaso

        "+257" ->
            Just Burundi

        "+855" ->
            Just Cambodia

        "+237" ->
            Just Cameroon

        -- Same as US
        --"+1" ->
        --    Just Canada
        "+238" ->
            Just CapeVerde

        "+1345" ->
            Just CaymanIslands

        "+236" ->
            Just CentralAfricanRepublic

        "+235" ->
            Just Chad

        "+56" ->
            Just Chile

        "+86" ->
            Just China

        "+6189164" ->
            Just ChristmasIsland

        "+6189162" ->
            Just CocosIslands

        "+57" ->
            Just Colombia

        "+269" ->
            Just Comoros

        "+682" ->
            Just CookIslands

        "+506" ->
            Just CostaRica

        "+385" ->
            Just Croatia

        "+53" ->
            Just Cuba

        "+599" ->
            Just Curacao

        "+357" ->
            Just Cyprus

        "+420" ->
            Just CzechRepublic

        "+243" ->
            Just DemocraticRepublicoftheCongo

        "+45" ->
            Just Denmark

        "+253" ->
            Just Djibouti

        "+1767" ->
            Just Dominica

        "+1809" ->
            Just DominicanRepublic

        "+1829" ->
            Just DominicanRepublic

        "+1849" ->
            Just DominicanRepublic

        "+670" ->
            Just EastTimor

        "+593" ->
            Just Ecuador

        "+20" ->
            Just Egypt

        "+503" ->
            Just ElSalvador

        "+240" ->
            Just EquatorialGuinea

        "+291" ->
            Just Eritrea

        "+372" ->
            Just Estonia

        "+251" ->
            Just Ethiopia

        "+500" ->
            Just FalklandIslands

        "+298" ->
            Just FaroeIslands

        "+679" ->
            Just Fiji

        "+358" ->
            Just Finland

        "+33" ->
            Just France

        "+689" ->
            Just FrenchPolynesia

        "+241" ->
            Just Gabon

        "+220" ->
            Just Gambia

        "+995" ->
            Just Georgia

        "+49" ->
            Just Germany

        "+233" ->
            Just Ghana

        "+350" ->
            Just Gibraltar

        "+30" ->
            Just Greece

        "+299" ->
            Just Greenland

        "+1473" ->
            Just Grenada

        "+1671" ->
            Just Guam

        "+502" ->
            Just Guatemala

        "+441481" ->
            Just Guernsey

        "+224" ->
            Just Guinea

        "+245" ->
            Just GuineaBissau

        "+592" ->
            Just Guyana

        "+509" ->
            Just Haiti

        "+504" ->
            Just Honduras

        "+852" ->
            Just HongKong

        "+36" ->
            Just Hungary

        "+354" ->
            Just Iceland

        "+91" ->
            Just India

        "+62" ->
            Just Indonesia

        "+98" ->
            Just Iran

        "+964" ->
            Just Iraq

        "+353" ->
            Just Ireland

        "+441624" ->
            Just IsleofMan

        "+972" ->
            Just Israel

        "+39" ->
            Just Italy

        "+225" ->
            Just IvoryCoast

        "+1876" ->
            Just Jamaica

        "+81" ->
            Just Japan

        "+441534" ->
            Just Jersey

        "+962" ->
            Just Jordan

        -- Same as Russia [https://en.wikipedia.org/wiki/List_of_country_calling_codes#cite_note-zone7-6]
        --"+7" ->
        --    Just Kazakhstan
        "+254" ->
            Just Kenya

        "+686" ->
            Just Kiribati

        "+383" ->
            Just Kosovo

        "+965" ->
            Just Kuwait

        "+996" ->
            Just Kyrgyzstan

        "+856" ->
            Just Laos

        "+371" ->
            Just Latvia

        "+961" ->
            Just Lebanon

        "+266" ->
            Just Lesotho

        "+231" ->
            Just Liberia

        "+218" ->
            Just Libya

        "+423" ->
            Just Liechtenstein

        "+370" ->
            Just Lithuania

        "+352" ->
            Just Luxembourg

        "+853" ->
            Just Macau

        "+389" ->
            Just Macedonia

        "+261" ->
            Just Madagascar

        "+265" ->
            Just Malawi

        "+60" ->
            Just Malaysia

        "+960" ->
            Just Maldives

        "+223" ->
            Just Mali

        "+356" ->
            Just Malta

        "+692" ->
            Just MarshallIslands

        "+222" ->
            Just Mauritania

        "+230" ->
            Just Mauritius

        "+262269" ->
            Just Mayotte

        "+262639" ->
            Just Mayotte

        "+52" ->
            Just Mexico

        "+691" ->
            Just Micronesia

        "+373" ->
            Just Moldova

        "+377" ->
            Just Monaco

        "+976" ->
            Just Mongolia

        "+382" ->
            Just Montenegro

        "+1664" ->
            Just Montserrat

        "+212" ->
            Just Morocco

        "+258" ->
            Just Mozambique

        "+95" ->
            Just Myanmar

        "+264" ->
            Just Namibia

        "+674" ->
            Just Nauru

        "+977" ->
            Just Nepal

        "+31" ->
            Just Netherlands

        "+687" ->
            Just NewCaledonia

        "+64" ->
            Just NewZealand

        "+505" ->
            Just Nicaragua

        "+227" ->
            Just Niger

        "+234" ->
            Just Nigeria

        "+683" ->
            Just Niue

        "+850" ->
            Just NorthKorea

        "+1670" ->
            Just NorthernMarianaIslands

        "+47" ->
            Just Norway

        "+968" ->
            Just Oman

        "+92" ->
            Just Pakistan

        "+680" ->
            Just Palau

        "+970" ->
            Just Palestine

        "+507" ->
            Just Panama

        "+675" ->
            Just PapuaNewGuinea

        "+595" ->
            Just Paraguay

        "+51" ->
            Just Peru

        "+63" ->
            Just Philippines

        -- "no Code" https://en.wikipedia.org/wiki/List_of_country_calling_codes
        --"+64" ->
        --    Just Pitcairn
        "+48" ->
            Just Poland

        "+351" ->
            Just Portugal

        "+1787" ->
            Just PuertoRico

        "+1939" ->
            Just PuertoRico

        "+974" ->
            Just Qatar

        "+242" ->
            Just RepublicoftheCongo

        "+262" ->
            Just Reunion

        "+40" ->
            Just Romania

        "+7" ->
            Just Russia

        "+250" ->
            Just Rwanda

        -- same as Guadeloupe [https://en.wikipedia.org/wiki/List_of_country_calling_codes]
        --"+590" ->
        --    Just SaintBarthelemy
        "+290" ->
            Just SaintHelena

        "+1869" ->
            Just SaintKittsandNevis

        "+1758" ->
            Just SaintLucia

        -- same as Guadeloupe [https://en.wikipedia.org/wiki/List_of_country_calling_codes]
        --"+590" ->
        --    Just SaintMartin
        "+508" ->
            Just SaintPierreandMiquelon

        "+1784" ->
            Just SaintVincentandTheGrenadines

        "+685" ->
            Just Samoa

        "+378" ->
            Just SanMarino

        "+239" ->
            Just SaoTomeandPrincipe

        "+966" ->
            Just SaudiArabia

        "+221" ->
            Just Senegal

        "+381" ->
            Just Serbia

        "+248" ->
            Just Seychelles

        "+232" ->
            Just SierraLeone

        "+65" ->
            Just Singapore

        "+1721" ->
            Just SintMaarten

        "+421" ->
            Just Slovakia

        "+386" ->
            Just Slovenia

        "+677" ->
            Just SolomonIslands

        "+252" ->
            Just Somalia

        "+27" ->
            Just SouthAfrica

        "+82" ->
            Just SouthKorea

        "+211" ->
            Just SouthSudan

        "+34" ->
            Just Spain

        "+94" ->
            Just SriLanka

        "+249" ->
            Just Sudan

        "+597" ->
            Just Suriname

        "+4779" ->
            Just SvalbardandJanMayen

        "+268" ->
            Just Swaziland

        "+46" ->
            Just Sweden

        "+41" ->
            Just Switzerland

        "+963" ->
            Just Syria

        "+886" ->
            Just Taiwan

        "+992" ->
            Just Tajikistan

        "+255" ->
            Just Tanzania

        "+66" ->
            Just Thailand

        "+228" ->
            Just Togo

        "+690" ->
            Just Tokelau

        "+676" ->
            Just Tonga

        "+1868" ->
            Just TrinidadandTobago

        "+216" ->
            Just Tunisia

        "+90" ->
            Just Turkey

        "+993" ->
            Just Turkmenistan

        "+1649" ->
            Just TurksandCaicosIslands

        "+688" ->
            Just Tuvalu

        "+1340" ->
            Just USVirginIslands

        "+256" ->
            Just Uganda

        "+380" ->
            Just Ukraine

        "+971" ->
            Just UnitedArabEmirates

        "+44" ->
            Just UnitedKingdom

        "+1" ->
            Just UnitedStates

        "+598" ->
            Just Uruguay

        "+998" ->
            Just Uzbekistan

        "+678" ->
            Just Vanuatu

        "+379" ->
            Just Vatican

        "+58" ->
            Just Venezuela

        "+84" ->
            Just Vietnam

        "+681" ->
            Just WallisandFutuna

        -- same as Morocco
        --"+212" ->
        --    Just WesternSahara
        "+967" ->
            Just Yemen

        "+260" ->
            Just Zambia

        "+263" ->
            Just Zimbabwe

        _ ->
            Nothing


{-| -}
toFlag : Country -> String
toFlag country =
    case country of
        Afghanistan ->
            "🇦🇫"

        Albania ->
            "🇦🇱"

        Algeria ->
            "🇩🇿"

        AmericanSamoa ->
            "🇦🇸"

        Andorra ->
            "🇦🇩"

        Angola ->
            "🇦🇴"

        Anguilla ->
            "🇦🇮"

        Antarctica ->
            "🇦🇶"

        AntiguaandBarbuda ->
            "🇦🇬"

        Argentina ->
            "🇦🇷"

        Armenia ->
            "🇦🇲"

        Aruba ->
            "🇦🇼"

        Australia ->
            "🇦🇺"

        Austria ->
            "🇦🇹"

        Azerbaijan ->
            "🇦🇿"

        Bahamas ->
            "🇧🇸"

        Bahrain ->
            "🇧🇭"

        Bangladesh ->
            "🇧🇩"

        Barbados ->
            "🇧🇧"

        Belarus ->
            "🇧🇾"

        Belgium ->
            "🇧🇪"

        Belize ->
            "🇧🇿"

        Benin ->
            "🇧🇯"

        Bermuda ->
            "🇧🇲"

        Bhutan ->
            "🇧🇹"

        Bolivia ->
            "🇧🇴"

        BosniaandHerzegovina ->
            "🇧🇦"

        Botswana ->
            "🇧🇼"

        Brazil ->
            "🇧🇷"

        BritishIndianOceanTerritory ->
            "🇮🇴"

        BritishVirginIslands ->
            "🇻🇬"

        Brunei ->
            "🇧🇳"

        Bulgaria ->
            "🇧🇬"

        BurkinaFaso ->
            "🇧🇫"

        Burundi ->
            "🇧🇮"

        Cambodia ->
            "🇰🇭"

        Cameroon ->
            "🇨🇲"

        Canada ->
            "🇨🇦"

        CapeVerde ->
            "🇨🇻"

        CaymanIslands ->
            "🇰🇾"

        CentralAfricanRepublic ->
            "🇨🇫"

        Chad ->
            "🇹🇩"

        Chile ->
            "🇨🇱"

        China ->
            "🇨🇳"

        ChristmasIsland ->
            "🇨🇽"

        CocosIslands ->
            "🇨🇨"

        Colombia ->
            "🇨🇴"

        Comoros ->
            "🇰🇲"

        CookIslands ->
            "🇨🇰"

        CostaRica ->
            "🇨🇷"

        Croatia ->
            "🇭🇷"

        Cuba ->
            "🇨🇺"

        Curacao ->
            "🇨🇼"

        Cyprus ->
            "🇨🇾"

        CzechRepublic ->
            "🇨🇿"

        DemocraticRepublicoftheCongo ->
            "🇨🇩"

        Denmark ->
            "🇩🇰"

        Djibouti ->
            "🇩🇯"

        Dominica ->
            "🇩🇲"

        DominicanRepublic ->
            "🇩🇴"

        EastTimor ->
            "🇹🇱"

        Ecuador ->
            "🇪🇨"

        Egypt ->
            "🇪🇬"

        ElSalvador ->
            "🇸🇻"

        EquatorialGuinea ->
            "🇬🇶"

        Eritrea ->
            "🇪🇷"

        Estonia ->
            "🇪🇪"

        Ethiopia ->
            "🇪🇹"

        FalklandIslands ->
            "🇫🇰"

        FaroeIslands ->
            "🇫🇴"

        Fiji ->
            "🇫🇯"

        Finland ->
            "🇫🇮"

        France ->
            "🇫🇷"

        FrenchPolynesia ->
            "🇵🇫"

        Gabon ->
            "🇬🇦"

        Gambia ->
            "🇬🇲"

        Georgia ->
            "🇬🇪"

        Germany ->
            "🇩🇪"

        Ghana ->
            "🇬🇭"

        Gibraltar ->
            "🇬🇮"

        Greece ->
            "🇬🇷"

        Greenland ->
            "🇬🇱"

        Grenada ->
            "🇬🇩"

        Guam ->
            "🇬🇺"

        Guatemala ->
            "🇬🇹"

        Guernsey ->
            "🇬🇬"

        Guinea ->
            "🇬🇳"

        GuineaBissau ->
            "🇬🇼"

        Guyana ->
            "🇬🇾"

        Haiti ->
            "🇭🇹"

        Honduras ->
            "🇭🇳"

        HongKong ->
            "🇭🇰"

        Hungary ->
            "🇭🇺"

        Iceland ->
            "🇮🇸"

        India ->
            "🇮🇳"

        Indonesia ->
            "🇮🇩"

        Iran ->
            "🇮🇷"

        Iraq ->
            "🇮🇶"

        Ireland ->
            "🇮🇪"

        IsleofMan ->
            "🇮🇲"

        Israel ->
            "🇮🇱"

        Italy ->
            "🇮🇹"

        IvoryCoast ->
            "🇨🇮"

        Jamaica ->
            "🇯🇲"

        Japan ->
            "🇯🇵"

        Jersey ->
            "🇯🇪"

        Jordan ->
            "🇯🇴"

        Kazakhstan ->
            "🇰🇿"

        Kenya ->
            "🇰🇪"

        Kiribati ->
            "🇰🇮"

        Kosovo ->
            "🇽🇰"

        Kuwait ->
            "🇰🇼"

        Kyrgyzstan ->
            "🇰🇬"

        Laos ->
            "🇱🇦"

        Latvia ->
            "🇱🇻"

        Lebanon ->
            "🇱🇧"

        Lesotho ->
            "🇱🇸"

        Liberia ->
            "🇱🇷"

        Libya ->
            "🇱🇾"

        Liechtenstein ->
            "🇱🇮"

        Lithuania ->
            "🇱🇹"

        Luxembourg ->
            "🇱🇺"

        Macau ->
            "🇲🇴"

        Macedonia ->
            "🇲🇰"

        Madagascar ->
            "🇲🇬"

        Malawi ->
            "🇲🇼"

        Malaysia ->
            "🇲🇾"

        Maldives ->
            "🇲🇻"

        Mali ->
            "🇲🇱"

        Malta ->
            "🇲🇹"

        MarshallIslands ->
            "🇲🇭"

        Mauritania ->
            "🇲🇷"

        Mauritius ->
            "🇲🇺"

        Mayotte ->
            "🇾🇹"

        Mexico ->
            "🇲🇽"

        Micronesia ->
            "🇫🇲"

        Moldova ->
            "🇲🇩"

        Monaco ->
            "🇲🇨"

        Mongolia ->
            "🇲🇳"

        Montenegro ->
            "🇲🇪"

        Montserrat ->
            "🇲🇸"

        Morocco ->
            "🇲🇦"

        Mozambique ->
            "🇲🇿"

        Myanmar ->
            "🇲🇲"

        Namibia ->
            "🇳🇦"

        Nauru ->
            "🇳🇷"

        Nepal ->
            "🇳🇵"

        Netherlands ->
            "🇳🇱"

        NewCaledonia ->
            "🇳🇨"

        NewZealand ->
            "🇳🇿"

        Nicaragua ->
            "🇳🇮"

        Niger ->
            "🇳🇪"

        Nigeria ->
            "🇳🇬"

        Niue ->
            "🇳🇺"

        NorthKorea ->
            "🇰🇵"

        NorthernMarianaIslands ->
            "🇲🇵"

        Norway ->
            "🇳🇴"

        Oman ->
            "🇴🇲"

        Pakistan ->
            "🇵🇰"

        Palau ->
            "🇵🇼"

        Palestine ->
            "🇵🇸"

        Panama ->
            "🇵🇦"

        PapuaNewGuinea ->
            "🇵🇬"

        Paraguay ->
            "🇵🇾"

        Peru ->
            "🇵🇪"

        Philippines ->
            "🇵🇭"

        Pitcairn ->
            "🇵🇳"

        Poland ->
            "🇵🇱"

        Portugal ->
            "🇵🇹"

        PuertoRico ->
            "🇵🇷"

        Qatar ->
            "🇶🇦"

        RepublicoftheCongo ->
            "🇨🇬"

        Reunion ->
            "🇷🇪"

        Romania ->
            "🇷🇴"

        Russia ->
            "🇷🇺"

        Rwanda ->
            "🇷🇼"

        SaintBarthelemy ->
            "🇧🇱"

        SaintHelena ->
            "🇸🇭"

        SaintKittsandNevis ->
            "🇰🇳"

        SaintLucia ->
            "🇱🇨"

        SaintMartin ->
            "🇲🇫"

        SaintPierreandMiquelon ->
            "🇵🇲"

        SaintVincentandTheGrenadines ->
            "🇻🇨"

        Samoa ->
            "🇼🇸"

        SanMarino ->
            "🇸🇲"

        SaoTomeandPrincipe ->
            "🇸🇹"

        SaudiArabia ->
            "🇸🇦"

        Senegal ->
            "🇸🇳"

        Serbia ->
            "🇷🇸"

        Seychelles ->
            "🇸🇨"

        SierraLeone ->
            "🇸🇱"

        Singapore ->
            "🇸🇬"

        SintMaarten ->
            "🇸🇽"

        Slovakia ->
            "🇸🇰"

        Slovenia ->
            "🇸🇮"

        SolomonIslands ->
            "🇸🇧"

        Somalia ->
            "🇸🇴"

        SouthAfrica ->
            "🇿🇦"

        SouthKorea ->
            "🇰🇷"

        SouthSudan ->
            "🇸🇸"

        Spain ->
            "🇪🇸"

        SriLanka ->
            "🇱🇰"

        Sudan ->
            "🇸🇩"

        Suriname ->
            "🇸🇷"

        SvalbardandJanMayen ->
            "🇸🇯"

        Swaziland ->
            "🇸🇿"

        Sweden ->
            "🇸🇪"

        Switzerland ->
            "🇨🇭"

        Syria ->
            "🇸🇾"

        Taiwan ->
            "🇹🇼"

        Tajikistan ->
            "🇹🇯"

        Tanzania ->
            "🇹🇿"

        Thailand ->
            "🇹🇭"

        Togo ->
            "🇹🇬"

        Tokelau ->
            "🇹🇰"

        Tonga ->
            "🇹🇴"

        TrinidadandTobago ->
            "🇹🇹"

        Tunisia ->
            "🇹🇳"

        Turkey ->
            "🇹🇷"

        Turkmenistan ->
            "🇹🇲"

        TurksandCaicosIslands ->
            "🇹🇨"

        Tuvalu ->
            "🇹🇻"

        USVirginIslands ->
            "🇻🇮"

        Uganda ->
            "🇺🇬"

        Ukraine ->
            "🇺🇦"

        UnitedArabEmirates ->
            "🇦🇪"

        UnitedKingdom ->
            "🇬🇧"

        UnitedStates ->
            "🇺🇸"

        Uruguay ->
            "🇺🇾"

        Uzbekistan ->
            "🇺🇿"

        Vanuatu ->
            "🇻🇺"

        Vatican ->
            "🇻🇦"

        Venezuela ->
            "🇻🇪"

        Vietnam ->
            "🇻🇳"

        WallisandFutuna ->
            "🇼🇫"

        WesternSahara ->
            "🇪🇭"

        Yemen ->
            "🇾🇪"

        Zambia ->
            "🇿🇲"

        Zimbabwe ->
            "🇿🇼"


{-| -}
toString : Country -> String
toString country =
    case country of
        Afghanistan ->
            "Afghanistan"

        Albania ->
            "Albania"

        Algeria ->
            "Algeria"

        AmericanSamoa ->
            "American Samoa"

        Andorra ->
            "Andorra"

        Angola ->
            "Angola"

        Anguilla ->
            "Anguilla"

        Antarctica ->
            "Antarctica"

        AntiguaandBarbuda ->
            "Antigua and Barbuda"

        Argentina ->
            "Argentina"

        Armenia ->
            "Armenia"

        Aruba ->
            "Aruba"

        Australia ->
            "Australia"

        Austria ->
            "Austria"

        Azerbaijan ->
            "Azerbaijan"

        Bahamas ->
            "Bahamas"

        Bahrain ->
            "Bahrain"

        Bangladesh ->
            "Bangladesh"

        Barbados ->
            "Barbados"

        Belarus ->
            "Belarus"

        Belgium ->
            "Belgium"

        Belize ->
            "Belize"

        Benin ->
            "Benin"

        Bermuda ->
            "Bermuda"

        Bhutan ->
            "Bhutan"

        Bolivia ->
            "Bolivia"

        BosniaandHerzegovina ->
            "Bosnia and Herzegovina"

        Botswana ->
            "Botswana"

        Brazil ->
            "Brazil"

        BritishIndianOceanTerritory ->
            "British Indian Ocean Territory"

        BritishVirginIslands ->
            "British Virgin Islands"

        Brunei ->
            "Brunei"

        Bulgaria ->
            "Bulgaria"

        BurkinaFaso ->
            "Burkina Faso"

        Burundi ->
            "Burundi"

        Cambodia ->
            "Cambodia"

        Cameroon ->
            "Cameroon"

        Canada ->
            "Canada"

        CapeVerde ->
            "Cape Verde"

        CaymanIslands ->
            "Cayman Islands"

        CentralAfricanRepublic ->
            "Central African Republic"

        Chad ->
            "Chad"

        Chile ->
            "Chile"

        China ->
            "China"

        ChristmasIsland ->
            "Christmas Island"

        CocosIslands ->
            "Cocos Islands"

        Colombia ->
            "Colombia"

        Comoros ->
            "Comoros"

        CookIslands ->
            "Cook Islands"

        CostaRica ->
            "Costa Rica"

        Croatia ->
            "Croatia"

        Cuba ->
            "Cuba"

        Curacao ->
            "Curacao"

        Cyprus ->
            "Cyprus"

        CzechRepublic ->
            "Czech Republic"

        DemocraticRepublicoftheCongo ->
            "Democratic Republic of the Congo"

        Denmark ->
            "Denmark"

        Djibouti ->
            "Djibouti"

        Dominica ->
            "Dominica"

        DominicanRepublic ->
            "Dominican Republic"

        EastTimor ->
            "East Timor"

        Ecuador ->
            "Ecuador"

        Egypt ->
            "Egypt"

        ElSalvador ->
            "El Salvador"

        EquatorialGuinea ->
            "Equatorial Guinea"

        Eritrea ->
            "Eritrea"

        Estonia ->
            "Estonia"

        Ethiopia ->
            "Ethiopia"

        FalklandIslands ->
            "Falkland Islands"

        FaroeIslands ->
            "Faroe Islands"

        Fiji ->
            "Fiji"

        Finland ->
            "Finland"

        France ->
            "France"

        FrenchPolynesia ->
            "French Polynesia"

        Gabon ->
            "Gabon"

        Gambia ->
            "Gambia"

        Georgia ->
            "Georgia"

        Germany ->
            "Germany"

        Ghana ->
            "Ghana"

        Gibraltar ->
            "Gibraltar"

        Greece ->
            "Greece"

        Greenland ->
            "Greenland"

        Grenada ->
            "Grenada"

        Guam ->
            "Guam"

        Guatemala ->
            "Guatemala"

        Guernsey ->
            "Guernsey"

        Guinea ->
            "Guinea"

        GuineaBissau ->
            "Guinea-Bissau"

        Guyana ->
            "Guyana"

        Haiti ->
            "Haiti"

        Honduras ->
            "Honduras"

        HongKong ->
            "Hong Kong"

        Hungary ->
            "Hungary"

        Iceland ->
            "Iceland"

        India ->
            "India"

        Indonesia ->
            "Indonesia"

        Iran ->
            "Iran"

        Iraq ->
            "Iraq"

        Ireland ->
            "Ireland"

        IsleofMan ->
            "Isle of Man"

        Israel ->
            "Israel"

        Italy ->
            "Italy"

        IvoryCoast ->
            "Ivory Coast"

        Jamaica ->
            "Jamaica"

        Japan ->
            "Japan"

        Jersey ->
            "Jersey"

        Jordan ->
            "Jordan"

        Kazakhstan ->
            "Kazakhstan"

        Kenya ->
            "Kenya"

        Kiribati ->
            "Kiribati"

        Kosovo ->
            "Kosovo"

        Kuwait ->
            "Kuwait"

        Kyrgyzstan ->
            "Kyrgyzstan"

        Laos ->
            "Laos"

        Latvia ->
            "Latvia"

        Lebanon ->
            "Lebanon"

        Lesotho ->
            "Lesotho"

        Liberia ->
            "Liberia"

        Libya ->
            "Libya"

        Liechtenstein ->
            "Liechtenstein"

        Lithuania ->
            "Lithuania"

        Luxembourg ->
            "Luxembourg"

        Macau ->
            "Macau"

        Macedonia ->
            "Macedonia"

        Madagascar ->
            "Madagascar"

        Malawi ->
            "Malawi"

        Malaysia ->
            "Malaysia"

        Maldives ->
            "Maldives"

        Mali ->
            "Mali"

        Malta ->
            "Malta"

        MarshallIslands ->
            "Marshall Islands"

        Mauritania ->
            "Mauritania"

        Mauritius ->
            "Mauritius"

        Mayotte ->
            "Mayotte"

        Mexico ->
            "Mexico"

        Micronesia ->
            "Micronesia"

        Moldova ->
            "Moldova"

        Monaco ->
            "Monaco"

        Mongolia ->
            "Mongolia"

        Montenegro ->
            "Montenegro"

        Montserrat ->
            "Montserrat"

        Morocco ->
            "Morocco"

        Mozambique ->
            "Mozambique"

        Myanmar ->
            "Myanmar"

        Namibia ->
            "Namibia"

        Nauru ->
            "Nauru"

        Nepal ->
            "Nepal"

        Netherlands ->
            "Netherlands"

        NewCaledonia ->
            "New Caledonia"

        NewZealand ->
            "New Zealand"

        Nicaragua ->
            "Nicaragua"

        Niger ->
            "Niger"

        Nigeria ->
            "Nigeria"

        Niue ->
            "Niue"

        NorthKorea ->
            "North Korea"

        NorthernMarianaIslands ->
            "Northern Mariana Islands"

        Norway ->
            "Norway"

        Oman ->
            "Oman"

        Pakistan ->
            "Pakistan"

        Palau ->
            "Palau"

        Palestine ->
            "Palestine"

        Panama ->
            "Panama"

        PapuaNewGuinea ->
            "Papua New Guinea"

        Paraguay ->
            "Paraguay"

        Peru ->
            "Peru"

        Philippines ->
            "Philippines"

        Pitcairn ->
            "Pitcairn"

        Poland ->
            "Poland"

        Portugal ->
            "Portugal"

        PuertoRico ->
            "Puerto Rico"

        Qatar ->
            "Qatar"

        RepublicoftheCongo ->
            "Republic of the Congo"

        Reunion ->
            "Reunion"

        Romania ->
            "Romania"

        Russia ->
            "Russia"

        Rwanda ->
            "Rwanda"

        SaintBarthelemy ->
            "Saint Barthelemy"

        SaintHelena ->
            "Saint Helena"

        SaintKittsandNevis ->
            "Saint Kitts and Nevis"

        SaintLucia ->
            "Saint Lucia"

        SaintMartin ->
            "Saint Martin"

        SaintPierreandMiquelon ->
            "Saint Pierre and Miquelon"

        SaintVincentandTheGrenadines ->
            "Saint Vincent and The Grenadines"

        Samoa ->
            "Samoa"

        SanMarino ->
            "San Marino"

        SaoTomeandPrincipe ->
            "Sao Tome and Principe"

        SaudiArabia ->
            "Saudi Arabia"

        Senegal ->
            "Senegal"

        Serbia ->
            "Serbia"

        Seychelles ->
            "Seychelles"

        SierraLeone ->
            "Sierra Leone"

        Singapore ->
            "Singapore"

        SintMaarten ->
            "Sint Maarten"

        Slovakia ->
            "Slovakia"

        Slovenia ->
            "Slovenia"

        SolomonIslands ->
            "Solomon Islands"

        Somalia ->
            "Somalia"

        SouthAfrica ->
            "South Africa"

        SouthKorea ->
            "South Korea"

        SouthSudan ->
            "South Sudan"

        Spain ->
            "Spain"

        SriLanka ->
            "Sri Lanka"

        Sudan ->
            "Sudan"

        Suriname ->
            "Suriname"

        SvalbardandJanMayen ->
            "Svalbard and Jan Mayen"

        Swaziland ->
            "Swaziland"

        Sweden ->
            "Sweden"

        Switzerland ->
            "Switzerland"

        Syria ->
            "Syria"

        Taiwan ->
            "Taiwan"

        Tajikistan ->
            "Tajikistan"

        Tanzania ->
            "Tanzania"

        Thailand ->
            "Thailand"

        Togo ->
            "Togo"

        Tokelau ->
            "Tokelau"

        Tonga ->
            "Tonga"

        TrinidadandTobago ->
            "Trinidad and Tobago"

        Tunisia ->
            "Tunisia"

        Turkey ->
            "Turkey"

        Turkmenistan ->
            "Turkmenistan"

        TurksandCaicosIslands ->
            "Turks and Caicos Islands"

        Tuvalu ->
            "Tuvalu"

        USVirginIslands ->
            "U.S. Virgin Islands"

        Uganda ->
            "Uganda"

        Ukraine ->
            "Ukraine"

        UnitedArabEmirates ->
            "United Arab Emirates"

        UnitedKingdom ->
            "United Kingdom"

        UnitedStates ->
            "United States"

        Uruguay ->
            "Uruguay"

        Uzbekistan ->
            "Uzbekistan"

        Vanuatu ->
            "Vanuatu"

        Vatican ->
            "Vatican"

        Venezuela ->
            "Venezuela"

        Vietnam ->
            "Vietnam"

        WallisandFutuna ->
            "Wallis and Futuna"

        WesternSahara ->
            "Western Sahara"

        Yemen ->
            "Yemen"

        Zambia ->
            "Zambia"

        Zimbabwe ->
            "Zimbabwe"


{-| -}
toCountryTelCode : Country -> String
toCountryTelCode country =
    case country of
        Afghanistan ->
            "+93"

        Albania ->
            "+355"

        Algeria ->
            "+213"

        AmericanSamoa ->
            "+1684"

        Andorra ->
            "+376"

        Angola ->
            "+244"

        Anguilla ->
            "+1264"

        Antarctica ->
            "+672"

        AntiguaandBarbuda ->
            "+1268"

        Argentina ->
            "+54"

        Armenia ->
            "+374"

        Aruba ->
            "+297"

        Australia ->
            "+61"

        Austria ->
            "+43"

        Azerbaijan ->
            "+994"

        Bahamas ->
            "+1242"

        Bahrain ->
            "+973"

        Bangladesh ->
            "+880"

        Barbados ->
            "+1246"

        Belarus ->
            "+375"

        Belgium ->
            "+32"

        Belize ->
            "+501"

        Benin ->
            "+229"

        Bermuda ->
            "+1441"

        Bhutan ->
            "+975"

        Bolivia ->
            "+591"

        BosniaandHerzegovina ->
            "+387"

        Botswana ->
            "+267"

        Brazil ->
            "+55"

        BritishIndianOceanTerritory ->
            "+246"

        BritishVirginIslands ->
            "+1284"

        Brunei ->
            "+673"

        Bulgaria ->
            "+359"

        BurkinaFaso ->
            "+226"

        Burundi ->
            "+257"

        Cambodia ->
            "+855"

        Cameroon ->
            "+237"

        Canada ->
            "+1"

        CapeVerde ->
            "+238"

        CaymanIslands ->
            "+1345"

        CentralAfricanRepublic ->
            "+236"

        Chad ->
            "+235"

        Chile ->
            "+56"

        China ->
            "+86"

        ChristmasIsland ->
            "+6189164"

        CocosIslands ->
            "+6189162"

        Colombia ->
            "+57"

        Comoros ->
            "+269"

        CookIslands ->
            "+682"

        CostaRica ->
            "+506"

        Croatia ->
            "+385"

        Cuba ->
            "+53"

        Curacao ->
            "+599"

        Cyprus ->
            "+357"

        CzechRepublic ->
            "+420"

        DemocraticRepublicoftheCongo ->
            "+243"

        Denmark ->
            "+45"

        Djibouti ->
            "+253"

        Dominica ->
            "+1767"

        DominicanRepublic ->
            "+1809"

        EastTimor ->
            "+670"

        Ecuador ->
            "+593"

        Egypt ->
            "+20"

        ElSalvador ->
            "+503"

        EquatorialGuinea ->
            "+240"

        Eritrea ->
            "+291"

        Estonia ->
            "+372"

        Ethiopia ->
            "+251"

        FalklandIslands ->
            "+500"

        FaroeIslands ->
            "+298"

        Fiji ->
            "+679"

        Finland ->
            "+358"

        France ->
            "+33"

        FrenchPolynesia ->
            "+689"

        Gabon ->
            "+241"

        Gambia ->
            "+220"

        Georgia ->
            "+995"

        Germany ->
            "+49"

        Ghana ->
            "+233"

        Gibraltar ->
            "+350"

        Greece ->
            "+30"

        Greenland ->
            "+299"

        Grenada ->
            "+1473"

        Guam ->
            "+1671"

        Guatemala ->
            "+502"

        Guernsey ->
            "+441481"

        Guinea ->
            "+224"

        GuineaBissau ->
            "+245"

        Guyana ->
            "+592"

        Haiti ->
            "+509"

        Honduras ->
            "+504"

        HongKong ->
            "+852"

        Hungary ->
            "+36"

        Iceland ->
            "+354"

        India ->
            "+91"

        Indonesia ->
            "+62"

        Iran ->
            "+98"

        Iraq ->
            "+964"

        Ireland ->
            "+353"

        IsleofMan ->
            "+441624"

        Israel ->
            "+972"

        Italy ->
            "+39"

        IvoryCoast ->
            "+225"

        Jamaica ->
            "+1876"

        Japan ->
            "+81"

        Jersey ->
            "+441534"

        Jordan ->
            "+962"

        Kazakhstan ->
            "+7"

        Kenya ->
            "+254"

        Kiribati ->
            "+686"

        Kosovo ->
            "+383"

        Kuwait ->
            "+965"

        Kyrgyzstan ->
            "+996"

        Laos ->
            "+856"

        Latvia ->
            "+371"

        Lebanon ->
            "+961"

        Lesotho ->
            "+266"

        Liberia ->
            "+231"

        Libya ->
            "+218"

        Liechtenstein ->
            "+423"

        Lithuania ->
            "+370"

        Luxembourg ->
            "+352"

        Macau ->
            "+853"

        Macedonia ->
            "+389"

        Madagascar ->
            "+261"

        Malawi ->
            "+265"

        Malaysia ->
            "+60"

        Maldives ->
            "+960"

        Mali ->
            "+223"

        Malta ->
            "+356"

        MarshallIslands ->
            "+692"

        Mauritania ->
            "+222"

        Mauritius ->
            "+230"

        Mayotte ->
            "+262"

        Mexico ->
            "+52"

        Micronesia ->
            "+691"

        Moldova ->
            "+373"

        Monaco ->
            "+377"

        Mongolia ->
            "+976"

        Montenegro ->
            "+382"

        Montserrat ->
            "+1664"

        Morocco ->
            "+212"

        Mozambique ->
            "+258"

        Myanmar ->
            "+95"

        Namibia ->
            "+264"

        Nauru ->
            "+674"

        Nepal ->
            "+977"

        Netherlands ->
            "+31"

        NewCaledonia ->
            "+687"

        NewZealand ->
            "+64"

        Nicaragua ->
            "+505"

        Niger ->
            "+227"

        Nigeria ->
            "+234"

        Niue ->
            "+683"

        NorthKorea ->
            "+850"

        NorthernMarianaIslands ->
            "+1670"

        Norway ->
            "+47"

        Oman ->
            "+968"

        Pakistan ->
            "+92"

        Palau ->
            "+680"

        Palestine ->
            "+970"

        Panama ->
            "+507"

        PapuaNewGuinea ->
            "+675"

        Paraguay ->
            "+595"

        Peru ->
            "+51"

        Philippines ->
            "+63"

        Pitcairn ->
            "+64"

        Poland ->
            "+48"

        Portugal ->
            "+351"

        PuertoRico ->
            "+1787"

        Qatar ->
            "+974"

        RepublicoftheCongo ->
            "+242"

        Reunion ->
            "+262"

        Romania ->
            "+40"

        Russia ->
            "+7"

        Rwanda ->
            "+250"

        SaintBarthelemy ->
            "+590"

        SaintHelena ->
            "+290"

        SaintKittsandNevis ->
            "+1869"

        SaintLucia ->
            "+1758"

        SaintMartin ->
            "+590"

        SaintPierreandMiquelon ->
            "+508"

        SaintVincentandTheGrenadines ->
            "+1784"

        Samoa ->
            "+685"

        SanMarino ->
            "+378"

        SaoTomeandPrincipe ->
            "+239"

        SaudiArabia ->
            "+966"

        Senegal ->
            "+221"

        Serbia ->
            "+381"

        Seychelles ->
            "+248"

        SierraLeone ->
            "+232"

        Singapore ->
            "+65"

        SintMaarten ->
            "+1721"

        Slovakia ->
            "+421"

        Slovenia ->
            "+386"

        SolomonIslands ->
            "+677"

        Somalia ->
            "+252"

        SouthAfrica ->
            "+27"

        SouthKorea ->
            "+82"

        SouthSudan ->
            "+211"

        Spain ->
            "+34"

        SriLanka ->
            "+94"

        Sudan ->
            "+249"

        Suriname ->
            "+597"

        SvalbardandJanMayen ->
            "+47"

        Swaziland ->
            "+268"

        Sweden ->
            "+46"

        Switzerland ->
            "+41"

        Syria ->
            "+963"

        Taiwan ->
            "+886"

        Tajikistan ->
            "+992"

        Tanzania ->
            "+255"

        Thailand ->
            "+66"

        Togo ->
            "+228"

        Tokelau ->
            "+690"

        Tonga ->
            "+676"

        TrinidadandTobago ->
            "+1868"

        Tunisia ->
            "+216"

        Turkey ->
            "+90"

        Turkmenistan ->
            "+993"

        TurksandCaicosIslands ->
            "+1649"

        Tuvalu ->
            "+688"

        USVirginIslands ->
            "+1340"

        Uganda ->
            "+256"

        Ukraine ->
            "+380"

        UnitedArabEmirates ->
            "+971"

        UnitedKingdom ->
            "+44"

        UnitedStates ->
            "+1"

        Uruguay ->
            "+598"

        Uzbekistan ->
            "+998"

        Vanuatu ->
            "+678"

        Vatican ->
            "+379"

        Venezuela ->
            "+58"

        Vietnam ->
            "+84"

        WallisandFutuna ->
            "+681"

        WesternSahara ->
            "+212"

        Yemen ->
            "+967"

        Zambia ->
            "+260"

        Zimbabwe ->
            "+263"


{-| ISO 3166 code
-}
toCountryCode : Country -> String
toCountryCode country =
    case country of
        Afghanistan ->
            "AF"

        Albania ->
            "AL"

        Algeria ->
            "DZ"

        AmericanSamoa ->
            "AS"

        Andorra ->
            "AD"

        Angola ->
            "AO"

        Anguilla ->
            "AI"

        Antarctica ->
            "AQ"

        AntiguaandBarbuda ->
            "AG"

        Argentina ->
            "AR"

        Armenia ->
            "AM"

        Aruba ->
            "AW"

        Australia ->
            "AU"

        Austria ->
            "AT"

        Azerbaijan ->
            "AZ"

        Bahamas ->
            "BS"

        Bahrain ->
            "BH"

        Bangladesh ->
            "BD"

        Barbados ->
            "BB"

        Belarus ->
            "BY"

        Belgium ->
            "BE"

        Belize ->
            "BZ"

        Benin ->
            "BJ"

        Bermuda ->
            "BM"

        Bhutan ->
            "BT"

        Bolivia ->
            "BO"

        BosniaandHerzegovina ->
            "BA"

        Botswana ->
            "BW"

        Brazil ->
            "BR"

        BritishIndianOceanTerritory ->
            "IO"

        BritishVirginIslands ->
            "VG"

        Brunei ->
            "BN"

        Bulgaria ->
            "BG"

        BurkinaFaso ->
            "BF"

        Burundi ->
            "BI"

        Cambodia ->
            "KH"

        Cameroon ->
            "CM"

        Canada ->
            "CA"

        CapeVerde ->
            "CV"

        CaymanIslands ->
            "KY"

        CentralAfricanRepublic ->
            "CF"

        Chad ->
            "TD"

        Chile ->
            "CL"

        China ->
            "CN"

        ChristmasIsland ->
            "CX"

        CocosIslands ->
            "CC"

        Colombia ->
            "CO"

        Comoros ->
            "KM"

        CookIslands ->
            "CK"

        CostaRica ->
            "CR"

        Croatia ->
            "HR"

        Cuba ->
            "CU"

        Curacao ->
            "CW"

        Cyprus ->
            "CY"

        CzechRepublic ->
            "CZ"

        DemocraticRepublicoftheCongo ->
            "CD"

        Denmark ->
            "DK"

        Djibouti ->
            "DJ"

        Dominica ->
            "DM"

        DominicanRepublic ->
            "DO"

        EastTimor ->
            "TL"

        Ecuador ->
            "EC"

        Egypt ->
            "EG"

        ElSalvador ->
            "SV"

        EquatorialGuinea ->
            "GQ"

        Eritrea ->
            "ER"

        Estonia ->
            "EE"

        Ethiopia ->
            "ET"

        FalklandIslands ->
            "FK"

        FaroeIslands ->
            "FO"

        Fiji ->
            "FJ"

        Finland ->
            "FI"

        France ->
            "FR"

        FrenchPolynesia ->
            "PF"

        Gabon ->
            "GA"

        Gambia ->
            "GM"

        Georgia ->
            "GE"

        Germany ->
            "DE"

        Ghana ->
            "GH"

        Gibraltar ->
            "GI"

        Greece ->
            "GR"

        Greenland ->
            "GL"

        Grenada ->
            "GD"

        Guam ->
            "GU"

        Guatemala ->
            "GT"

        Guernsey ->
            "GG"

        Guinea ->
            "GN"

        GuineaBissau ->
            "GW"

        Guyana ->
            "GY"

        Haiti ->
            "HT"

        Honduras ->
            "HN"

        HongKong ->
            "HK"

        Hungary ->
            "HU"

        Iceland ->
            "IS"

        India ->
            "IN"

        Indonesia ->
            "ID"

        Iran ->
            "IR"

        Iraq ->
            "IQ"

        Ireland ->
            "IE"

        IsleofMan ->
            "IM"

        Israel ->
            "IL"

        Italy ->
            "IT"

        IvoryCoast ->
            "CI"

        Jamaica ->
            "JM"

        Japan ->
            "JP"

        Jersey ->
            "JE"

        Jordan ->
            "JO"

        Kazakhstan ->
            "KZ"

        Kenya ->
            "KE"

        Kiribati ->
            "KI"

        Kosovo ->
            "XK"

        Kuwait ->
            "KW"

        Kyrgyzstan ->
            "KG"

        Laos ->
            "LA"

        Latvia ->
            "LV"

        Lebanon ->
            "LB"

        Lesotho ->
            "LS"

        Liberia ->
            "LR"

        Libya ->
            "LY"

        Liechtenstein ->
            "LI"

        Lithuania ->
            "LT"

        Luxembourg ->
            "LU"

        Macau ->
            "MO"

        Macedonia ->
            "MK"

        Madagascar ->
            "MG"

        Malawi ->
            "MW"

        Malaysia ->
            "MY"

        Maldives ->
            "MV"

        Mali ->
            "ML"

        Malta ->
            "MT"

        MarshallIslands ->
            "MH"

        Mauritania ->
            "MR"

        Mauritius ->
            "MU"

        Mayotte ->
            "YT"

        Mexico ->
            "MX"

        Micronesia ->
            "FM"

        Moldova ->
            "MD"

        Monaco ->
            "MC"

        Mongolia ->
            "MN"

        Montenegro ->
            "ME"

        Montserrat ->
            "MS"

        Morocco ->
            "MA"

        Mozambique ->
            "MZ"

        Myanmar ->
            "MM"

        Namibia ->
            "NA"

        Nauru ->
            "NR"

        Nepal ->
            "NP"

        Netherlands ->
            "NL"

        NewCaledonia ->
            "NC"

        NewZealand ->
            "NZ"

        Nicaragua ->
            "NI"

        Niger ->
            "NE"

        Nigeria ->
            "NG"

        Niue ->
            "NU"

        NorthKorea ->
            "KP"

        NorthernMarianaIslands ->
            "MP"

        Norway ->
            "NO"

        Oman ->
            "OM"

        Pakistan ->
            "PK"

        Palau ->
            "PW"

        Palestine ->
            "PS"

        Panama ->
            "PA"

        PapuaNewGuinea ->
            "PG"

        Paraguay ->
            "PY"

        Peru ->
            "PE"

        Philippines ->
            "PH"

        Pitcairn ->
            "PN"

        Poland ->
            "PL"

        Portugal ->
            "PT"

        PuertoRico ->
            "PR"

        Qatar ->
            "QA"

        RepublicoftheCongo ->
            "CG"

        Reunion ->
            "RE"

        Romania ->
            "RO"

        Russia ->
            "RU"

        Rwanda ->
            "RW"

        SaintBarthelemy ->
            "BL"

        SaintHelena ->
            "SH"

        SaintKittsandNevis ->
            "KN"

        SaintLucia ->
            "LC"

        SaintMartin ->
            "MF"

        SaintPierreandMiquelon ->
            "PM"

        SaintVincentandTheGrenadines ->
            "VC"

        Samoa ->
            "WS"

        SanMarino ->
            "SM"

        SaoTomeandPrincipe ->
            "ST"

        SaudiArabia ->
            "SA"

        Senegal ->
            "SN"

        Serbia ->
            "RS"

        Seychelles ->
            "SC"

        SierraLeone ->
            "SL"

        Singapore ->
            "SG"

        SintMaarten ->
            "SX"

        Slovakia ->
            "SK"

        Slovenia ->
            "SI"

        SolomonIslands ->
            "SB"

        Somalia ->
            "SO"

        SouthAfrica ->
            "ZA"

        SouthKorea ->
            "KR"

        SouthSudan ->
            "SS"

        Spain ->
            "ES"

        SriLanka ->
            "LK"

        Sudan ->
            "SD"

        Suriname ->
            "SR"

        SvalbardandJanMayen ->
            "SJ"

        Swaziland ->
            "SZ"

        Sweden ->
            "SE"

        Switzerland ->
            "CH"

        Syria ->
            "SY"

        Taiwan ->
            "TW"

        Tajikistan ->
            "TJ"

        Tanzania ->
            "TZ"

        Thailand ->
            "TH"

        Togo ->
            "TG"

        Tokelau ->
            "TK"

        Tonga ->
            "TO"

        TrinidadandTobago ->
            "TT"

        Tunisia ->
            "TN"

        Turkey ->
            "TR"

        Turkmenistan ->
            "TM"

        TurksandCaicosIslands ->
            "TC"

        Tuvalu ->
            "TV"

        USVirginIslands ->
            "VI"

        Uganda ->
            "UG"

        Ukraine ->
            "UA"

        UnitedArabEmirates ->
            "AE"

        UnitedKingdom ->
            "GB"

        UnitedStates ->
            "US"

        Uruguay ->
            "UY"

        Uzbekistan ->
            "UZ"

        Vanuatu ->
            "VU"

        Vatican ->
            "VA"

        Venezuela ->
            "VE"

        Vietnam ->
            "VN"

        WallisandFutuna ->
            "WF"

        WesternSahara ->
            "EH"

        Yemen ->
            "YE"

        Zambia ->
            "ZM"

        Zimbabwe ->
            "ZW"


{-| from ISO 3166 code
-}
fromCountryCode : String -> Maybe Country
fromCountryCode country =
    case country of
        "AF" ->
            Just Afghanistan

        "AL" ->
            Just Albania

        "DZ" ->
            Just Algeria

        "AS" ->
            Just AmericanSamoa

        "AD" ->
            Just Andorra

        "AO" ->
            Just Angola

        "AI" ->
            Just Anguilla

        "AQ" ->
            Just Antarctica

        "AG" ->
            Just AntiguaandBarbuda

        "AR" ->
            Just Argentina

        "AM" ->
            Just Armenia

        "AW" ->
            Just Aruba

        "AU" ->
            Just Australia

        "AT" ->
            Just Austria

        "AZ" ->
            Just Azerbaijan

        "BS" ->
            Just Bahamas

        "BH" ->
            Just Bahrain

        "BD" ->
            Just Bangladesh

        "BB" ->
            Just Barbados

        "BY" ->
            Just Belarus

        "BE" ->
            Just Belgium

        "BZ" ->
            Just Belize

        "BJ" ->
            Just Benin

        "BM" ->
            Just Bermuda

        "BT" ->
            Just Bhutan

        "BO" ->
            Just Bolivia

        "BA" ->
            Just BosniaandHerzegovina

        "BW" ->
            Just Botswana

        "BR" ->
            Just Brazil

        "IO" ->
            Just BritishIndianOceanTerritory

        "VG" ->
            Just BritishVirginIslands

        "BN" ->
            Just Brunei

        "BG" ->
            Just Bulgaria

        "BF" ->
            Just BurkinaFaso

        "BI" ->
            Just Burundi

        "KH" ->
            Just Cambodia

        "CM" ->
            Just Cameroon

        "CA" ->
            Just Canada

        "CV" ->
            Just CapeVerde

        "KY" ->
            Just CaymanIslands

        "CF" ->
            Just CentralAfricanRepublic

        "TD" ->
            Just Chad

        "CL" ->
            Just Chile

        "CN" ->
            Just China

        "CX" ->
            Just ChristmasIsland

        "CC" ->
            Just CocosIslands

        "CO" ->
            Just Colombia

        "KM" ->
            Just Comoros

        "CK" ->
            Just CookIslands

        "CR" ->
            Just CostaRica

        "HR" ->
            Just Croatia

        "CU" ->
            Just Cuba

        "CW" ->
            Just Curacao

        "CY" ->
            Just Cyprus

        "CZ" ->
            Just CzechRepublic

        "CD" ->
            Just DemocraticRepublicoftheCongo

        "DK" ->
            Just Denmark

        "DJ" ->
            Just Djibouti

        "DM" ->
            Just Dominica

        "DO" ->
            Just DominicanRepublic

        "TL" ->
            Just EastTimor

        "EC" ->
            Just Ecuador

        "EG" ->
            Just Egypt

        "SV" ->
            Just ElSalvador

        "GQ" ->
            Just EquatorialGuinea

        "ER" ->
            Just Eritrea

        "EE" ->
            Just Estonia

        "ET" ->
            Just Ethiopia

        "FK" ->
            Just FalklandIslands

        "FO" ->
            Just FaroeIslands

        "FJ" ->
            Just Fiji

        "FI" ->
            Just Finland

        "FR" ->
            Just France

        "PF" ->
            Just FrenchPolynesia

        "GA" ->
            Just Gabon

        "GM" ->
            Just Gambia

        "GE" ->
            Just Georgia

        "DE" ->
            Just Germany

        "GH" ->
            Just Ghana

        "GI" ->
            Just Gibraltar

        "GR" ->
            Just Greece

        "GL" ->
            Just Greenland

        "GD" ->
            Just Grenada

        "GU" ->
            Just Guam

        "GT" ->
            Just Guatemala

        "GG" ->
            Just Guernsey

        "GN" ->
            Just Guinea

        "GW" ->
            Just GuineaBissau

        "GY" ->
            Just Guyana

        "HT" ->
            Just Haiti

        "HN" ->
            Just Honduras

        "HK" ->
            Just HongKong

        "HU" ->
            Just Hungary

        "IS" ->
            Just Iceland

        "IN" ->
            Just India

        "ID" ->
            Just Indonesia

        "IR" ->
            Just Iran

        "IQ" ->
            Just Iraq

        "IE" ->
            Just Ireland

        "IM" ->
            Just IsleofMan

        "IL" ->
            Just Israel

        "IT" ->
            Just Italy

        "CI" ->
            Just IvoryCoast

        "JM" ->
            Just Jamaica

        "JP" ->
            Just Japan

        "JE" ->
            Just Jersey

        "JO" ->
            Just Jordan

        "KZ" ->
            Just Kazakhstan

        "KE" ->
            Just Kenya

        "KI" ->
            Just Kiribati

        "XK" ->
            Just Kosovo

        "KW" ->
            Just Kuwait

        "KG" ->
            Just Kyrgyzstan

        "LA" ->
            Just Laos

        "LV" ->
            Just Latvia

        "LB" ->
            Just Lebanon

        "LS" ->
            Just Lesotho

        "LR" ->
            Just Liberia

        "LY" ->
            Just Libya

        "LI" ->
            Just Liechtenstein

        "LT" ->
            Just Lithuania

        "LU" ->
            Just Luxembourg

        "MO" ->
            Just Macau

        "MK" ->
            Just Macedonia

        "MG" ->
            Just Madagascar

        "MW" ->
            Just Malawi

        "MY" ->
            Just Malaysia

        "MV" ->
            Just Maldives

        "ML" ->
            Just Mali

        "MT" ->
            Just Malta

        "MH" ->
            Just MarshallIslands

        "MR" ->
            Just Mauritania

        "MU" ->
            Just Mauritius

        "YT" ->
            Just Mayotte

        "MX" ->
            Just Mexico

        "FM" ->
            Just Micronesia

        "MD" ->
            Just Moldova

        "MC" ->
            Just Monaco

        "MN" ->
            Just Mongolia

        "ME" ->
            Just Montenegro

        "MS" ->
            Just Montserrat

        "MA" ->
            Just Morocco

        "MZ" ->
            Just Mozambique

        "MM" ->
            Just Myanmar

        "NA" ->
            Just Namibia

        "NR" ->
            Just Nauru

        "NP" ->
            Just Nepal

        "NL" ->
            Just Netherlands

        "NC" ->
            Just NewCaledonia

        "NZ" ->
            Just NewZealand

        "NI" ->
            Just Nicaragua

        "NE" ->
            Just Niger

        "NG" ->
            Just Nigeria

        "NU" ->
            Just Niue

        "KP" ->
            Just NorthKorea

        "MP" ->
            Just NorthernMarianaIslands

        "NO" ->
            Just Norway

        "OM" ->
            Just Oman

        "PK" ->
            Just Pakistan

        "PW" ->
            Just Palau

        "PS" ->
            Just Palestine

        "PA" ->
            Just Panama

        "PG" ->
            Just PapuaNewGuinea

        "PY" ->
            Just Paraguay

        "PE" ->
            Just Peru

        "PH" ->
            Just Philippines

        "PN" ->
            Just Pitcairn

        "PL" ->
            Just Poland

        "PT" ->
            Just Portugal

        "PR" ->
            Just PuertoRico

        "QA" ->
            Just Qatar

        "CG" ->
            Just RepublicoftheCongo

        "RE" ->
            Just Reunion

        "RO" ->
            Just Romania

        "RU" ->
            Just Russia

        "RW" ->
            Just Rwanda

        "BL" ->
            Just SaintBarthelemy

        "SH" ->
            Just SaintHelena

        "KN" ->
            Just SaintKittsandNevis

        "LC" ->
            Just SaintLucia

        "MF" ->
            Just SaintMartin

        "PM" ->
            Just SaintPierreandMiquelon

        "VC" ->
            Just SaintVincentandTheGrenadines

        "WS" ->
            Just Samoa

        "SM" ->
            Just SanMarino

        "ST" ->
            Just SaoTomeandPrincipe

        "SA" ->
            Just SaudiArabia

        "SN" ->
            Just Senegal

        "RS" ->
            Just Serbia

        "SC" ->
            Just Seychelles

        "SL" ->
            Just SierraLeone

        "SG" ->
            Just Singapore

        "SX" ->
            Just SintMaarten

        "SK" ->
            Just Slovakia

        "SI" ->
            Just Slovenia

        "SB" ->
            Just SolomonIslands

        "SO" ->
            Just Somalia

        "ZA" ->
            Just SouthAfrica

        "KR" ->
            Just SouthKorea

        "SS" ->
            Just SouthSudan

        "ES" ->
            Just Spain

        "LK" ->
            Just SriLanka

        "SD" ->
            Just Sudan

        "SR" ->
            Just Suriname

        "SJ" ->
            Just SvalbardandJanMayen

        "SZ" ->
            Just Swaziland

        "SE" ->
            Just Sweden

        "CH" ->
            Just Switzerland

        "SY" ->
            Just Syria

        "TW" ->
            Just Taiwan

        "TJ" ->
            Just Tajikistan

        "TZ" ->
            Just Tanzania

        "TH" ->
            Just Thailand

        "TG" ->
            Just Togo

        "TK" ->
            Just Tokelau

        "TO" ->
            Just Tonga

        "TT" ->
            Just TrinidadandTobago

        "TN" ->
            Just Tunisia

        "TR" ->
            Just Turkey

        "TM" ->
            Just Turkmenistan

        "TC" ->
            Just TurksandCaicosIslands

        "TV" ->
            Just Tuvalu

        "VI" ->
            Just USVirginIslands

        "UG" ->
            Just Uganda

        "UA" ->
            Just Ukraine

        "AE" ->
            Just UnitedArabEmirates

        "GB" ->
            Just UnitedKingdom

        "US" ->
            Just UnitedStates

        "UY" ->
            Just Uruguay

        "UZ" ->
            Just Uzbekistan

        "VU" ->
            Just Vanuatu

        "VA" ->
            Just Vatican

        "VE" ->
            Just Venezuela

        "VN" ->
            Just Vietnam

        "WF" ->
            Just WallisandFutuna

        "EH" ->
            Just WesternSahara

        "YE" ->
            Just Yemen

        "ZM" ->
            Just Zambia

        "ZW" ->
            Just Zimbabwe

        _ ->
            Nothing


{-| -}
toCountryNameWithAlias : Country -> String
toCountryNameWithAlias country =
    case country of
        Afghanistan ->
            "Afghanistan (\u{202B}افغانستان\u{202C}\u{200E})"

        Albania ->
            "Albania (Shqipëri)"

        Algeria ->
            "Algeria (\u{202B}الجزائر\u{202C}\u{200E})"

        AmericanSamoa ->
            "American Samoa"

        Andorra ->
            "Andorra"

        Angola ->
            "Angola"

        Anguilla ->
            "Anguilla"

        Antarctica ->
            "Antarctica"

        AntiguaandBarbuda ->
            "Antigua and Barbuda"

        Argentina ->
            "Argentina"

        Armenia ->
            "Armenia (Հայաստան)"

        Aruba ->
            "Aruba"

        Australia ->
            "Australia"

        Austria ->
            "Austria (Österreich)"

        Azerbaijan ->
            "Azerbaijan (Azərbaycan)"

        Bahamas ->
            "Bahamas"

        Bahrain ->
            "Bahrain (\u{202B}البحرين\u{202C}\u{200E})"

        Bangladesh ->
            "Bangladesh (বাংলাদেশ)"

        Barbados ->
            "Barbados"

        Belarus ->
            "Belarus (Беларусь)"

        Belgium ->
            "Belgium (België)"

        Belize ->
            "Belize"

        Benin ->
            "Benin (Bénin)"

        Bermuda ->
            "Bermuda"

        Bhutan ->
            "Bhutan (འབྲུག)"

        Bolivia ->
            "Bolivia"

        BosniaandHerzegovina ->
            "Bosnia and Herzegovina (Босна и Херцеговина)"

        Botswana ->
            "Botswana"

        Brazil ->
            "Brazil (Brasil)"

        BritishIndianOceanTerritory ->
            "British Indian Ocean Territory"

        BritishVirginIslands ->
            "British Virgin Islands"

        Brunei ->
            "Brunei"

        Bulgaria ->
            "Bulgaria (България)"

        BurkinaFaso ->
            "Burkina Faso"

        Burundi ->
            "Burundi (Uburundi)"

        Cambodia ->
            "Cambodia (កម្ពុជា)"

        Cameroon ->
            "Cameroon (Cameroun)"

        Canada ->
            "Canada"

        CapeVerde ->
            "Cape Verde (Kabu Verdi)"

        CaymanIslands ->
            "Cayman Islands"

        CentralAfricanRepublic ->
            "Central African Republic (République centrafricaine)"

        Chad ->
            "Chad (Tchad)"

        Chile ->
            "Chile"

        China ->
            "China (中国)"

        ChristmasIsland ->
            "Christmas Island"

        CocosIslands ->
            "Cocos (Keeling) Islands"

        Colombia ->
            "Colombia"

        Comoros ->
            "Comoros (\u{202B}جزر القمر\u{202C}\u{200E})"

        CookIslands ->
            "Cook Islands"

        CostaRica ->
            "Costa Rica"

        Croatia ->
            "Croatia (Hrvatska)"

        Cuba ->
            "Cuba"

        Curacao ->
            "Curaçao"

        Cyprus ->
            "Cyprus (Κύπρος)"

        CzechRepublic ->
            "Czech Republic (Česká republika)"

        DemocraticRepublicoftheCongo ->
            "Congo (DRC) (Jamhuri ya Kidemokrasia ya Kongo)"

        Denmark ->
            "Denmark (Danmark)"

        Djibouti ->
            "Djibouti"

        Dominica ->
            "Dominica"

        DominicanRepublic ->
            "Dominican Republic (República Dominicana)"

        EastTimor ->
            "Timor-Leste"

        Ecuador ->
            "Ecuador"

        Egypt ->
            "Egypt (\u{202B}مصر\u{202C}\u{200E})"

        ElSalvador ->
            "El Salvador"

        EquatorialGuinea ->
            "Equatorial Guinea (Guinea Ecuatorial)"

        Eritrea ->
            "Eritrea"

        Estonia ->
            "Estonia (Eesti)"

        Ethiopia ->
            "Ethiopia"

        FalklandIslands ->
            "Falkland Islands (Islas Malvinas)"

        FaroeIslands ->
            "Faroe Islands (Føroyar)"

        Fiji ->
            "Fiji"

        Finland ->
            "Finland (Suomi)"

        France ->
            "France"

        FrenchPolynesia ->
            "French Polynesia (Polynésie française)"

        Gabon ->
            "Gabon"

        Gambia ->
            "Gambia"

        Georgia ->
            "Georgia (საქართველო)"

        Germany ->
            "Germany (Deutschland)"

        Ghana ->
            "Ghana (Gaana)"

        Gibraltar ->
            "Gibraltar"

        Greece ->
            "Greece (Ελλάδα)"

        Greenland ->
            "Greenland (Kalaallit Nunaat)"

        Grenada ->
            "Grenada"

        Guam ->
            "Guam"

        Guatemala ->
            "Guatemala"

        Guernsey ->
            "Guernsey"

        Guinea ->
            "Guinea (Guinée)"

        GuineaBissau ->
            "Guinea-Bissau (Guiné Bissau)"

        Guyana ->
            "Guyana"

        Haiti ->
            "Haiti"

        Honduras ->
            "Honduras"

        HongKong ->
            "Hong Kong (香港)"

        Hungary ->
            "Hungary (Magyarország)"

        Iceland ->
            "Iceland (Ísland)"

        India ->
            "India (भारत)"

        Indonesia ->
            "Indonesia"

        Iran ->
            "Iran (\u{202B}ایران\u{202C}\u{200E})"

        Iraq ->
            "Iraq (\u{202B}العراق\u{202C}\u{200E})"

        Ireland ->
            "Ireland"

        IsleofMan ->
            "Isle of Man"

        Israel ->
            "Israel (\u{202B}ישראל\u{202C}\u{200E})"

        Italy ->
            "Italy (Italia)"

        IvoryCoast ->
            "Côte d’Ivoire"

        Jamaica ->
            "Jamaica"

        Japan ->
            "Japan (日本)"

        Jersey ->
            "Jersey"

        Jordan ->
            "Jordan (\u{202B}الأردن\u{202C}\u{200E})"

        Kazakhstan ->
            "Kazakhstan (Казахстан)"

        Kenya ->
            "Kenya"

        Kiribati ->
            "Kiribati"

        Kosovo ->
            "Kosovo"

        Kuwait ->
            "Kuwait (\u{202B}الكويت\u{202C}\u{200E})"

        Kyrgyzstan ->
            "Kyrgyzstan (Кыргызстан)"

        Laos ->
            "Laos (ລາວ)"

        Latvia ->
            "Latvia (Latvija)"

        Lebanon ->
            "Lebanon (\u{202B}لبنان\u{202C}\u{200E})"

        Lesotho ->
            "Lesotho"

        Liberia ->
            "Liberia"

        Libya ->
            "Libya (\u{202B}ليبيا\u{202C}\u{200E})"

        Liechtenstein ->
            "Liechtenstein"

        Lithuania ->
            "Lithuania (Lietuva)"

        Luxembourg ->
            "Luxembourg"

        Macau ->
            "Macau (澳門)"

        Macedonia ->
            "Macedonia (FYROM) (Македонија)"

        Madagascar ->
            "Madagascar (Madagasikara)"

        Malawi ->
            "Malawi"

        Malaysia ->
            "Malaysia"

        Maldives ->
            "Maldives"

        Mali ->
            "Mali"

        Malta ->
            "Malta"

        MarshallIslands ->
            "Marshall Islands"

        Mauritania ->
            "Mauritania (\u{202B}موريتانيا\u{202C}\u{200E})"

        Mauritius ->
            "Mauritius (Moris)"

        Mayotte ->
            "Mayotte"

        Mexico ->
            "Mexico (México)"

        Micronesia ->
            "Micronesia"

        Moldova ->
            "Moldova (Republica Moldova)"

        Monaco ->
            "Monaco"

        Mongolia ->
            "Mongolia (Монгол)"

        Montenegro ->
            "Montenegro (Crna Gora)"

        Montserrat ->
            "Montserrat"

        Morocco ->
            "Morocco (\u{202B}المغرب\u{202C}\u{200E})"

        Mozambique ->
            "Mozambique (Moçambique)"

        Myanmar ->
            "Myanmar (Burma) (မြန်မာ)"

        Namibia ->
            "Namibia (Namibië)"

        Nauru ->
            "Nauru"

        Nepal ->
            "Nepal (नेपाल)"

        Netherlands ->
            "Netherlands (Nederland)"

        NewCaledonia ->
            "New Caledonia (Nouvelle-Calédonie)"

        NewZealand ->
            "New Zealand"

        Nicaragua ->
            "Nicaragua"

        Niger ->
            "Niger (Nijar)"

        Nigeria ->
            "Nigeria"

        Niue ->
            "Niue"

        NorthKorea ->
            "North Korea (조선 민주주의 인민 공화국)"

        NorthernMarianaIslands ->
            "Northern Mariana Islands"

        Norway ->
            "Norway (Norge)"

        Oman ->
            "Oman (\u{202B}عُمان\u{202C}\u{200E})"

        Pakistan ->
            "Pakistan (\u{202B}پاکستان\u{202C}\u{200E})"

        Palau ->
            "Palau"

        Palestine ->
            "Palestine (\u{202B}فلسطين\u{202C}\u{200E})"

        Panama ->
            "Panama (Panamá)"

        PapuaNewGuinea ->
            "Papua New Guinea"

        Paraguay ->
            "Paraguay"

        Peru ->
            "Peru (Perú)"

        Philippines ->
            "Philippines"

        Pitcairn ->
            "Pitcairn"

        Poland ->
            "Poland (Polska)"

        Portugal ->
            "Portugal"

        PuertoRico ->
            "Puerto Rico"

        Qatar ->
            "Qatar (\u{202B}قطر\u{202C}\u{200E})"

        RepublicoftheCongo ->
            "Congo (Republic) (Congo-Brazzaville)"

        Reunion ->
            "Réunion (La Réunion)"

        Romania ->
            "Romania (România)"

        Russia ->
            "Russia (Россия)"

        Rwanda ->
            "Rwanda"

        SaintBarthelemy ->
            "Saint Barthélemy"

        SaintHelena ->
            "Saint Helena"

        SaintKittsandNevis ->
            "Saint Kitts and Nevis"

        SaintLucia ->
            "Saint Lucia"

        SaintMartin ->
            "Saint Martin (Saint-Martin (partie française))"

        SaintPierreandMiquelon ->
            "Saint Pierre and Miquelon (Saint-Pierre-et-Miquelon)"

        SaintVincentandTheGrenadines ->
            "Saint Vincent and the Grenadines"

        Samoa ->
            "Samoa"

        SanMarino ->
            "San Marino"

        SaoTomeandPrincipe ->
            "São Tomé and Príncipe (São Tomé e Príncipe)"

        SaudiArabia ->
            "Saudi Arabia (\u{202B}المملكة العربية السعودية\u{202C}\u{200E})"

        Senegal ->
            "Senegal (Sénégal)"

        Serbia ->
            "Serbia (Србија)"

        Seychelles ->
            "Seychelles"

        SierraLeone ->
            "Sierra Leone"

        Singapore ->
            "Singapore"

        SintMaarten ->
            "Sint Maarten"

        Slovakia ->
            "Slovakia (Slovensko)"

        Slovenia ->
            "Slovenia (Slovenija)"

        SolomonIslands ->
            "Solomon Islands"

        Somalia ->
            "Somalia (Soomaaliya)"

        SouthAfrica ->
            "South Africa"

        SouthKorea ->
            "South Korea (대한민국)"

        SouthSudan ->
            "South Sudan (\u{202B}جنوب السودان\u{202C}\u{200E})"

        Spain ->
            "Spain (España)"

        SriLanka ->
            "Sri Lanka (ශ්\u{200D}රී ලංකාව)"

        Sudan ->
            "Sudan (\u{202B}السودان\u{202C}\u{200E})"

        Suriname ->
            "Suriname"

        SvalbardandJanMayen ->
            "Svalbard and Jan Mayen"

        Swaziland ->
            "Swaziland"

        Sweden ->
            "Sweden (Sverige)"

        Switzerland ->
            "Switzerland (Schweiz)"

        Syria ->
            "Syria (\u{202B}سوريا\u{202C}\u{200E})"

        Taiwan ->
            "Taiwan (台灣)"

        Tajikistan ->
            "Tajikistan"

        Tanzania ->
            "Tanzania"

        Thailand ->
            "Thailand (ไทย)"

        Togo ->
            "Togo"

        Tokelau ->
            "Tokelau"

        Tonga ->
            "Tonga"

        TrinidadandTobago ->
            "Trinidad and Tobago"

        Tunisia ->
            "Tunisia (\u{202B}تونس\u{202C}\u{200E})"

        Turkey ->
            "Turkey (Türkiye)"

        Turkmenistan ->
            "Turkmenistan"

        TurksandCaicosIslands ->
            "Turks and Caicos Islands"

        Tuvalu ->
            "Tuvalu"

        USVirginIslands ->
            "U.S. Virgin Islands"

        Uganda ->
            "Uganda"

        Ukraine ->
            "Ukraine (Україна)"

        UnitedArabEmirates ->
            "United Arab Emirates (\u{202B}الإمارات العربية المتحدة\u{202C}\u{200E})"

        UnitedKingdom ->
            "United Kingdom"

        UnitedStates ->
            "United States"

        Uruguay ->
            "Uruguay"

        Uzbekistan ->
            "Uzbekistan (Oʻzbekiston)"

        Vanuatu ->
            "Vanuatu"

        Vatican ->
            "Vatican City (Città del Vaticano)"

        Venezuela ->
            "Venezuela"

        Vietnam ->
            "Vietnam (Việt Nam)"

        WallisandFutuna ->
            "Wallis and Futuna (Wallis-et-Futuna)"

        WesternSahara ->
            "Western Sahara (\u{202B}الصحراء الغربية\u{202C}\u{200E})"

        Yemen ->
            "Yemen (\u{202B}اليمن\u{202C}\u{200E})"

        Zambia ->
            "Zambia"

        Zimbabwe ->
            "Zimbabwe"


{-| -}
codeAndNameList : List { code : String, name : String }
codeAndNameList =
    List.map
        (\country ->
            { code = toCountryCode country
            , name = toString country
            }
        )
        list
