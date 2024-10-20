defmodule SilviaWeb.HomeTest do
  use SilviaWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  alias Silvia.Dashboard

  test "should load the dashboard", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Dashboard"
  end

  test "should display the current temperature", %{conn: conn} do
    Dashboard.temperature(100)
    {:ok, view, _html} = live(conn, "/")
    assert view
      |> element("#current_temperature")
      |> render =~ "100C"
  end

  test "should increase the brew temperature", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    before_update = dashboard_info().brew_temperature
    render_click(view, "brew-up", %{})
    after_update = dashboard_info().brew_temperature
    assert after_update == before_update + 1
  end

  test "should decrease the brew temperature", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    before_update = dashboard_info().brew_temperature
    render_click(view, "brew-down", %{})
    after_update = dashboard_info().brew_temperature
    assert after_update == before_update - 1
  end

  test "should increase the steam temperature", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    before_update = dashboard_info().steam_temperature
    render_click(view, "steam-up", %{})
    after_update = dashboard_info().steam_temperature
    assert after_update == before_update + 1
  end

  test "should decrease the steam temperature", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    before_update = dashboard_info().steam_temperature
    render_click(view, "steam-down", %{})
    after_update = dashboard_info().steam_temperature
    assert after_update == before_update - 1
  end

  defp dashboard_info() do
    Dashboard.dashboard_info()
  end
end