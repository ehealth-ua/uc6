defmodule EHCS.UC6.API.ErrorJSONTest do
  use EHCS.UC6.API.ConnCase, async: true

  test "renders 404" do
    assert EHCS.UC6.API.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert EHCS.UC6.API.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
