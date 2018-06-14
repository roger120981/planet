defmodule ExcommerceWeb.VariantImage do
  use Arc.Definition
  use Arc.Ecto.Definition
  
  @versions [:original]

  # @versions [:original, :thumb]
  # @extension_whitelist ~w(.jpg .jpeg .gif .png)

  # def acl(:thumb, _), do: :public

  #def validate({file, _}) do
    #file_extension = file.file_name |> Path.extname |> String.downcase
    #Enum.member?(@extension_whitelist, file_extension)
  #end

  #def transform(:thumb, _) do
   # {:convert, "-thumbnail 300x300^ -gravity center -extent 100x100 -format png"}
  #end

  #def filename(version, _) do
   # version
  #end

  #def storage_dir(_, {_file, variant}) do
   # "uploads/variant_images/#{variant.id}"
  #end

  #def default_url(:thumb) do
   # "uploads/no_image.jpg"
  #end
end
