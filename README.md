# TimewIcal

Small Elixir server to convert [Timewarrior](https://timewarrior.net/) data files to an `ics` file format (readable by Google Calendar).

## Installation
1. Create a `config/config.exs` with the following contents:

```
import Config

config :timew_ical,
  timew_data_folder: ".../.timewarrior/data",
  port: 8000
```

2. Start the Elixir server: `iex -S mix`
3. Go to `localhost:8000`, and your `.ics` file will be downloaded.
4. (Optional) Host this service and point Google calendar at the corresponding `ics` link, and it will automatically be updated on your calendar.
