ActiveAdmin.register ActsAsTaggableOn::Tagging, as: "Tagging" do
  permit_params :tag_id, :taggable_type, :taggable_id, :tagger_type, :tagger_id, :context
end
