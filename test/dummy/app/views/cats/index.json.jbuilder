json.partial! 'partial/paginate_meta', object: @cats
json.items @cats do |cat|
  json.(cat, :id, :name, :created_at, :updated_at)
end