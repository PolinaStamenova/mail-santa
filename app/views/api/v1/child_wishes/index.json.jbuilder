json.array! @child_wishes do |child_wish|
  json.child_id child_wish.user.id
  json.present do
    json.id child_wish.present.id
    json.name child_wish.present.name
    json.color child_wish.present.color
    json.size child_wish.present.size
  end
  json.reference_number child_wish.id
end
