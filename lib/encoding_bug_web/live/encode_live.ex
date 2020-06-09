defmodule EncodingBugWeb.EncodeLive do
  use EncodingBugWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(i: 0)
     |> assign(a: "HiThere")
     |> assign(b: "Hi There")}
  end

  @impl true
  def render(assigns) do
    ~L"""
      <p>Click the update button to update the a & b assigns</p>
      <div id="a" data-a=<%= @a %>>a should update here: <%= @a %></div>
      <div id="b" data-b=<%= @b %>>b should update here: <%= @b %></div>
      <p>A updates, but b doesn't update - it gets scrambled in the div data attribute due to the embedded space. There's an error in the console too</p>

      <button id="btn" phx-click="update_thingz">Update</button>
    """
  end

  @impl true
  def handle_event("update_thingz", _, socket) do
    i = socket.assigns.i + 1

    {:noreply,
     socket
     |> assign(i: i)
     |> assign(a: "\"Hello#{socket.assigns.i}\"")
     |> assign(b: "\"Hello #{socket.assigns.i}\"")}
  end
end
