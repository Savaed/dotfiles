#!/usr/bin/env python

import itertools
from datetime import datetime, timedelta
from textwrap import dedent

import json
from typing import Literal
from urllib.request import urlopen
import argparse

BASE_URL_WEATHER = "https://api.open-meteo.com/v1"
BASE_URL_AIR = "https://air-quality-api.open-meteo.com/v1/air-quality"

Language = Literal["pl"]
Units = Literal["standard", "imperial", "metric"]


def create_url(base: str, location: tuple[float, float], **kwargs) -> str:
    lat, lon = location
    kwargs |= {"longitude": lon, "latitude": lat}
    url = f"{base}?"

    for k, v in kwargs.items():
        url += f"&{k}={v}"

    return url


def determine_direction_icon(degrees: float) -> str:
    degrees_range = 360 / 8
    degrees_ranges = list(itertools.pairwise((degrees_range * i for i in range(0, 9))))
    direction_codes_map = dict(
        zip(["", "", "", "", "", "", "", ""], degrees_ranges)
    )
    final_code = "unknown"

    for code, direction_range in direction_codes_map.items():
        start, stop = direction_range
        corrected_degrees = (degrees + (degrees_range / 2)) % 360

        if start <= corrected_degrees < stop:
            final_code = code
            break

    return final_code


def determine_weather_icon(code: str, is_day: bool) -> tuple[str, str]:
    code_map = {
        (0,): ("Bezchmurnie", "☀️" if is_day else "🌙"),
        (1,): ("Lekkie zachmurzenie", "🌤️" if is_day else "🌙"),
        (2,): ("Częściowe zachmurzenie", "⛅" if is_day else " "),
        (3,): ("Pochmurno", "☁️"),
        (45, 48): ("Mgła", "🌁" if is_day else "🌁"),
        (51, 53, 55): ("Mżawka", "🌦️" if is_day else " "),
        (56, 57): ("Marznąca mżawka", "🌨️" if is_day else " "),
        (61, 63, 65): ("Deszcz", "🌧️" if is_day else " "),
        (66, 67): ("Marznący deszcz", "🌨️" if is_day else " "),
        (71, 73, 75, 77): ("Śnieg", "❄️"),
        (80, 81, 82): ("Przelotny deszcz", "🌦️" if is_day else " "),
        (85, 86): ("Przelotny śnieg", "❄️ "),
        (95,): ("Burza", "🌩️ " if is_day else "🌩️"),
        (96, 99): ("Burza z gradem", "⛈️ " if is_day else " "),
    }
    return [v for k, v in code_map.items() if code in k][0]


def fetch_weather(location: tuple[float, float], num_days: int = 3):
    fields = [
        "temperature_2m",
        "relative_humidity_2m",
        "apparent_temperature",
        "pressure_msl",
        "cloud_cover",
        "wind_speed_10m",
        "wind_direction_10m",
        "wind_gusts_10m",
        "precipitation",
        "precipitation_probability",
        "weather_code",
        "visibility",
        "is_day",
    ]
    daily_fields = ["temperature_2m_max", "temperature_2m_min", "sunrise", "sunset"]
    daily_fields_str = ",".join(daily_fields)
    fields_str = ",".join(fields)
    url = create_url(
        f"{BASE_URL_WEATHER}/forecast",
        location=location,
        timezone="auto",
        current=fields_str,
        hourly=fields_str,
        daily=daily_fields_str,
        forecast_days=num_days,
    )

    with urlopen(url) as req:
        response = json.loads(req.read().decode("utf-8"))

    hourly_data = response["hourly"]
    current_time = datetime.fromisoformat(response["current"]["time"])

    indexes = [
        hourly_data["time"].index(d)
        for d in hourly_data["time"]
        if datetime.fromisoformat(d).hour in (0, 3, 6, 9, 12, 15, 18, 21)
        and datetime.fromisoformat(d) > current_time
    ]

    hourly = [
        {
            "time": datetime.fromisoformat(hourly_data["time"][i]).isoformat(),
            "hour": datetime.fromisoformat(hourly_data["time"][i]).strftime("%H"),
            "temperature": hourly_data["temperature_2m"][i],
            "humidity": hourly_data["relative_humidity_2m"][i],
            "apparent_temperature": hourly_data["apparent_temperature"][i],
            "precipitation": hourly_data["precipitation"][i],
            "precipitation_probability": hourly_data["precipitation_probability"][i],
            "icon": determine_weather_icon(
                hourly_data["weather_code"][i], bool(hourly_data["is_day"][i])
            ),
            "clouds": hourly_data["cloud_cover"][i],
            "pressure": hourly_data["pressure_msl"][i],
            "wind_speed": hourly_data["wind_speed_10m"][i],
            "visibility": hourly_data["visibility"][i] / 1000,
            "wind_gusts": hourly_data["wind_gusts_10m"][i],
            "wind_direction": determine_direction_icon(
                hourly_data["wind_direction_10m"][i]
            ),
        }
        for i in indexes
    ]

    current = {
        "latitude": response["latitude"],
        "longitude": response["longitude"],
        "time": datetime.fromisoformat(response["current"]["time"]).isoformat(),
        "temperature": response["current"]["temperature_2m"],
        "humidity": response["current"]["relative_humidity_2m"],
        "visibility": response["current"]["visibility"] / 1000,  # m -> km
        "apparent_temperature": response["current"]["apparent_temperature"],
        "precipitation": response["current"]["precipitation"],
        "precipitation_probability": response["current"]["precipitation_probability"],
        "icon": determine_weather_icon(
            response["current"]["weather_code"], response["current"]["is_day"]
        ),
        "clouds": response["current"]["cloud_cover"],
        "pressure": f"{response['current']['pressure_msl']:.0f}",
        "wind_speed": response["current"]["wind_speed_10m"],
        "wind_gusts": response["current"]["wind_gusts_10m"],
        "wind_direction": determine_direction_icon(
            response["current"]["wind_direction_10m"],
        ),
        "temperature_min": response["daily"]["temperature_2m_min"][
            0
        ],  # daily[x][0] is the current day
        "temperature_max": response["daily"]["temperature_2m_max"][0],
        "sunrise": datetime.fromisoformat(response["daily"]["sunrise"][0]).strftime(
            "%H:%M"
        ),
        "sunset": datetime.fromisoformat(response["daily"]["sunset"][0]).strftime(
            "%H:%M"
        ),
    }

    return {"current": current, "hourly": hourly}


def determine_european_aqi_icon(aqi: int) -> str:
    if aqi <= 20:
        return " "
    if aqi <= 40:
        return " "
    if aqi <= 60:
        return " "
    if aqi <= 80:
        return "󱖇 "
    if aqi <= 100:
        return "󱡞 "

    return " "


def fetch_air_pollution(location: tuple[float, float]):
    fields = ["european_aqi", "pm10", "pm2_5", "uv_index"]
    fields_str = ",".join(fields)
    url = create_url(
        BASE_URL_AIR,
        location=location,
        timezone="auto",
        current=fields_str,
    )

    with urlopen(url) as req:
        response = json.loads(req.read().decode("utf-8"))

    return {
        "aqi": response["current"]["european_aqi"],
        "aqi_icon": determine_european_aqi_icon(response["current"]["european_aqi"]),
        "pm10": response["current"]["pm10"],
        "pm2_5": response["current"]["pm2_5"],
        "uv_index": response["current"]["uv_index"],
    }


def format_tooltip(weather: dict) -> str:
    current_weather = weather["current"]

    header = f"""\
    \t\t<span size='xx-large'>{current_weather['temperature']}°C</span>

    <span size='xx-large'>{current_weather['icon'][1]}</span>{current_weather['icon'][0]}

    <span size='x-large'>{current_weather['wind_direction']:<1}</span> {current_weather['wind_speed']} (do {current_weather['wind_gusts']}) km/h\t<big>{' ':<2}</big>{current_weather['uv_index']} 
    <big>{'':<2}</big>{current_weather['apparent_temperature']}°C\t\t<big>{' ':<2}</big>{current_weather['clouds']}%
    <big>{'󱪆 ':<2}</big>{current_weather['humidity']}%\t\t\t<big>{current_weather['aqi_icon']:<2}</big>{current_weather['aqi']} AQI
    <big>{' ':<2}</big>{current_weather['pressure']} hPa\t\t<big>{' ':<2}</big>{current_weather['visibility']:0.2f} km
    <big>{'󰖎':<2}</big>{current_weather['precipitation_probability']}%\t\t\t<big>{'󰸊':<2}</big>{current_weather['precipitation']} mm
    <big>{' ':<2}</big>{current_weather['sunrise']}\t\t<big>{' ':<2}</big>{current_weather['sunset']}
    """

    forecast = [
        f"{d['hour']} <span size='x-large'>{d['icon'][1]:<2}</span>{d['temperature']:>5}°C  <span size='x-large'>{d['wind_direction']}</span>{d['wind_speed']:<4} km/h  <big>󰖌</big>{d['precipitation']:<4} mm ({d['precipitation_probability']}%)"
        for d in weather["hourly"]
    ]

    day_start_index = [d["hour"] for d in weather["hourly"]].index("00")
    current_time = datetime.fromisoformat(current_weather["time"])
    tommorow = current_time + timedelta(days=1)
    two_days = current_time + timedelta(days=2)

    forecast.insert(
        day_start_index,
        f"\n<span weight='bold'>------------- jutro ({tommorow.strftime('%d.%m')}) --------------</span>",
    )
    forecast.insert(
        day_start_index + 9,
        f"\n<span weight='bold'>------------ pojutrze ({two_days.strftime('%d.%m')}) ------------</span>",
    )

    forecast_str = "<span weight='normal'>" + "\n".join(forecast)

    if "jutro" not in forecast[0]:
        header += "\n"

    footer = f"<small>\n\nLokalizacja: ({current_weather['latitude']}, {current_weather['longitude']})\nDane: Open-Meteo.com | {current_weather['time']}</small></span>"
    return dedent(header) + forecast_str + footer


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--lat", type=float, help="Latitude")
    parser.add_argument("--lon", type=float, help="Longitude")

    args = parser.parse_args()

    air = fetch_air_pollution(location=(args.lat, args.lon))
    weather = fetch_weather(location=(args.lat, args.lon))
    weather["current"] |= air
    data = {
        "text": f"{weather['current']['icon'][1]} {weather['current']['temperature']}°C",
        "tooltip": format_tooltip(weather),
    }
    print(json.dumps(data))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
