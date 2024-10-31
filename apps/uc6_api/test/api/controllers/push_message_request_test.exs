defmodule EHCS.UC6.API.DiiaPushRequestTest do
  use ExUnit.Case

  alias EHCS.UC6.API.ChangesetJSON
  alias EHCS.UC6.API.PushMessageRequest

  test "successful cast" do
    {:ok, request} =
      PushMessageRequest.cast(%{
        "tax_id" => "1234567898",
        "template_name" => "TEMPLATE_NAME",
        "template_parameters" => %{
          "key1" => "value1"
        }
      })

    assert request == %{
             tax_id: "1234567898",
             template_name: "TEMPLATE_NAME",
             template_parameters: %{
               "key1" => "value1"
             }
           }
  end

  test "cast with missing tax_id" do
    {:error, changeset} =
      PushMessageRequest.cast(%{
        "template_name" => "TEMPLATE_NAME",
        "template_parameters" => %{
          "key1" => "value1"
        }
      })

    assert ChangesetJSON.error(%{changeset: changeset}) ==
             %{errors: %{tax_id: ["can't be blank"]}}
  end

  test "cast with missing template_name" do
    {:error, changeset} =
      PushMessageRequest.cast(%{
        "tax_id" => "1234567898",
        "template_parameters" => %{
          "key1" => "value1"
        }
      })

    assert ChangesetJSON.error(%{changeset: changeset}) ==
             %{errors: %{template_name: ["can't be blank"]}}
  end

  test "cast with missing template_parameters" do
    {:ok, request} =
      PushMessageRequest.cast(%{
        "tax_id" => "1234567898",
        "template_name" => "TEMPLATE_NAME"
      })

    assert request == %{
             tax_id: "1234567898",
             template_name: "TEMPLATE_NAME",
             template_parameters: %{}
           }
  end

  test "cast with missing nil template_parameters" do
    {:ok, request} =
      PushMessageRequest.cast(%{
        "tax_id" => "1234567898",
        "template_name" => "TEMPLATE_NAME",
        "template_parameters" => nil
      })

    assert request == %{
             tax_id: "1234567898",
             template_name: "TEMPLATE_NAME",
             template_parameters: %{}
           }
  end
end
