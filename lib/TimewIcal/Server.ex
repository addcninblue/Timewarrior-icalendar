defmodule TimewIcal.Server do
  import Plug.Conn
  require Logger

  @timew_data_folder Application.fetch_env!(:timew_ical, :timew_data_folder)

  def init(_opt) do
  end

  def call(conn, _opts) do
    Logger.info("Sending calendar.")

    conn
    |> put_resp_content_type("text/calendar")
    |> send_resp(200, generate_ics())
  end

  def generate_ics() do
    for data <- Path.wildcard("#{@timew_data_folder}/*-*.data") do
      File.read!(data)

      File.read!(data)
      |> String.split("\n")
      |> Enum.map(fn line ->
        Regex.named_captures(
          ~r/inc (?<start_time>\d{8}T\d{6}Z) - (?<end_time>\d{8}T\d{6}Z)(?: # (?<tags>.*))?/,
          line
        )
        |> case do
          nil ->
            nil

          captures ->
            %ICalendar.Event{
              summary: captures |> Map.get("tags", "Unlabeled Time"),
              dtstart: Map.get(captures, "start_time"),
              dtend: Map.get(captures, "end_time")
            }
        end
      end)
      |> Enum.filter(fn item -> !is_nil(item) end)
      |> Enum.to_list()
    end
    |> Enum.concat()
    |> (fn events -> %ICalendar{events: events} end).()
    |> ICalendar.to_ics()
  end
end
