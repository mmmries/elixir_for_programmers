defmodule GallowsWeb do
  def controller do
    quote do
      use Phoenix.Controller, namespace: GallowsWeb
      import Plug.Conn
      import GallowsWeb.Router.Helpers
      import GallowsWeb.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/gallows_web/templates",
                        namespace: GallowsWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import GallowsWeb.Router.Helpers
      import GallowsWeb.ErrorHelpers
      import GallowsWeb.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import GallowsWeb.Gettext
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
