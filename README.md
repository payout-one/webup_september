# September

Code example from presentation.
[Slides](https://www.slideshare.net/quatermain1/elixir-after-2-years-in-action-code-webup)

_WebUP Zilina September 2019_

## Example

To run same examples you have to download datasets:
- [Indications](https://public.enigma.com/datasets/daily-weather-indications/d70070ae-5fce-4ccb-8b6f-c72f6ee5a75b)
- [Weather](https://public.enigma.com/datasets/national-climatic-weather-center-consolidated-weather-reports-1956/cc62066f-d7e4-4077-ac4e-d7cc09ceba33)

Example:
```elixir
:observer.start
FileLoad.run(%Enigma.Indication{}, "DailyWeatherIndications.csv")
```
