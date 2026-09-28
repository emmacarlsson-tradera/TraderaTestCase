# Tradera iOS Case

En SwiftUI-app med två vyer: en produktlista som hämtas från Traderas produktflöde, och en lista över de produkter användaren har bevakat.

## Köra appen

Kräver Xcode 27 och simulatorn för iOS 27.

```sh
./run.sh                 # bygger och startar på iPhone 18 Pro
./run.sh "iPhone Air"    # eller på en annan simulator
```

Du kan också öppna `TraderaTestCase.xcodeproj` och trycka Cmd+R. Testerna körs med Cmd+U, eller:

```sh
xcodebuild test -project TraderaTestCase.xcodeproj -scheme TraderaTestCase \
  -destination "platform=iOS Simulator,name=iPhone 18 Pro"
```

## Vad som ingår

**Krav**
- Fliken Produkter har en rubrik och hämtar produkterna från produktflödet. Bild, titel och pris visas i ett rutnät med två kolumner.
- Varje produkt har ett hjärta för att bevaka den eller sluta bevaka den.
- Fliken Bevakade har en egen rubrik och visar alla bevakade produkter, var och en med ett hjärta för att ta bort den.
- En ändring i den ena fliken syns direkt i den andra.

**Nice to have**
- **Beständig lagring:** bevakningarna finns kvar när appen startas om.
- **Tester:** enhetstester för att lägga till, ta bort och lista bevakningar.
- **Tillgänglighet:** texten följer användarens textstorlek, VoiceOver-etiketterna nämner produkten, rubrikerna är markerade som rubriker och appen har mörkt läge.
- **Mer:** sökning i båda flikarna, en detaljvy för varje produkt, meddelanden när listan är tom eller sökningen inte ger något, samt Traderas färger och "logga".

## Hur appen är uppbyggd

| Fil | Ansvar |
|---|---|
| `ProductsViewModel` | Hämtar flödet, håller produkterna och de bevakade ID:na, sparar bevakningarna |
| `ContentView` | Flikraden och fliken Produkter |
| `FavoritesListView` | Fliken Bevakade |
| `ProductCardView` | Ett kort i rutnätet |
| `ProductDetailView` | Detaljvyn som öppnas när man trycker på ett kort |
| `TraderaColors`, `TraderaLogo` | Gemensam formgivning |

Båda flikarna delar **en och samma** `ProductsViewModel`. Listan med bevakningar sparas inte separat. Den räknas fram ur produkterna och mängden bevakade ID:n, så de två listorna kan aldrig hamna ur synk.

## Beslut och avvägningar

- **UserDefaults i stället för en databas.** Det enda som sparas är en lista med produkt-ID:n. SwiftData eller Core Data hade gjort appen mer komplicerad utan att ge något tillbaka.
- **ID:n sparas, inte hela produkter.** Produktdata som priser kan ändras, så den hämtas alltid färsk från flödet. Nackdelen är att fliken Bevakade blir tom om flödet inte går att hämta.
- **Rubrikerna ligger i listan i stället för som `navigationTitle`.** Navigeringslisten innehåller redan loggan och sökfältet, och en stor navigeringsrubrik gömde ett av dem. En vanlig rubrik gör att alla tre syns och växer med textstorleken. Den scrollar med innehållet i stället för att fällas ihop i listen.
- **Sökfältet ligger ovanför rubriken.** Sökningen är det viktigaste verktyget, så den står fast högst upp tillsammans med loggan. Rubriken hör ihop med listan den beskriver.

## Kända begränsningar och nästa steg

- **Laddning och fel:** det finns ingen laddningsindikator, och om hämtningen misslyckas skrivs felet bara ut i konsolen. Nästa steg är ett laddningsläge och en felvy med en knapp för att försöka igen.
- **Testbarhet:** ViewModel använder `UserDefaults.standard` direkt, så testerna rensar den före varje körning. Om lagringen skickades in utifrån skulle testerna kunna använda en egen.
- **Duplicerad kod:** rutnätet, sidhuvudet med loggan och sökfiltret finns i båda flikarna och skulle kunna flyttas till gemensamma vyer.
- **Valuta:** fältet `currency` i flödet används inte, utan priserna visas alltid som "kr".
- **"Köp nu"** i detaljvyn finns bara som design och gör ingenting.
- **Saknad bild:** "Back to the Future" visar en platshållare, eftersom bildadressen i flödet ger felkod 404.

## Hur jag har arbetat

Jag har byggt appen tillsammans med Claude som programmeringspartner. Jag har fattat besluten om design och funktion, testat varje steg i simulatorn och fått varje del förklarad för mig, så att jag har en förståelse över vad koden gör och varför.
