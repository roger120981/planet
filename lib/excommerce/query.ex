defmodule Excommerce.Query do
  defmacro __using__([schema: schema]) do
    schema = Macro.expand(schema, __ENV__)
    quote location: :keep do
      import Ecto.Query

      defp by_id(id) do
        from m in unquote(schema),
          where: m.id == ^id
      end

      def get(repo, id) do
        repo.get(unquote(schema), id)
      end

      def get!(repo, id) do
        repo.get!(unquote(schema), id)
      end

      def all(repo) do
        repo.all(unquote(schema))
      end

      def get_by(repo, params) do
        repo.get_by(unquote(schema), params)
      end

      def get_by!(repo, params) do
        repo.get_by!(unquote(schema), params)
      end

    end
  end
end
