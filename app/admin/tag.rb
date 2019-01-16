ActiveAdmin.register ActsAsTaggableOn::Tag, :as => "Tag" do
  permit_params :name, :taggings_count
end
