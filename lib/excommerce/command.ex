defmodule Excommerce.Command do
  defmacro __using__([schema: schema]) do
    schema = Macro.expand(schema, __ENV__)

    quote location: :keep do
      def insert!(repo, params) do
        unquote(schema).changeset(struct(unquote(schema)), params)
        |> repo.insert!
      end

      def update!(repo, existing, params) do
        unquote(schema).changeset(existing, params)
        |> repo.update!
      end

      def delete_all(repo) do
        repo.delete_all(unquote(schema))
      end

      def insert(repo, params) do
        unquote(schema).changeset(struct(unquote(schema)), params)
        |> repo.insert
      end

      def delete!(repo, existing) do
        repo.delete!(existing)
      end

      def update(repo, existing, params) do
        unquote(schema).changeset(existing, params)
        |> repo.update
      end

      defoverridable [insert!: 2, update!: 3, delete_all: 1, insert: 2, update: 3, delete!: 2]
    end
  end
end
