json.pagination do
  json.(object, :current_page, :next_page, :prev_page, :total_pages, :total_count)
end
