defmodule Silvia.Controller do
  use GenServer
  require Logger

  alias Silvia.Dashboard

  @me __MODULE__

  def start_link(_) do
    GenServer.start_link(__MODULE__, :noargs, name: @me)
  end

  def info(text) do
    GenServer.cast(@me, {:info, text})
  end

  def alert(text) do
    GenServer.cast(@me, {:alert, text})
  end

  def temperature(temp) do
    GenServer.cast(@me, {:temperature, temp})
  end

  def brew_temperature(temp) do
    GenServer.cast(@me, {:brew_temperature, temp})
  end

  def steam_temperature(temp) do
    GenServer.cast(@me, {:steam_temperature, temp})
  end

  def wifi(wifi_status) do
    GenServer.cast(@me, {:wifi, wifi_status})
  end

  def init(:noargs) do
    Logger.info("[#{inspect(@me)}] starting Controller GenServer")
    {:ok, %{}}
  end

  def handle_cast({:info, text}, state) do
    Logger.info("[#{inspect(@me)}] info: #{text}")
    {:noreply, state}
  end

  def handle_cast({:alert, text}, state) do
    Logger.info("[#{inspect(@me)}] alert: #{text}")
    {:noreply, state}
  end

  def handle_cast({:temperature, temp}, state) do
    Logger.info("[#{inspect(@me)}] temperature: #{inspect(temp)}")
    Dashboard.temperature(temp)
    {:noreply, state}
  end

  def handle_cast({:brew_temperature, temp}, state) do
    Logger.info("[#{inspect(@me)}] brew_temperature: #{inspect(temp)}")
    Dashboard.brew_temperature(temp)
    {:noreply, state}
  end

  def handle_cast({:steam_temperature, temp}, state) do
    Logger.info("[#{inspect(@me)}] steam_temperature: #{inspect(temp)}")
    Dashboard.steam_temperature(temp)
    {:noreply, state}
  end

  def handle_cast({:wifi, wifi_status}, state) do
    Logger.info("[#{inspect(@me)}] wifi: #{inspect(wifi_status)}")
    Dashboard.wifi_status(wifi_status)
    {:noreply, state}
  end

end